#!/bin/bash
# ~/.claude/panel.sh - Claude Code right-side status panel

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
ORANGE='\033[38;5;208m'

WIDTH=34

divider() {
  printf "${DIM}"
  printf '─%.0s' $(seq 1 $WIDTH)
  printf "${RESET}\n"
}

build_bar() {
  local pct="$1" width=10
  local filled=$(echo "$pct $width" | awk '{printf "%d", ($1/100)*$2 + 0.5}')
  local empty=$((width - filled))
  local bar=""
  for ((i=0; i<filled; i++)); do bar="${bar}█"; done
  for ((i=0; i<empty; i++)); do bar="${bar}░"; done
  echo "$bar"
}

color_for_pct() {
  local int_pct=$(printf "%.0f" "${1:-0}" 2>/dev/null || echo 0)
  if   [ "$int_pct" -ge 90 ]; then printf "${RED}"
  elif [ "$int_pct" -ge 70 ]; then printf "${YELLOW}"
  else printf "${GREEN}"
  fi
}

format_reset() {
  local ts="$1"
  [ -z "$ts" ] || [ "$ts" = "null" ] && return
  local diff=$(( ts - $(date +%s) ))
  [ "$diff" -le 0 ] && return
  local mins=$(( diff / 60 ))
  local hours=$(( mins / 60 ))
  local days=$(( hours / 24 ))
  if   [ "$days" -ge 1 ]; then
    local rh=$(( hours % 24 ))
    [ "$rh" -gt 0 ] && echo "${days}d ${rh}h" || echo "${days}d"
  elif [ "$hours" -ge 1 ]; then
    local rm=$(( mins % 60 ))
    [ "$rm" -gt 0 ] && echo "${hours}h ${rm}m" || echo "${hours}h"
  else
    echo "${mins}m"
  fi
}

# 경로 왼쪽 자르기 (너무 길면 앞을 ...으로)
truncate_path() {
  local path="$1" max="${2:-30}"
  if [ "${#path}" -le "$max" ]; then
    echo "$path"
  else
    echo "…${path: -$((max-1))}"
  fi
}

STATUS_FILE="/tmp/claude-status.json"

# ── 실행 중인 툴/에이전트 감지 ────────────────
RUNNING_TOOLS=""
if [ -f "$STATUS_FILE" ]; then
  TRANSCRIPT=$(jq -r '.transcript_path // empty' "$STATUS_FILE" 2>/dev/null)
  if [ -n "$TRANSCRIPT" ] && [ -f "$TRANSCRIPT" ]; then
    RUNNING_TOOLS=$(jq -rs '
      [.[] | select(.message != null) | .message.content // [] | .[]] as $all |
      ($all | map(select(.type == "tool_use")) | map({id: .id, name: .name})) as $uses |
      ($all | map(select(.type == "tool_result")) | map(.tool_use_id)) as $done |
      $uses[] | select(.id as $id | ($done | contains([$id])) | not) | .name
    ' "$TRANSCRIPT" 2>/dev/null | sort -u | tr '\n' '|')
  fi
fi

is_active() {
  local name="$1"
  echo "$RUNNING_TOOLS" | tr '|' '\n' | grep -qi "$name" && return 0 || return 1
}

# ── Header ────────────────────────────────────
printf "\n"
printf "  ${BOLD}${WHITE}범민${RESET}${MUTED}  %s${RESET}\n" "$(date '+%H:%M')"
printf "  ${MUTED}%s${RESET}\n" "$(date '+%Y.%m.%d %a')"
printf "\n"
divider

# ── Model ─────────────────────────────────────
printf "  ${CYAN}MODEL${RESET}\n"
if [ -f "$STATUS_FILE" ]; then
  model=$(jq -r '.model.display_name // "—"' "$STATUS_FILE" 2>/dev/null)
  printf "  ${WHITE}%s${RESET}\n" "$model"
else
  printf "  ${MUTED}—${RESET}\n"
fi
printf "\n"
divider

# ── Context Window ────────────────────────────
printf "  ${CYAN}CONTEXT${RESET}\n"
if [ -f "$STATUS_FILE" ]; then
  used_pct=$(jq -r '.context_window.used_percentage // empty' "$STATUS_FILE" 2>/dev/null)
  input_tokens=$(jq -r '.context_window.current_usage.input_tokens // empty' "$STATUS_FILE" 2>/dev/null)
  ctx_size=$(jq -r '.context_window.context_window_size // empty' "$STATUS_FILE" 2>/dev/null)

  if [ -n "$used_pct" ]; then
    color=$(color_for_pct "$used_pct")
    printf "  ${color}%s  %s%%${RESET}\n" "$(build_bar "$used_pct")" "$used_pct"
    [ -n "$input_tokens" ] && [ -n "$ctx_size" ] && \
      printf "  ${MUTED}%s / %s tokens${RESET}\n" "$input_tokens" "$ctx_size"
  else
    printf "  ${MUTED}no data yet${RESET}\n"
  fi
else
  printf "  ${MUTED}no data yet${RESET}\n"
fi
printf "\n"
divider

# ── Rate Limits ───────────────────────────────
printf "  ${CYAN}RATE LIMITS${RESET}\n\n"

if [ -f "$STATUS_FILE" ]; then
  five_pct=$(jq -r '.rate_limits.five_hour.used_percentage // empty' "$STATUS_FILE" 2>/dev/null)
  five_reset=$(jq -r '.rate_limits.five_hour.resets_at // empty' "$STATUS_FILE" 2>/dev/null)
  seven_pct=$(jq -r '.rate_limits.seven_day.used_percentage // empty' "$STATUS_FILE" 2>/dev/null)
  seven_reset=$(jq -r '.rate_limits.seven_day.resets_at // empty' "$STATUS_FILE" 2>/dev/null)

  printf "  ${MUTED}5h${RESET}\n"
  if [ -n "$five_pct" ]; then
    color=$(color_for_pct "$five_pct")
    printf "  ${color}%s  %s%%${RESET}\n" "$(build_bar "$five_pct")" "$five_pct"
    reset_str=$(format_reset "$five_reset")
    [ -n "$reset_str" ] && printf "  ${MUTED}resets in %s${RESET}\n" "$reset_str"
  else
    printf "  ${MUTED}no data yet${RESET}\n"
  fi

  printf "\n"

  printf "  ${MUTED}7d${RESET}\n"
  if [ -n "$seven_pct" ]; then
    color=$(color_for_pct "$seven_pct")
    printf "  ${color}%s  %s%%${RESET}\n" "$(build_bar "$seven_pct")" "$seven_pct"
    reset_str=$(format_reset "$seven_reset")
    [ -n "$reset_str" ] && printf "  ${MUTED}resets in %s${RESET}\n" "$reset_str"
  else
    printf "  ${MUTED}no data yet${RESET}\n"
  fi
else
  printf "  ${MUTED}no data yet${RESET}\n"
fi
printf "\n"
divider

# ── Skills ────────────────────────────────────
printf "  ${CYAN}SKILLS${RESET}\n"
SKILLS_DIR="$HOME/.claude/skills"
if [ -d "$SKILLS_DIR" ] && [ -n "$(ls -A "$SKILLS_DIR" 2>/dev/null)" ]; then
  for skill in "$SKILLS_DIR"/*/; do
    [ -d "$skill" ] || continue
    name=$(basename "$skill")
    if is_active "$name"; then
      printf "  ${ORANGE}▶${RESET}  ${WHITE}%s${RESET} ${ORANGE}(active)${RESET}\n" "$name"
    else
      printf "  ${MUTED}·${RESET}  %s\n" "$name"
    fi
  done
else
  printf "  ${MUTED}·  (none)${RESET}\n"
fi
printf "\n"
divider

# ── Agents ────────────────────────────────────
printf "  ${CYAN}AGENTS${RESET}\n"
AGENTS_DIR="$HOME/.claude/agents"
if [ -d "$AGENTS_DIR" ] && [ -n "$(ls -A "$AGENTS_DIR" 2>/dev/null)" ]; then
  for agent in "$AGENTS_DIR"/*.md; do
    [ -f "$agent" ] || continue
    name=$(basename "$agent" .md)
    if is_active "$name" || echo "$RUNNING_TOOLS" | grep -qi "task"; then
      printf "  ${ORANGE}▶${RESET}  ${WHITE}%s${RESET} ${ORANGE}(active)${RESET}\n" "$name"
    else
      printf "  ${MUTED}·${RESET}  %s\n" "$name"
    fi
  done
else
  printf "  ${MUTED}·  (none)${RESET}\n"
fi
printf "\n"
divider

# ── Directory ─────────────────────────────────
printf "  ${CYAN}DIRECTORY${RESET}\n"
if [ -f "$STATUS_FILE" ]; then
  CWD=$(jq -r '.cwd // .workspace.current_dir // empty' "$STATUS_FILE" 2>/dev/null)
  if [ -n "$CWD" ]; then
    display=$(truncate_path "${CWD/#$HOME/\~}" 30)
    printf "  ${BLUE}%s${RESET}\n" "$display"
  else
    printf "  ${MUTED}unknown${RESET}\n"
  fi
else
  printf "  ${MUTED}no data yet${RESET}\n"
fi
printf "\n"
