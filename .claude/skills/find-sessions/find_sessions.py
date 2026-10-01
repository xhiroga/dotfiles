#!/usr/bin/env python3
"""過去の Claude Code セッション (transcript) をタイトル / ユーザー発言から検索する。

~/.claude/projects/<project>/<session-id>.jsonl を舐めて軽量 index を作り、
title (custom-title > ai-title) と人間の発言を対象に AND 検索する。
--content を付けると ripgrep で transcript 全文 (tool 出力込み) も対象にする。
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import time
from datetime import datetime, timedelta
from pathlib import Path

PROJECTS_DIR = Path(os.environ.get("CLAUDE_PROJECTS_DIR", Path.home() / ".claude" / "projects"))
CACHE_PATH = (
    Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache"))
    / "claude-find-sessions"
    / "index.jsonl"
)
INDEX_VERSION = 1

# 人間の発言でないもの (IDE 注入・system-reminder・slash command 展開など)
NOISE_PREFIXES = (
    "<ide_",
    "<system-reminder",
    "<command-name>",
    "<command-message>",
    "<command-args>",
    "<local-command",
    "<user-memory",
    "<task-notification",
    "Caveat:",
    "[Request interrupted",
)
MAX_PROMPTS = 60
MAX_PROMPT_CHARS = 400


def iter_transcripts(projects_dir: Path):
    if not projects_dir.is_dir():
        sys.exit(f"projects dir not found: {projects_dir}")
    for path in projects_dir.glob("*/*.jsonl"):
        if path.is_file():
            yield path


def extract_texts(obj: dict) -> list[str]:
    message = obj.get("message") or {}
    content = message.get("content")
    if isinstance(content, str):
        blocks = [content]
    elif isinstance(content, list):
        blocks = [b.get("text", "") for b in content if isinstance(b, dict) and b.get("type") == "text"]
    else:
        return []
    out = []
    for text in blocks:
        text = (text or "").strip()
        if not text or text.startswith(NOISE_PREFIXES):
            continue
        out.append(text)
    return out


def scan(path: Path) -> dict:
    """1 セッション分の transcript を 1 パスで読み、index レコードを作る。"""
    stat = path.stat()
    rec = {
        "v": INDEX_VERSION,
        "path": str(path),
        "mtime": stat.st_mtime,
        "size": stat.st_size,
        "session_id": path.stem,
        "project": path.parent.name,
        "cwd": None,
        "branch": None,
        "title": None,
        "prompts": [],
        "started": None,
        "turns": 0,
    }
    with path.open("r", encoding="utf-8", errors="replace") as fh:
        for line in fh:
            # title 行は小さく、セッション中に何度も上書きされる (最後の 1 本が正)
            if '-title"' in line[:48]:
                try:
                    obj = json.loads(line)
                except ValueError:
                    continue
                title = obj.get("customTitle") or obj.get("aiTitle")
                if title:
                    rec["title"] = title.strip()
                continue
            if '"type":"user"' not in line:
                continue
            if '"toolUseResult"' in line or '"isSidechain":true' in line:
                continue  # tool 結果 / subagent 側の発話は人間の発言ではない
            try:
                obj = json.loads(line)
            except ValueError:
                continue
            if obj.get("type") != "user":
                continue
            if rec["started"] is None:
                rec["started"] = obj.get("timestamp")
            if rec["cwd"] is None:
                rec["cwd"] = obj.get("cwd")
                rec["branch"] = obj.get("gitBranch")
            for text in extract_texts(obj):
                rec["turns"] += 1
                if len(rec["prompts"]) < MAX_PROMPTS:
                    rec["prompts"].append(text[:MAX_PROMPT_CHARS])
    return rec


def load_cache() -> dict[str, dict]:
    if not CACHE_PATH.exists():
        return {}
    cache = {}
    with CACHE_PATH.open("r", encoding="utf-8") as fh:
        for line in fh:
            try:
                rec = json.loads(line)
            except ValueError:
                continue
            if rec.get("v") == INDEX_VERSION and rec.get("path"):
                cache[rec["path"]] = rec
    return cache


def save_cache(records: list[dict]) -> None:
    CACHE_PATH.parent.mkdir(parents=True, exist_ok=True)
    tmp = CACHE_PATH.with_suffix(".tmp")
    with tmp.open("w", encoding="utf-8") as fh:
        for rec in records:
            fh.write(json.dumps(rec, ensure_ascii=False) + "\n")
    tmp.replace(CACHE_PATH)


def build_index(rebuild: bool = False, quiet: bool = False) -> list[dict]:
    cache = {} if rebuild else load_cache()
    records, scanned = [], 0
    started = time.time()
    for path in iter_transcripts(PROJECTS_DIR):
        stat = path.stat()
        cached = cache.get(str(path))
        if cached and cached.get("mtime") == stat.st_mtime and cached.get("size") == stat.st_size:
            records.append(cached)
            continue
        records.append(scan(path))
        scanned += 1
        if not quiet and scanned % 200 == 0:
            print(f"  indexing... {scanned} sessions", file=sys.stderr)
    if scanned and not quiet:
        print(f"  indexed {scanned} new/changed sessions in {time.time() - started:.1f}s", file=sys.stderr)
    save_cache(records)
    return records


def content_candidates(terms: list[str], regex: bool, paths: list[str]) -> set[str]:
    """--content 用。transcript 全文を grep して候補ファイルを絞る (AND)。"""
    hit: set[str] | None = None
    for term in terms:
        found: set[str] = set()
        for i in range(0, len(paths), 800):  # ARG_MAX 対策
            cmd = ["grep", "-l", "-i", "-E" if regex else "-F", "-e", term, "--", *paths[i : i + 800]]
            proc = subprocess.run(cmd, capture_output=True, text=True)
            found.update(line for line in proc.stdout.splitlines() if line)
        hit = found if hit is None else (hit & found)
        if not hit:
            return set()
    return hit or set()


def matches(rec: dict, terms: list[str], regex: bool, content_hits: set[str] | None) -> str | None:
    """全 term にヒットしたら、根拠になった snippet を返す。"""
    haystack = "\n".join([rec.get("title") or "", *rec.get("prompts", [])])
    lowered = haystack.lower()
    snippet = None
    for term in terms:
        if regex:
            found = re.search(term, haystack, re.IGNORECASE)
            pos = found.start() if found else -1
        else:
            pos = lowered.find(term.lower())
        if pos < 0:
            if content_hits is not None and rec["path"] in content_hits:
                continue  # 全文側でヒットしている
            return None
        if snippet is None:
            snippet = haystack[max(0, pos - 60) : pos + 140].replace("\n", " ")
    return snippet or (rec["prompts"][0] if rec.get("prompts") else "")


def fmt_time(rec: dict) -> str:
    return datetime.fromtimestamp(rec["mtime"]).strftime("%Y-%m-%d %H:%M")


def deeplink(session_id: str) -> str:
    return f"vscode://anthropic.claude-code/open?session={session_id}"


def print_results(results: list[tuple[dict, str]], as_json: bool) -> None:
    if as_json:
        payload = [
            {
                "session_id": rec["session_id"],
                "title": rec.get("title"),
                "last_active": datetime.fromtimestamp(rec["mtime"]).isoformat(timespec="seconds"),
                "project": rec["project"],
                "cwd": rec.get("cwd"),
                "branch": rec.get("branch"),
                "turns": rec.get("turns", 0),
                "path": rec["path"],
                "deeplink": deeplink(rec["session_id"]),
                "snippet": snippet,
            }
            for rec, snippet in results
        ]
        print(json.dumps(payload, ensure_ascii=False, indent=2))
        return
    if not results:
        print("該当なし")
        return
    for rec, snippet in results:
        title = rec.get("title") or "(タイトルなし)"
        print(f"{fmt_time(rec)}  {title}")
        print(f"  {rec['session_id']}  {rec['project']}  turns={rec.get('turns', 0)}")
        print(f"  [開く]({deeplink(rec['session_id'])})")
        if snippet:
            print(f"  > {re.sub(r'\s+', ' ', snippet).strip()[:160]}")
        print()


def cmd_show(session_id: str, full: bool) -> None:
    hits = list(PROJECTS_DIR.glob(f"*/{session_id}*.jsonl"))
    if not hits:
        sys.exit(f"session not found: {session_id}")
    path = max(hits, key=lambda p: p.stat().st_mtime)
    rec = scan(path)
    print(f"title  : {rec.get('title') or '(タイトルなし)'}")
    print(f"session: {rec['session_id']}")
    print(f"project: {rec['project']}  cwd={rec.get('cwd')}  branch={rec.get('branch')}")
    print(f"active : {rec.get('started')} -> {fmt_time(rec)}")
    print(f"link   : [開く]({deeplink(rec['session_id'])})")
    print(f"file   : {rec['path']}")
    print()
    with path.open("r", encoding="utf-8", errors="replace") as fh:
        for line in fh:
            if '"isSidechain":true' in line or '"toolUseResult"' in line:
                continue
            if '"type":"user"' not in line and not (full and '"type":"assistant"' in line):
                continue
            try:
                obj = json.loads(line)
            except ValueError:
                continue
            kind = obj.get("type")
            if kind not in ("user", "assistant") or (kind == "assistant" and not full):
                continue
            texts = extract_texts(obj)
            if not texts:
                continue
            stamp = (obj.get("timestamp") or "")[:16].replace("T", " ")
            label = "user" if kind == "user" else "asst"
            for text in texts:
                body = text if full else text[:600]
                print(f"[{stamp}] {label}: {body}")
                print()


def main() -> None:
    parser = argparse.ArgumentParser(description="過去の Claude Code セッションを検索する")
    parser.add_argument("query", nargs="*", help="検索語 (複数指定は AND)")
    parser.add_argument("--limit", type=int, default=20, help="表示件数 (default 20, 0 で全件)")
    parser.add_argument("--days", type=int, help="直近 N 日に絞る")
    parser.add_argument("--project", help="project ディレクトリ名 / cwd の部分一致で絞る")
    parser.add_argument("--content", action="store_true", help="transcript 全文 (tool 出力込み) も検索対象にする")
    parser.add_argument(
        "--untitled",
        action="store_true",
        help="タイトル未生成の 1 往復セッション (スクリプトからの one-shot 呼び出し等) も含める",
    )
    parser.add_argument("--regex", action="store_true", help="検索語を正規表現として扱う")
    parser.add_argument("--json", action="store_true", help="JSON で出力")
    parser.add_argument("--rebuild", action="store_true", help="index を作り直す")
    parser.add_argument("--show", metavar="SESSION_ID", help="1 セッションの発言を時系列で表示")
    parser.add_argument("--full", action="store_true", help="--show でアシスタント発言も出す")
    args = parser.parse_args()

    if args.show:
        cmd_show(args.show, args.full)
        return

    records = build_index(rebuild=args.rebuild, quiet=args.json)

    if not args.untitled:
        # title が付く前に終わった 1 往復セッションは会話ではなくスクリプト実行のことが多い
        records = [r for r in records if r.get("title") or r.get("turns", 0) > 1]
    if args.days:
        cutoff = (datetime.now() - timedelta(days=args.days)).timestamp()
        records = [r for r in records if r["mtime"] >= cutoff]
    if args.project:
        needle = args.project.lower()
        records = [
            r for r in records if needle in r["project"].lower() or needle in (r.get("cwd") or "").lower()
        ]

    if args.query:
        content_hits = (
            content_candidates(args.query, args.regex, [r["path"] for r in records])
            if args.content
            else None
        )
        results = []
        for rec in records:
            snippet = matches(rec, args.query, args.regex, content_hits)
            if snippet is not None:
                results.append((rec, snippet))
    else:
        results = [(rec, (rec["prompts"][0] if rec.get("prompts") else "")) for rec in records]

    results.sort(key=lambda pair: pair[0]["mtime"], reverse=True)
    total = len(results)
    if args.limit:
        results = results[: args.limit]
    if not args.json:
        print(f"{total} 件ヒット (表示 {len(results)} 件)\n")
    print_results(results, args.json)


if __name__ == "__main__":
    main()
