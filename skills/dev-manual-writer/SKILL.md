---
name: dev-manual-writer
description: Creates and updates developer manuals by analyzing the codebase and producing structured documentation. Use when the user asks to write a developer manual, dev manual, technical documentation, or onboarding guide.
---

Write or update a developer manual for the current project based on $ARGUMENTS.

**If $ARGUMENTS specifies a file path**, treat it as the target file to create/update.
**If no path is given**, default to `docs/DEV_MANUAL.md` or ask the user.

## Steps

1. Read project config files to infer tech stack:
   - package.json, requirements.txt, go.mod, Cargo.toml, Makefile, docker-compose.yml, etc.
2. Identify entry points (main files, dev server commands, test commands).
3. Map key directories and their roles.
4. Write or update the manual using this structure:

```markdown
# [Project Name] Developer Manual

## 1. Overview
- Purpose and main technologies

## 2. Prerequisites & Environment
- Required tools/versions
- Env vars / config (without secrets — reference .env.example)

## 3. Getting Started
- Clone, install, first run commands

## 4. Project Structure
- Directory layout and roles of main folders

## 5. Service Flows (optional)
- Key business flows at high level (auth, order, payment, etc.)
- Focus on component sequence, not implementation details

## 6. Development Workflow
- Branching, lint, test, dev server run commands

## 7. Conventions & Style
- Code style, naming, key patterns (brief)

## 8. Testing
- How to run tests, coverage if relevant

## 9. Build & Deploy (if applicable)
- Build command, output, deploy flow (high-level)

## 10. Troubleshooting (optional)
- Common errors and solutions
```

## Rules
- Only document what can be verified from the repo.
- No secrets, API keys, or internal-only URLs.
- Keep sections short — prefer bullets and code blocks.
- When updating: locate the changed section and update only that part.
