---
name: skill-writer
description: Create a new Claude Code skill or agent. Use when the user asks to create, add, or save something as a skill or agent (e.g. "make this a skill", "스킬로 만들어줘", "에이전트로 만들어줘", "스킬로 저장해줘").
---

Create a new Claude Code skill or agent based on the current conversation context.

**Type:** skill or agent — infer from context, or ask if unclear.
**Name:** Provided in $ARGUMENTS (kebab-case), or ask the user if not specified.
**Scope:** common (both Claude + Cursor) or tool-specific (Claude-only / Cursor-only) — infer from context, or ask if unclear.

## If creating a SKILL

Skill sources live in **one** repo directory: `ai-global-settings/skills/<name>/SKILL.md`. With the README symlink setup, `~/.claude/skills` and `~/.cursor/skills` both point at that same `skills/` tree — do **not** maintain duplicate `claude/skills/` or `cursor/skills/` copies in the repo.

### Common skill (default)

1. Create `skills/<name>/SKILL.md` in **ai-global-settings** (single file):
   - Frontmatter: `name`, `description` (when to auto-invoke)
   - Clear step-by-step instructions in English
   - Use `$ARGUMENTS` where user input is needed
2. Create Korean docs at `~/Documents/범민/AI 활용/Skills/<name>.md`:
   - 개요, 파일 위치, 트리거 키워드, 동작 방식, 사용 예시
3. Update `~/Documents/범민/AI 활용/Skills/README.md`:
   - Add to skills table, sorted alphabetically

### Claude-only skill

1. Add `skills/<name>/SKILL.md` in **ai-global-settings** (same path; tooling may ignore it on Cursor)
2. Create Korean docs at `~/Documents/범민/AI 활용/Claude/Skills/<name>.md`
3. Update `~/Documents/범민/AI 활용/Claude/Skills/README.md`

### Cursor-only skill

1. Add `skills/<name>/SKILL.md` in **ai-global-settings** (same path; Claude may not load it by choice)
2. Create Korean docs at `~/Documents/범민/AI 활용/Cursor/Skills/<name>.md`
3. Update `~/Documents/범민/AI 활용/Cursor/Skills/README.md`

## If creating an AGENT

1. Create `~/.claude/agents/<name>.md` with:
   - Frontmatter: `name`, `description` (when to invoke), `tools` (allowed tools)
   - Role description and behavior guidelines in English
2. Create Korean docs at `~/Documents/범민/AI 활용/Claude/Agents/<name>.md`:
   - 개요, 파일 위치, 주요 기능, 사용 예시, 동작 방식, 참고
3. Update `~/Documents/범민/AI 활용/Claude/Agents/README.md`:
   - Add to agents table, sorted alphabetically

## Writing style
- Skill/Agent files: concise, imperative English
- Korean docs: clear and practical, written as personal reference notes
