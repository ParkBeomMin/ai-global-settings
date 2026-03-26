# ai-global-settings

Claude, Cursor, WezTerm, Zellij 전역 설정을 Git으로 관리하는 레포지토리입니다.

## 폴더 구조

```
ai-global-settings/
├── skills/              ← Claude Code, Cursor 공통 스킬 (단일 관리)
├── claude/
│   ├── settings.json
│   ├── statusline.sh
│   ├── panel.sh
│   ├── panel-runner.sh
│   ├── agents/
│   └── plugins/
├── cursor/
│   ├── mcp.json
│   ├── agents/
│   └── rules/
├── wezterm/
│   └── wezterm.lua
├── zellij/
│   ├── config.kdl
│   └── layouts/
│       ├── claude.kdl
│       └── cursor.kdl
├── scripts/
│   └── cursor-zellij.sh
└── docs/
```

## 새 기기에서 설정하기

### 1. 레포지토리 클론

```bash
git clone https://github.com/ParkBeomMin/ai-global-settings.git ~/workspace/ai-global-settings
```

### 2. 심볼릭 링크 연결

#### Claude

```bash
REPO=~/workspace/ai-global-settings

# 기존 파일/디렉토리 백업
mv ~/.claude/settings.json ~/.claude/settings.json.bak
mv ~/.claude/agents ~/.claude/agents.bak
mv ~/.claude/skills ~/.claude/skills.bak
mv ~/.claude/commands ~/.claude/commands.bak
mv ~/.claude/panel.sh ~/.claude/panel.sh.bak
mv ~/.claude/panel-runner.sh ~/.claude/panel-runner.sh.bak
mv ~/.claude/statusline.sh ~/.claude/statusline.sh.bak

# 심볼릭 링크 생성
ln -s $REPO/claude/settings.json ~/.claude/settings.json
ln -s $REPO/claude/settings.local.json ~/.claude/settings.local.json
ln -s $REPO/claude/agents ~/.claude/agents
ln -s $REPO/skills ~/.claude/skills
ln -s $REPO/claude/commands ~/.claude/commands
ln -s $REPO/claude/panel.sh ~/.claude/panel.sh
ln -s $REPO/claude/panel-runner.sh ~/.claude/panel-runner.sh
ln -s $REPO/claude/statusline.sh ~/.claude/statusline.sh
```

#### Cursor

```bash
REPO=~/workspace/ai-global-settings

mv ~/.cursor/mcp.json ~/.cursor/mcp.json.bak
mv ~/.cursor/agents ~/.cursor/agents.bak
mv ~/.cursor/skills ~/.cursor/skills.bak
mv ~/.cursor/rules ~/.cursor/rules.bak
mv ~/.cursor/panel.sh ~/.cursor/panel.sh.bak

ln -s $REPO/cursor/mcp.json ~/.cursor/mcp.json
ln -s $REPO/cursor/agents ~/.cursor/agents
ln -s $REPO/skills ~/.cursor/skills
ln -s $REPO/cursor/rules ~/.cursor/rules
ln -s $REPO/cursor/panel.sh ~/.cursor/panel.sh
```

#### WezTerm

```bash
REPO=~/workspace/ai-global-settings

mv ~/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua.bak

ln -s $REPO/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
```

#### Zellij

```bash
REPO=~/workspace/ai-global-settings

mkdir -p ~/.config/zellij

mv ~/.config/zellij/config.kdl ~/.config/zellij/config.kdl.bak
mv ~/.config/zellij/layouts ~/.config/zellij/layouts.bak

ln -s $REPO/zellij/config.kdl ~/.config/zellij/config.kdl
ln -s $REPO/zellij/layouts ~/.config/zellij/layouts
```

#### Cursor Panel (Zellij 사이드 패널)

```bash
REPO=~/workspace/ai-global-settings

ln -sf $REPO/cursor/panel.sh ~/.cursor/panel.sh
```

#### Shell 통합 (zellij 자동 실행)

```bash
REPO=~/workspace/ai-global-settings

ln -s $REPO/scripts/claude-zellij.sh ~/.claude/claude-zellij.sh
ln -s $REPO/scripts/cursor-zellij.sh ~/.cursor/cursor-zellij.sh
```

`~/.zshrc`에 아래 라인을 추가합니다:

```bash
source ~/.claude/claude-zellij.sh
source ~/.cursor/cursor-zellij.sh
```

이후 `claude` / `cursor agent` 실행 시 자동으로 zellij 레이아웃이 적용됩니다.

### 3. 심볼릭 링크 확인

```bash
ls -la ~/.claude/settings.json ~/.claude/settings.local.json ~/.claude/agents ~/.claude/skills ~/.claude/commands ~/.claude/panel.sh ~/.claude/panel-runner.sh ~/.claude/statusline.sh ~/.claude/claude-zellij.sh
ls -la ~/.cursor/mcp.json ~/.cursor/agents ~/.cursor/skills ~/.cursor/panel.sh ~/.cursor/cursor-zellij.sh
# skills는 동일한 경로를 가리켜야 함
# ~/.claude/skills -> ai-global-settings/skills
# ~/.cursor/skills -> ai-global-settings/skills
ls -la ~/.config/wezterm/wezterm.lua
ls -la ~/.config/zellij/config.kdl ~/.config/zellij/layouts
```

## 설정 변경 후 Git에 반영

심볼릭 링크로 연결되어 있어 원본 파일 수정 시 자동으로 레포지토리에 반영됩니다.

```bash
cd ~/workspace/ai-global-settings
git add .
git commit -m "설명"
git push
```

## 주의사항

- `cursor/cli-config.json`은 인증 정보 포함으로 `.gitignore`에서 제외됩니다.
- 기존 파일은 `.bak`으로 백업되니 문제 발생 시 복구할 수 있습니다.
