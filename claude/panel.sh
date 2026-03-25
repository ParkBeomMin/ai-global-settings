#!/bin/bash
# ~/.claude/panel.sh - Claude Code right-side status panel

RESET='\033[0m'
DIM='\033[2m'
BOLD='\033[1m'
BLUE='\033[38;5;74m'
GREEN='\033[38;5;82m'
YELLOW='\033[38;5;179m'
RED='\033[38;5;203m'
MUTED='\033[38;5;245m'
WHITE='\033[97m'
CYAN='\033[38;5;110m'
ORANGE='\033[38;5;208m'
PURPLE='\033[38;5;141m'

WIDTH=32

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
  for ((i=0; i<filled; i++)); do
    local pos=$(( (i + 1) * 100 / width ))
    if   [ "$pos" -le 40 ]; then bar="${bar}\033[38;5;82m█"   # 밝은 초록
    elif [ "$pos" -le 60 ]; then bar="${bar}\033[38;5;118m█"  # 연두
    elif [ "$pos" -le 75 ]; then bar="${bar}\033[38;5;226m█"  # 노랑
    elif [ "$pos" -le 88 ]; then bar="${bar}\033[38;5;208m█"  # 주황
    else                         bar="${bar}\033[38;5;196m█"  # 빨강
    fi
  done
  bar="${bar}\033[38;5;238m"
  for ((i=0; i<empty; i++)); do bar="${bar}░"; done
  bar="${bar}${RESET}"
  printf "%b" "$bar"
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

# statusline.json이 가리키는 현재 세션 트랜스크립트를 읽음
STATUS_FILE="${ZELLIJ_SESSION_NAME:+/tmp/claude-status-${ZELLIJ_SESSION_NAME}.json}"
STATUS_FILE="${STATUS_FILE:-$HOME/.claude/statusline.json}"
CURRENT_TRANSCRIPT=$(jq -r '.transcript_path // empty' "$STATUS_FILE" 2>/dev/null)

# 트랜스크립트에서 최신 세션 데이터 추출
SESSION_DATA=""
if [ -n "$CURRENT_TRANSCRIPT" ] && [ -f "$CURRENT_TRANSCRIPT" ]; then
  SESSION_DATA=$(python3 - "$CURRENT_TRANSCRIPT" "$STATUS_FILE" <<'PYEOF'
import json, sys
from pathlib import Path

transcript_path, status_path = sys.argv[1], sys.argv[2]

# 트랜스크립트에서 최신 usage + cwd + model 추출
usage, cwd, model_name = {}, "", ""
with open(transcript_path, encoding="utf-8") as f:
    for line in f:
        try:
            d = json.loads(line.strip())
            if d.get("cwd"): cwd = d["cwd"]
            msg = d.get("message", {})
            if msg.get("model"): model_name = msg["model"]
            u = msg.get("usage", {})
            if u.get("cache_read_input_tokens") or u.get("input_tokens"):
                usage = u
        except: pass

# statusline.json에서 보완 (model display name, cost 등)
status = {}
try:
    with open(status_path) as f:
        status = json.load(f)
except: pass

model_display = status.get("model", {}).get("display_name", "") or model_name
cost = status.get("cost", {})

ctx_in = usage.get("input_tokens", 0)
ctx_cache_c = usage.get("cache_creation_input_tokens", 0)
ctx_cache_r = usage.get("cache_read_input_tokens", 0)
ctx_out = usage.get("output_tokens", 0)
ctx_size = status.get("context_window", {}).get("context_window_size", 200000)
ctx_used = ctx_in + ctx_cache_c + ctx_cache_r
used_pct = round(ctx_used / ctx_size * 100) if ctx_size else 0

total_in = status.get("context_window", {}).get("total_input_tokens", 0)
total_out = status.get("context_window", {}).get("total_output_tokens", 0)
total_cost = cost.get("total_cost_usd", 0)

result = {
    "model_display": model_display,
    "cwd": cwd,
    "ctx_used": ctx_used,
    "ctx_size": ctx_size,
    "used_pct": used_pct,
    "total_tokens": total_in + total_out,
    "total_cost": total_cost,
}
print(json.dumps(result))
PYEOF
  )
fi

# ── 실행 중인 에이전트 감지 ────────────────────
# parent JSONL에서 tool_result 없는 Agent tool_use = 현재 실행 중 (실시간)
ACTIVE_AGENTS=$(python3 - <<'PYEOF'
import json
from pathlib import Path
from datetime import datetime, timezone, timedelta

projects_dir = Path.home() / ".claude" / "projects"
now = datetime.now(timezone.utc)
cutoff = now - timedelta(hours=1)
active = set()

for jsonl in projects_dir.rglob("*.jsonl"):
    if "subagents" in jsonl.parts:
        continue
    try:
        if datetime.fromtimestamp(jsonl.stat().st_mtime, tz=timezone.utc) < cutoff:
            continue
        subagents_dir = jsonl.with_suffix("") / "subagents"
        if not subagents_dir.is_dir():
            continue
        tool_uses = {}
        tool_results = set()
        with open(jsonl, encoding="utf-8") as f:
            for line in f:
                if '"Agent"' not in line and '"tool_result"' not in line:
                    continue
                try:
                    d = json.loads(line.strip())
                    for block in d.get("message", {}).get("content", []):
                        if block.get("type") == "tool_use" and block.get("name") == "Agent":
                            tid = block.get("id", "")
                            st = block.get("input", {}).get("subagent_type", "")
                            if tid and st:
                                tool_uses[tid] = st
                        if block.get("type") == "tool_result":
                            tool_results.add(block.get("tool_use_id", ""))
                except Exception:
                    pass
        for tid, st in tool_uses.items():
            if tid not in tool_results:
                active.add(st)
    except Exception:
        pass

print("|".join(sorted(active)))
PYEOF
)

is_active() {
  local name="$1"
  echo "$ACTIVE_AGENTS" | tr '|' '\n' | grep -qi "$name" && return 0 || return 1
}

# ── Header ────────────────────────────────────
printf " ${BOLD}${WHITE}범민${RESET}${MUTED}  %s${RESET}\n" "$(date '+%H:%M')"
printf " ${MUTED}%s${RESET}\n" "$(date '+%Y.%m.%d %a')"
session_count=$(find "$HOME/.claude/projects" -name "*.jsonl" -not -path "*/subagents/*" -mmin -5 -type f 2>/dev/null | wc -l | tr -d ' ')
printf " \033[38;5;118msessions  ${BOLD}%s${RESET}\n" "$session_count"
divider

# ── Model + Project ───────────────────────────
if [ -n "$SESSION_DATA" ]; then
  model=$(echo "$SESSION_DATA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('model_display','—'))")
  project=$(echo "$SESSION_DATA" | python3 -c "import sys,json,os; d=json.load(sys.stdin); print(os.path.basename(d.get('cwd','')))")
  printf " ${BOLD}${PURPLE}%s${RESET}\n" "$model"
  printf " ${BLUE}%s${RESET}\n" "$project"
else
  printf " ${MUTED}—${RESET}\n"
fi
divider

# ── Context Window ────────────────────────────
if [ -n "$SESSION_DATA" ]; then
  used_pct=$(echo "$SESSION_DATA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('used_pct',0))")
  ctx_used=$(echo "$SESSION_DATA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('ctx_used',0))")
  ctx_size=$(echo "$SESSION_DATA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('ctx_size',200000))")

  color=$(color_for_pct "$used_pct")
  printf " ${CYAN}CONTEXT${RESET}  %s  ${color}%s%%${RESET}\n" "$(build_bar "$used_pct")" "$used_pct"
  printf " ${MUTED}%s / %s${RESET}\n" "$(printf "%'d" $ctx_used)" "$(printf "%'d" $ctx_size)"
else
  printf " ${CYAN}CONTEXT${RESET}  ${MUTED}no data yet${RESET}\n"
fi
divider

# ── Rate Limits ───────────────────────────────
HUD_CACHE="$HOME/.claude/plugins/claude-hud/.usage-cache.json"
iso_to_ts() { TZ=UTC date -jf "%Y-%m-%dT%H:%M:%S" "${1%.*}" "+%s" 2>/dev/null; }

if [ -f "$HUD_CACHE" ]; then
  five_pct=$(jq -r '.data.fiveHour // empty' "$HUD_CACHE" 2>/dev/null)
  five_reset_iso=$(jq -r '.data.fiveHourResetAt // empty' "$HUD_CACHE" 2>/dev/null)
  seven_pct=$(jq -r '.data.sevenDay // empty' "$HUD_CACHE" 2>/dev/null)
  seven_reset_iso=$(jq -r '.data.sevenDayResetAt // empty' "$HUD_CACHE" 2>/dev/null)

  if [ -n "$five_pct" ]; then
    color=$(color_for_pct "$five_pct")
    reset_str=$(format_reset "$(iso_to_ts "$five_reset_iso")")
    reset_disp=${reset_str:+" ${MUTED}(${reset_str})${RESET}"}
    printf " ${MUTED}5h${RESET}  %s  ${color}%s%%${RESET}%b\n" "$(build_bar "$five_pct")" "$five_pct" "$reset_disp"
  fi

  if [ -n "$seven_pct" ]; then
    color=$(color_for_pct "$seven_pct")
    reset_str=$(format_reset "$(iso_to_ts "$seven_reset_iso")")
    reset_disp=${reset_str:+" ${MUTED}(${reset_str})${RESET}"}
    printf " ${MUTED}7d${RESET}  %s  ${color}%s%%${RESET}%b\n" "$(build_bar "$seven_pct")" "$seven_pct" "$reset_disp"
  fi
else
  printf " ${MUTED}no data yet${RESET}\n"
fi

if [ -n "$SESSION_DATA" ]; then
  total_tokens=$(echo "$SESSION_DATA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('total_tokens',0))")
  total_cost=$(echo "$SESSION_DATA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('total_cost',0))")
  [ "$total_tokens" -gt 0 ] 2>/dev/null && \
    printf " ${MUTED}$(printf "%'d" $total_tokens) tokens · \$%s${RESET}\n" "$(printf "%.4f" "$total_cost")"
fi
divider

# ── Skills ────────────────────────────────────
printf " ${CYAN}SKILLS${RESET}\n"
SKILLS_DIR="$HOME/.claude/skills"
if [ -d "$SKILLS_DIR" ] && [ -n "$(ls -A "$SKILLS_DIR" 2>/dev/null)" ]; then
  for skill in "$SKILLS_DIR"/*/; do
    [ -d "$skill" ] || continue
    printf " ${MUTED}·${RESET} %s\n" "$(basename "$skill")"
  done
else
  printf " ${MUTED}· (none)${RESET}\n"
fi
divider

# ── Agents ────────────────────────────────────
printf " ${CYAN}AGENTS${RESET}\n"
AGENTS_DIR="$HOME/.claude/agents"
if [ -d "$AGENTS_DIR" ] && [ -n "$(ls -A "$AGENTS_DIR" 2>/dev/null)" ]; then
  for agent in "$AGENTS_DIR"/*.md; do
    [ -f "$agent" ] || continue
    name=$(basename "$agent" .md)
    if is_active "$name"; then
      printf " ${GREEN}▶ ${BOLD}${GREEN}%s${RESET} ${GREEN}●${RESET}\n" "$name"
    else
      printf " ${MUTED}·${RESET} %s\n" "$name"
    fi
  done
else
  printf " ${MUTED}· (none)${RESET}\n"
fi
