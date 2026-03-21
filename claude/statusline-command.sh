#!/bin/bash
# Claude Code status line: [model]  📁 folder  context bar and percentage

input=$(cat)

# Save data for the right panel
echo "$input" > /tmp/claude-status.json

# --- Model ---
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')

# --- Current folder (basename of cwd) ---
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
if [ -n "$cwd" ]; then
  folder=$(basename "$cwd")
else
  folder=$(basename "$(pwd)")
fi

# --- Context window ---
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# --- Build context bar (10 block chars wide) ---
build_bar() {
  local pct="$1"
  local width=10
  local filled=$(echo "$pct $width" | awk '{printf "%d", ($1/100)*$2 + 0.5}')
  local empty=$((width - filled))
  local bar=""
  for ((i=0; i<filled; i++)); do bar="${bar}\u2588"; done
  for ((i=0; i<empty; i++)); do bar="${bar}\u2591"; done
  printf "$bar"
}

# --- ANSI color codes ---
reset='\033[0m'
green='\033[32m'
yellow='\033[33m'
red='\033[31m'

# --- Pick color based on usage percentage ---
ctx_color() {
  local pct="$1"
  if [ -z "$pct" ]; then printf '%b' "${green}"; return; fi
  local int_pct=$(printf "%.0f" "$pct")
  if [ "$int_pct" -ge 90 ]; then
    printf '%b' "${red}"
  elif [ "$int_pct" -ge 70 ]; then
    printf '%b' "${yellow}"
  else
    printf '%b' "${green}"
  fi
}

# --- Assemble output ---

# [Model name]
model_part="[${model}]"

# 📁 folder
folder_part="📁 ${folder}"

# Context bar + percentage
if [ -n "$used_pct" ]; then
  bar=$(build_bar "$used_pct")
  color=$(ctx_color "$used_pct")
  pct_fmt=$(printf "%.0f" "$used_pct")
  ctx_part="${color}${bar} ${pct_fmt}%${reset}"
else
  ctx_part="$(ctx_color "0")$(build_bar "0") --%${reset}"
fi

printf "%b\n" "${model_part}  ${folder_part}  ${ctx_part}"
