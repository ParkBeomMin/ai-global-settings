#!/bin/bash
# ~/.cursor/panel.sh - Cursor CLI right-side status panel

RESET='\033[0m'
DIM='\033[2m'
BOLD='\033[1m'
BLUE='\033[38;5;74m'
GREEN='\033[38;5;114m'
YELLOW='\033[38;5;179m'
RED='\033[38;5;203m'
MUTED='\033[38;5;245m'
WHITE='\033[97m'
CYAN='\033[38;5;110m'
PURPLE='\033[38;5;141m'

WIDTH=34

divider() {
  printf "${DIM}"
  printf '─%.0s' $(seq 1 $WIDTH)
  printf "${RESET}\n"
}

# ── Header ────────────────────────────────────
printf "\n"
printf "  ${BOLD}${PURPLE}▌${RESET}${BOLD}${WHITE} Cursor CLI${RESET}\n"
printf "  ${MUTED}%s   %s${RESET}\n" "$(date '+%Y.%m.%d %a')" "$(date '+%H:%M')"
printf "\n"

# ── Model ─────────────────────────────────────
MODEL_CACHE="$HOME/.cursor/panel-model-cache"
if [ ! -f "$MODEL_CACHE" ] || [ $(($(date +%s) - $(stat -f%m "$MODEL_CACHE" 2>/dev/null || echo 0))) -gt 300 ]; then
  model_line=$(cursor agent --list-models 2>/dev/null | grep "(current" | head -1)
  if [ -n "$model_line" ]; then
    model_name=$(echo "$model_line" | sed 's/ *(current.*//; s/^[^ ]* - //')
    echo "$model_name" > "$MODEL_CACHE"
  fi
fi
CURRENT_MODEL=$(cat "$MODEL_CACHE" 2>/dev/null || echo "unknown")
printf "  ${MUTED}model${RESET}  ${YELLOW}${BOLD}%s${RESET}\n" "$CURRENT_MODEL"
printf "\n"
divider

# ── Agents ────────────────────────────────────
printf "  ${CYAN}AGENTS${RESET}  "
AGENTS_DIR="$HOME/.cursor/agents"
agent_count=0
if [ -d "$AGENTS_DIR" ]; then
  agent_count=$(ls -1 "$AGENTS_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
fi
printf "${MUTED}(%s)${RESET}\n" "$agent_count"

if [ -d "$AGENTS_DIR" ] && [ "$agent_count" -gt 0 ]; then
  for agent in "$AGENTS_DIR"/*.md; do
    [ -f "$agent" ] || continue
    name=$(basename "$agent" .md)
    model=$(grep -A1 "^model:" "$agent" 2>/dev/null | head -1 | sed 's/model: *//')
    if [ "$model" = "fast" ]; then
      printf "  ${GREEN}⚡${RESET} %s\n" "$name"
    else
      printf "  ${MUTED}·${RESET}  %s\n" "$name"
    fi
  done
else
  printf "  ${MUTED}·  (none)${RESET}\n"
fi

printf "\n"
divider

# ── Skills (custom only) ─────────────────────
SKILLS_DIR="$HOME/.cursor/skills"
CUSTOM_SKILLS=(obsidian-note-writer skill-doc-sync requirements-writer prd-writer user-story-writer meeting-notes-writer api-spec-writer deployment-checklist)

printf "  ${CYAN}MY SKILLS${RESET}  ${MUTED}(%s)${RESET}\n" "${#CUSTOM_SKILLS[@]}"

for skill in "${CUSTOM_SKILLS[@]}"; do
  if [ -f "$SKILLS_DIR/$skill/SKILL.md" ]; then
    printf "  ${MUTED}·${RESET}  %s\n" "$skill"
  fi
done

builtin_count=0
if [ -d "$SKILLS_DIR" ]; then
  total=$(ls -1d "$SKILLS_DIR"/*/SKILL.md 2>/dev/null | wc -l | tr -d ' ')
  builtin_count=$((total - ${#CUSTOM_SKILLS[@]}))
fi
if [ "$builtin_count" -gt 0 ]; then
  printf "  ${DIM}+ %s built-in skills${RESET}\n" "$builtin_count"
fi

printf "\n"
divider

# ── Rules ─────────────────────────────────────
printf "  ${CYAN}PROJECT RULES${RESET}\n"
CURSOR_PID=$(pgrep -f "cursor.*agent" 2>/dev/null | head -1)
if [ -n "$CURSOR_PID" ]; then
  CWD=$(lsof -p "$CURSOR_PID" 2>/dev/null | awk '$4=="cwd" {print $NF}' | head -1)
else
  CWD=""
fi

RULES_DIR=""
if [ -n "$CWD" ] && [ -d "$CWD/.cursor/rules" ]; then
  RULES_DIR="$CWD/.cursor/rules"
elif [ -d ".cursor/rules" ]; then
  RULES_DIR=".cursor/rules"
fi

if [ -n "$RULES_DIR" ] && [ -n "$(ls -A "$RULES_DIR" 2>/dev/null)" ]; then
  for rule in "$RULES_DIR"/*.mdc; do
    [ -f "$rule" ] || continue
    printf "  ${MUTED}·${RESET}  %s\n" "$(basename "$rule" .mdc)"
  done
else
  printf "  ${MUTED}·  (none)${RESET}\n"
fi

printf "\n"
divider

# ── Directory ─────────────────────────────────
printf "  ${CYAN}DIRECTORY${RESET}\n"
if [ -n "$CURSOR_PID" ] && [ -n "$CWD" ]; then
  CWD="${CWD/#$HOME/\~}"
  printf "  ${BLUE}%s${RESET}\n" "$CWD"

  if command -v git &>/dev/null; then
    branch=$(cd "$CWD" 2>/dev/null && git branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
      printf "  ${MUTED}branch:${RESET} ${YELLOW}%s${RESET}\n" "$branch"
    fi
  fi
else
  printf "  ${MUTED}cursor not running${RESET}\n"
fi

printf "\n"
divider

# ── Quick Reference ───────────────────────────
printf "  ${CYAN}INVOKE${RESET}\n"
printf "  ${MUTED}/agent-name  ${DIM}call agent${RESET}\n"
printf "  ${MUTED}자연어       ${DIM}auto trigger${RESET}\n"
printf "\n"
