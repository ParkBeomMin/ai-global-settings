#!/bin/bash
# claude 실행 시 zellij claude 레이아웃 자동 적용
# .zshrc에 아래 라인 추가: source ~/Workspace/ai-global-settings/scripts/claude-zellij.sh

claude() {
  if [ -z "$ZELLIJ" ]; then
    # args가 있으면 임시 파일에 저장 (레이아웃 pane에서 읽음)
    if [ $# -gt 0 ]; then
      echo "$@" > /tmp/claude-args
    else
      rm -f /tmp/claude-args
    fi
    zellij -l claude
  else
    command claude "$@"
  fi
}
