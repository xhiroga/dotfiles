---
name: find-sessions
description: 過去の Claude Code セッション (会話) をキーワードで検索し、セッション名 (title) / セッション ID / 再開用 deep link を返す skill。「あの話したのどのセッションだっけ」「先週の○○の相談を探して」「前に調べてもらった件のセッション名教えて」等で呼ぶ。会話の中身の確認 (誰が何を言ったか) までを扱い、そこからの実作業は各 skill の管轄。
---

## 用語

Claude Code では 1 本の会話を session と呼ぶ。用語としてこれで正しい。

- session: 会話 1 本。UUID の session ID を持つ。VS Code 拡張ではタブ 1 枚に対応する
- title: セッションの表示名。数往復すると自動生成され (`ai-title`)、会話が進むと何度も更新される。手で付け直したものは `custom-title` (`/done` の ✅️ もこれ)。「セッション名」はこの title のこと
- transcript: セッション本体の記録。`~/.claude/projects/<cwd をスラッシュ置換した名前>/<session-id>.jsonl` に 1 行 1 イベントの JSONL で入る

この skill は transcript を舐めて title と人間の発言だけを抜いた index を作り、そこを検索する。

## 実行

```sh
python3 ~/.claude/skills/find-sessions/find_sessions.py 西村 リリース          # AND 検索
python3 ~/.claude/skills/find-sessions/find_sessions.py --days 7               # 直近 7 日を新しい順に一覧
python3 ~/.claude/skills/find-sessions/find_sessions.py publish --content      # tool 出力やコード片まで全文検索
python3 ~/.claude/skills/find-sessions/find_sessions.py --show <session-id>    # そのセッションの発言を時系列で読む
```

- 検索対象は既定で title + 人間の発言。ユーザーが覚えているのは自分が言ったことなので、まずこれで当てる
- `--content`: transcript 全文 (assistant 発言・tool 出力・貼り付けログ) も対象。ファイル名・エラー文字列・コマンド名で探すとき用
- `--regex`: 検索語を正規表現として扱う
- `--days N` / `--project <部分一致>`: 期間・プロジェクト (ディレクトリ名か cwd) で絞る
- `--limit N` (default 20, `0` で全件) / `--json`
- `--untitled`: 既定で除外している「title 未生成の 1 往復セッション」も含める
- `--rebuild`: index を作り直す (壊れた・取りこぼしが疑われるとき)
- `--show <session-id> [--full]`: 1 セッションの中身を読む。`--full` で assistant 発言も全文出す。ID は前方一致でよい

## 出力の読み方

```
2026-07-23 17:14  リリース日7月30日の反映方法確認
  5948dd59-789d-44db-8690-75fab6415382  -workspaces-anilink  turns=3
  [開く](vscode://anthropic.claude-code/open?session=5948dd59-789d-44db-8690-75fab6415382)
  > リリース日が7/30に決まりました。どこに反映しましょうか？（経営計画？）
```

1 行目が最終更新日時とセッション名、2 行目が session ID / プロジェクト / 人間の発言数、3 行目が再開リンク、4 行目がヒット箇所の抜粋。

ユーザーに返すときはセッション名と deep link を Markdown リンクのまま出す (`/deeplink` と同じ形式でクリックして開ける)。CLI から再開するなら `claude --resume <session-id>`。

## 使い方の型

1. ユーザーの言葉そのままで 1 回引く。固有名詞 (人名・スタジオ名・issue 番号) が一番効く
2. 0 件なら語を減らす → 表記揺れを変える (漢字/かな/英字) → `--content` に上げる
3. 候補が複数出たら `--show` で中身を確認してから「これですね」と返す。title だけで断定しない (title は会話の途中経過で付くので、後半の話題を表していないことがある)

## 注意点

- index は `~/.cache/claude-find-sessions/index.jsonl` にキャッシュされ、mtime + size が変わった transcript だけ読み直す。初回は数秒、以降は 0.1 秒程度
- `-workspaces-anilink-anilinkjp` 配下には スクリプトから one-shot で呼ばれた 1 往復セッションが数千本ある。既定ではこれらを落としている (`--untitled` で復活)
- subagent (sidechain) の発話と tool 結果は人間の発言として数えない。`--content` なら本文として拾える
- title は会話中に何度も更新される。index は最後の 1 本を採る
- 検索できるのはローカルに残っている transcript だけ。別マシン・別コンテナのセッションは対象外
