---
name: playwright
description: CLI-first browser automation using Playwright. Use when tasks involve web navigation, form filling, UI interaction, screenshot capture, or data extraction from web pages via browser automation.
---

# Playwright CLI Skill

## Prerequisites

Verify `npx` availability before starting:
```bash
command -v npx >/dev/null 2>&1
```
If missing, install Node.js/npm first. Optionally install `@playwright/cli@latest` globally.

## Setup

```bash
export CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
export PWCLI="$CODEX_HOME/skills/playwright/scripts/playwright_cli.sh"
```

## Core Workflow

The fundamental pattern:
1. Open a page
2. Snapshot to get stable element references
3. Interact using element references from the snapshot
4. Re-snapshot after significant UI changes

```bash
"$PWCLI" open https://example.com
"$PWCLI" snapshot
"$PWCLI" click e3
```

**Re-snapshot after:** navigation, clicking elements that change the UI substantially, opening/closing modals or menus, tab switches.

## Key Practices

- Always snapshot before using element IDs
- Re-snapshot when references become stale
- Use `--headed` flag for visual debugging
- Store artifacts in `output/playwright/` directory
- Prefer explicit CLI commands over code evaluation
- Treat browser automation as a CLI-first practice; only transition to test frameworks when explicitly requested

## Common Tasks

- Form filling: snapshot → locate input elements → fill → submit
- UI flow tracing: snapshot at each step, interact, re-snapshot
- Data extraction: snapshot → locate target elements → extract text/attributes
- Multi-tab management: open tabs, switch between them, snapshot each

## Source

https://github.com/openai/skills/tree/main/skills/.curated/playwright
