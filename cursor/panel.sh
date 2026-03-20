#!/bin/bash

echo "╔══════════════════════════════╗"
echo "║     Cursor Agent Panel       ║"
echo "╚══════════════════════════════╝"
echo ""

if command -v git &> /dev/null && git rev-parse --is-inside-work-tree &> /dev/null 2>&1; then
  BRANCH=$(git branch --show-current 2>/dev/null)
  REPO=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
  STATUS=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  echo "📂 $REPO ($BRANCH)"
  echo "   변경: ${STATUS}개 파일"
  echo ""
fi

echo "⏰ $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

if command -v node &> /dev/null; then
  echo "📌 Node $(node -v 2>/dev/null)"
fi

echo ""
echo "─────────────────────────────"
echo "Ctrl+p: pane | Ctrl+t: tab"
echo "Ctrl+n: resize | Ctrl+g: lock"
