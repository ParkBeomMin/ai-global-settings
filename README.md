# ai-global-settings

Claude, Cursor, WezTerm 전역 설정을 Git으로 관리하는 레포지토리입니다.

## 폴더 구조

```
ai-global-settings/
├── claude/
│   ├── settings.json
│   ├── agents/
│   ├── skills/
│   ├── commands/
│   └── plugins/
├── cursor/
│   ├── mcp.json
│   ├── agents/
│   ├── skills/
│   └── rules/
├── wezterm/
│   └── wezterm.lua
├── scripts/
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

# 심볼릭 링크 생성
ln -s $REPO/claude/settings.json ~/.claude/settings.json
ln -s $REPO/claude/agents ~/.claude/agents
ln -s $REPO/claude/skills ~/.claude/skills
ln -s $REPO/claude/commands ~/.claude/commands
```

#### Cursor

```bash
REPO=~/workspace/ai-global-settings

mv ~/.cursor/mcp.json ~/.cursor/mcp.json.bak
mv ~/.cursor/agents ~/.cursor/agents.bak
mv ~/.cursor/skills ~/.cursor/skills.bak
mv ~/.cursor/rules ~/.cursor/rules.bak

ln -s $REPO/cursor/mcp.json ~/.cursor/mcp.json
ln -s $REPO/cursor/agents ~/.cursor/agents
ln -s $REPO/cursor/skills ~/.cursor/skills
ln -s $REPO/cursor/rules ~/.cursor/rules
```

#### WezTerm

```bash
REPO=~/workspace/ai-global-settings

mv ~/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua.bak

ln -s $REPO/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
```

### 3. 심볼릭 링크 확인

```bash
ls -la ~/.claude/settings.json ~/.claude/agents ~/.claude/skills ~/.claude/commands
ls -la ~/.cursor/mcp.json ~/.cursor/agents ~/.cursor/skills ~/.cursor/rules
ls -la ~/.config/wezterm/wezterm.lua
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
