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

# ── Skills ────────────────────────────────────
SKILLS_DIR="$HOME/.cursor/skills"
skill_count=0
if [ -d "$SKILLS_DIR" ]; then
  skill_count=$(ls -1d "$SKILLS_DIR"/*/SKILL.md 2>/dev/null | wc -l | tr -d ' ')
fi

printf "  ${CYAN}SKILLS${RESET}  ${MUTED}(%s)${RESET}\n" "$skill_count"

if [ -d "$SKILLS_DIR" ] && [ "$skill_count" -gt 0 ]; then
  for skill_path in "$SKILLS_DIR"/*/SKILL.md; do
    [ -f "$skill_path" ] || continue
    name=$(basename "$(dirname "$skill_path")")
    printf "  ${MUTED}·${RESET}  %s\n" "$name"
  done
else
  printf "  ${MUTED}·  (none)${RESET}\n"
fi

printf "\n"
divider

# ── Detect project CWD ────────────────────────
# In Zellij, both the agent pane and the panel pane inherit
# the same CWD from the session launch directory. So pwd is
# the correct project directory for this specific session.
CWD="$(pwd)"

# ── Rules ─────────────────────────────────────
printf "  ${CYAN}PROJECT RULES${RESET}\n"

RULES_DIR=""
if [ -d "$CWD/.cursor/rules" ]; then
  RULES_DIR="$CWD/.cursor/rules"
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
DISPLAY_CWD="${CWD/#$HOME/\~}"
printf "  ${BLUE}%s${RESET}\n" "$DISPLAY_CWD"

if command -v git &>/dev/null; then
  branch=$(git -C "$CWD" branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    printf "  ${MUTED}branch:${RESET} ${YELLOW}%s${RESET}\n" "$branch"
  fi
fi

printf "\n"
divider

# ── Quick Reference ───────────────────────────
printf "  ${CYAN}INVOKE${RESET}\n"
printf "  ${MUTED}/agent-name  ${DIM}call agent${RESET}\n"
printf "  ${MUTED}자연어       ${DIM}auto trigger${RESET}\n"
printf "\n"
