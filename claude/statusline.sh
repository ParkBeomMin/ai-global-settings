#!/bin/bash
# Claude Code statusLine 래퍼
# stdin으로 받은 세션 데이터를 statusline.json에 저장하고
# claude-hud로 넘겨 상태바 텍스트 출력

input=$(cat)
status_file="${ZELLIJ_SESSION_NAME:+/tmp/claude-status-${ZELLIJ_SESSION_NAME}.json}"
status_file="${status_file:-$HOME/.claude/statusline.json}"
echo "$input" > "$status_file"
echo "$input" | node "$HOME/.claude/plugins/marketplaces/claude-hud/dist/index.js"
