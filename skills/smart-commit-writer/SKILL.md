---
name: smart-commit-writer
description: Generates clean, conventional commit messages from code changes. Use when the user asks for a commit message, 커밋 메시지 작성, or to summarize staged/diff changes.
---

Generate a conventional commit message for the current changes.

1. Run `git diff --staged` (or `git diff HEAD` if nothing is staged) to read the changes.
2. Analyze changed files — additions, modifications, deletions.
3. Determine the commit type: feat, fix, docs, style, refactor, test, chore.
4. Generate a subject line (≤50 chars, imperative present tense).
5. Optionally add a body summarizing the changes and impacted modules.

Output format:

```
type(scope): short description

- Summary of changes
- Impacted modules or files
```

Examples:
```
feat(auth): add OAuth login support
fix(reports): correct date formatting in timezone conversion
docs(readme): update setup instructions
```

Rules:
- **type**: feat, fix, docs, style, refactor, test, chore (Conventional Commits)
- **scope**: project module/area (optional)
- **description**: imperative, present tense ("add" not "added")
- Default to English; use Korean if the user requests it.
- After generating, ask the user to confirm before running `git commit`.
