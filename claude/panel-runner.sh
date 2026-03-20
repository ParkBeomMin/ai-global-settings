#!/bin/bash
# 깜빡임 없이 패널을 갱신하는 러너
# 출력을 먼저 버퍼에 담고, 커서만 위로 올려 덮어씀 (화면을 지우지 않음)

while true; do
  # 1) 출력 미리 생성 (이 동안 화면은 그대로)
  output=$(bash ~/.claude/panel.sh 2>/dev/null)

  # 2) 커서를 (0,0)으로 이동 (화면 지우기 없음)
  printf '\033[H'

  # 3) 줄별로 덮어쓰기 + 줄 끝 나머지 지우기
  while IFS= read -r line; do
    printf '%s\033[K\n' "$line"
  done <<< "$output"

  # 4) 이전 출력이 더 길었을 경우 남은 줄 제거
  printf '\033[J'

  sleep 5
done
