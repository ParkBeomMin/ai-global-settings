---
name: skill-doc-sync
description: >-
  Syncs Cursor skill and subagent creation with Korean documentation in Obsidian.
  Use when creating a new skill, 스킬 만들기, 스킬 생성, writing a SKILL.md file,
  creating a subagent, 서브에이전트 만들기, 에이전트 생성, or writing an agent .md file.
---

# Skill & Agent Doc Sync

After creating or updating a Cursor **skill** (`~/.cursor/skills/<name>/SKILL.md`)
or **subagent** (`~/.cursor/agents/<name>.md`), always perform these additional steps:

## 1. Create Korean Reference Doc

- **If skill** → Write at:
  ```
  /Users/bmpark/Documents/범민/AI 활용/Cursor/Skills/<name>.md
  ```

- **If subagent** → Write at:
  ```
  /Users/bmpark/Documents/범민/AI 활용/Cursor/Agents/<name>.md
  ```

Include:
- Type: skill or subagent
- Purpose and trigger keywords
- How it works (brief)
- Usage examples
- File path (`~/.cursor/skills/` or `~/.cursor/agents/`)

For subagents, also include:
- Model setting (fast / inherit / specific)
- How it differs from related skills
- Invocation syntax (`/name` or natural language)

## 2. Update Index

- **If skill** → Update "내가 만든 스킬" table in:
  ```
  /Users/bmpark/Documents/범민/AI 활용/Cursor/Skills/README.md
  ```

- **If subagent** → Update "내가 만든 서브에이전트" table in:
  ```
  /Users/bmpark/Documents/범민/AI 활용/Cursor/Agents/README.md
  ```

Row format:

```markdown
| `<name>` | trigger keywords | [[<name>]] |
```

## 3. Checklist

```
- [ ] Main file written in English (SKILL.md or agent .md)
- [ ] Korean doc created in correct Obsidian folder (Skills/ or Agents/)
- [ ] Correct README.md index table updated
```
