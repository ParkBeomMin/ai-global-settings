---
name: screenshot
description: Capture desktop and system screenshots on macOS, Linux, and Windows. Use when tasks require capturing full screen, specific windows, app regions, or pixel-level areas for visual inspection or documentation.
---

# Screenshot Skill

## When to Use

Use this skill for desktop/system screenshot captures. Prefer tool-specific screenshot capabilities when available (e.g., Figma MCP, Playwright). This skill is the default for desktop applications lacking better integration options.

## Save Location Rules

1. User-specified path takes priority
2. Default OS screenshot location when no path is given
3. Temp directory for internal visual inspection needs

## Platform-Specific Instructions

### macOS

Run permission preflight first to avoid repeated permission prompts:
```bash
bash <skill_path>/scripts/ensure_macos_permissions.sh
```

The preflight checks Screen Recording permission, explains why it's needed, and requests it.

Capture patterns using Python helper:
```bash
# Full screen
python3 <skill_path>/scripts/capture_macos.py

# Specific app/window
python3 <skill_path>/scripts/capture_macos.py --app "Safari"

# Pixel region
python3 <skill_path>/scripts/capture_macos.py --region x,y,width,height

# List available windows
python3 <skill_path>/scripts/capture_macos.py --list-windows
```

Multi-display: saves separate files per display.

### Linux

Automatically selects from available tools:
- `scrot` (preferred)
- `gnome-screenshot`
- ImageMagick `import`

Coordinate region captures require `scrot` or ImageMagick.

```bash
scrot output.png
scrot -a x,y,width,height output.png
```

### Windows

Uses PowerShell helper with execution policy bypass:
```powershell
powershell -ExecutionPolicy Bypass -File <skill_path>/scripts/capture_windows.ps1
powershell -ExecutionPolicy Bypass -File <skill_path>/scripts/capture_windows.ps1 -Region x,y,w,h
```

## Error Handling

| Issue | Resolution |
|-------|-----------|
| macOS permission denied | Run `ensure_macos_permissions.sh` |
| Sandbox restriction | Use temp directory path |
| Tool not found (Linux) | Install scrot: `sudo apt-get install scrot` |
| App/window match failure | Use `--list-windows` to find exact name |

## Source

https://github.com/openai/skills/tree/main/skills/.curated/screenshot
