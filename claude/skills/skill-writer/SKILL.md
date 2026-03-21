---
name: skill-writer
description: Create a new Claude Code skill or agent. Use when the user asks to create, add, or save something as a skill or agent (e.g. "make this a skill", "스킬로 만들어줘", "에이전트로 만들어줘", "스킬로 저장해줘").
---

Create a new Claude Code skill or agent based on the current conversation context.

**Type:** skill or agent — infer from context, or ask if unclear.
**Name:** Provided in $ARGUMENTS (kebab-case), or ask the user if not specified.

## If creating a SKILL

1. Create `~/.claude/skills/<name>/SKILL.md` with:
   - Frontmatter: `name`, `description` (when Claude should auto-invoke it)
   - Clear step-by-step instructions in English
   - Use `$ARGUMENTS` where user input is needed
2. Create Korean docs at `~/Documents/범민/AI 활용/Claude/Skills/<name>.md`:
   - 개요, 파일 위치, 사용 방법, 동작 방식, 참고
3. Update `~/Documents/범민/AI 활용/Claude/Skills/README.md`:
   - Add to skills table, sorted alphabetically

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
