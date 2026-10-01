---
description: 現在のセッションを開く vscode:// deep link を Markdown リンクで返す (bf-0120)
allowed-tools: Bash(ls:*), Bash(grep:*), Bash(jq:*), Bash(printf:*), Bash(bash:*)
---

以下の実行結果のリンク 1 行を、```md フェンス付きコードブロックに入れてそのまま返すこと。前置き・解説・他の文は一切書かない。

!`bash -c 'set -e; SID="$CLAUDE_CODE_SESSION_ID"; F=$(ls $HOME/.claude/projects/*/"$SID".jsonl 2>/dev/null | head -1); [ -z "$F" ] && { echo "session jsonl not found for $SID"; exit 1; }; T=$(grep -h "\"type\":\"custom-title\"" "$F" | tail -1 | jq -r .customTitle); [ -z "$T" ] && T=$(grep -h "\"type\":\"ai-title\"" "$F" | tail -1 | jq -r .aiTitle); [ -z "$T" ] && T="$SID"; printf "[%s](vscode://anthropic.claude-code/open?session=%s)\n" "$T" "$SID"'`
