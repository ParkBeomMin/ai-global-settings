---
name: obsidian-note-writer
description: >-
  Writes or updates notes in the user's Obsidian vault.
  Use when the user asks to 옵시디언 정리, 노트 작성, 메모 저장, 학습 내용 정리,
  save to Obsidian, or organize conversation content into notes.
---

# Obsidian Note Writer

## Vault Info

- **Path**: `/Users/bmpark/Documents/범민`
- **Format**: Obsidian-flavored Markdown (`.md`)

## Folder Structure

| Folder | Purpose | Examples |
|--------|---------|----------|
| `AI 활용` | AI tool usage, tips, prompts | ClaudeCode.md, Cursor CLI.md |
| `AI 활용/Cursor/Skills` | Korean docs for each Cursor skill | obsidian-note-writer.md |
| `AI Agents 마스터 클래스` | AI Agent framework study | CrewAI.md, AutoGen.md |
| `Tools` | Dev tool setup/usage | WezTerm.md |
| `NAS` | NAS config/operations | Tailscale.md, WebDAV.md |
| `독서` | Reading notes | |
| `Daily Log` | Daily logs | 2026-03-18.md |
| `Templates` | Obsidian templates | |
| `옵시디언 자료` | Obsidian itself | 플러그인 모음.md |

## Writing Rules

### 1. File Placement

- Place in the existing folder that matches the topic.
- If a related note already exists, **update it** instead of creating a new one.
- Ask the user before creating a new folder.

### 2. Pre-write Checklist

Before writing, always:
1. List existing `.md` files in the target folder.
2. Read any related note to avoid duplication.
3. Decide: append to existing note or create new one.

### 3. Markdown Format

- Section heading: `## Section Title — YYYY.MM.DD` (include date)
- Separate new sections with `---`
- Use tables and code blocks liberally.
- Obsidian syntax allowed: `[[links]]`, `![[images]]`, callouts, etc.
- **Write content in Korean.**

### 4. Content Style

- Structure: **Background/Why** → **Concept** → **How-to** → **Comparison/Summary**
- Short, clear sentences.
- Summarize key points in tables.
- Wrap commands and paths in code blocks.

### 5. Image References

- User screenshots: reference as `![[Pasted image ...]]`
- Images are auto-saved at the vault root.

## Skill Documentation Rule

When a **new Cursor skill** is added (in **ai-global-settings** `skills/<name>/`, or under `~/.cursor/skills/` when that path is symlinked to the repo `skills/`):
1. Create a Korean reference doc at `AI 활용/Cursor/Skills/<skill-name>.md`
2. Include: purpose, trigger keywords, how it works, usage examples.
3. Also update the skill index table in `AI 활용/Cursor/Skills/README.md`.

## Workflow

```
1. Analyze user request → determine topic
2. Check folder / existing notes → ls, Read
3. Decide: append or create
4. Write markdown (follow format above)
5. Save and tell the user the file location
```
