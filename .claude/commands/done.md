---
description: 現在のセッションタイトルの冒頭に ✅️ を付けて完了マークする
allowed-tools: Bash(ls:*), Bash(grep:*), Bash(jq:*), Bash(sed:*), Bash(printf:*), Bash(bash:*)
---

セッションを完了としてマークしました。

!`bash -c 'set -e; SID="$CLAUDE_CODE_SESSION_ID"; F=$(ls $HOME/.claude/projects/*/"$SID".jsonl 2>/dev/null | head -1); [ -z "$F" ] && { echo "session jsonl not found for $SID"; exit 1; }; CUR=$(grep -h "\"type\":\"custom-title\"" "$F" | tail -1 | jq -r .customTitle); [ -z "$CUR" ] && CUR=$(grep -h "\"type\":\"ai-title\"" "$F" | tail -1 | jq -r .aiTitle); [ -z "$CUR" ] && { echo "no title yet"; exit 1; }; BASE=$(printf "%s" "$CUR" | sed "s/^✅️*[[:space:]]*//"); jq -cn --arg sid "$SID" --arg t "✅️ $BASE" "{type:\"custom-title\",sessionId:\$sid,customTitle:\$t}" >> "$F"; echo "title -> ✅️ $BASE (reload で反映)"'`
