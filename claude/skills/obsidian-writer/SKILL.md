---
name: obsidian-writer
description: Write or append notes to the user's Obsidian vault. Use when the user asks to save, record, write, or organize content into Obsidian (e.g. "write this to Obsidian", "add this to my notes", "옵시디언에 정리해줘", "노트에 써줘").
---

Write content to the user's Obsidian vault based on the current conversation context.

**Vault base path:** `/Users/bmpark/Documents/범민/`

**Instructions:**

1. If no file path is specified, ask the user which file to write to (use vault-relative path, e.g. `AI 활용/ClaudeCode.md`).
2. Read the target file. If it does not exist, create it.
3. Based on the user's instruction and the current conversation context, compose the content to write.
4. Find the most relevant section in the file and insert the content beneath it. If no relevant section exists, append to the bottom of the file.
5. Prepend a date header (`— YYYY.MM.DD`) before new content. Skip if the same date header already exists in that section.
6. Save the file.

**Writing style:** Concise and practical. The note should be self-contained enough to be understood when read later without the conversation context.

**Arguments (if provided via $ARGUMENTS):**
- First token: vault-relative file path (quote if it contains spaces, e.g. `"AI 활용/ClaudeCode.md"`)
- Remaining tokens: free-form instruction describing what to write or how to organize it
