#!/bin/bash
# cursor agent 실행 시 zellij cursor 레이아웃 자동 적용
# .zshrc에 아래 라인 추가: source ~/Workspace/ai-global-settings/scripts/cursor-zellij.sh

cursor() {
  local real_cursor
  real_cursor=$(command -v cursor)

  if [ -z "$real_cursor" ]; then
    echo "cursor CLI를 찾을 수 없습니다."
    return 1
  fi

  if [ "$1" = "agent" ] && [ -z "$ZELLIJ" ]; then
    shift
    if [ $# -gt 0 ]; then
      echo "$*" > /tmp/cursor-args
    else
      rm -f /tmp/cursor-args
    fi
    zellij --layout cursor
  else
    command cursor "$@"
  fi
}

agent() {
  if [ -z "$ZELLIJ" ]; then
    if [ $# -gt 0 ]; then
      echo "$*" > /tmp/cursor-args
    else
      rm -f /tmp/cursor-args
    fi
    zellij --layout cursor
  else
    command agent "$@"
  fi
}
