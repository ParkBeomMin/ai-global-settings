#!/bin/bash
# 스크롤백 버퍼까지 지우고 덮어씌워서 스크롤 누적 방지

while true; do
  output=$(bash ~/.claude/panel.sh 2>/dev/null)
  # \033[2J: 화면 지우기, \033[3J: 스크롤백 버퍼 지우기, \033[H: 커서 홈
  printf '\033[2J\033[3J\033[H'
  printf '%s\n' "$output"
  sleep 5
done
