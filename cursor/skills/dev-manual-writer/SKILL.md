---
name: dev-manual-writer
description: Creates and updates developer manuals by analyzing the codebase and producing structured documentation. Use when the user asks to write a developer manual, dev manual, technical documentation, onboarding guide, or to document project setup, architecture, or conventions.
---

# Developer Manual Writer

## When to Use

Apply this skill when the user wants to:
- Write or create a developer manual (개발자 매뉴얼)
- Update existing dev documentation
- Document project setup, architecture, or coding conventions
- Produce an onboarding or technical guide for the codebase

## Workflow

### 1. Clarify scope and target

- **New manual**: Confirm where to create it (e.g. `docs/DEV_MANUAL.md`, `README.md`, project root).
- **Update**: Identify the existing file(s) and which sections need changes.
- **Audience**: Assume readers are developers joining or maintaining the project.

### 2. Analyze the project

Before writing, quickly infer from the repo:

- **Tech stack**: package.json, requirements.txt, go.mod, Cargo.toml, etc.
- **Structure**: Main apps, libs, config files, scripts.
- **Entry points**: Main executable, dev server command, test command.
- **Conventions**: Linter/config (ESLint, Prettier, etc.), test framework, CI config.

Use codebase search and key config files; avoid documenting every file.

### 3. Propose or confirm structure

Suggest or use a structure like:

```markdown
# [Project Name] Developer Manual

## 1. Overview
- Purpose of the project
- Main technologies

## 2. Prerequisites & environment
- Required tools and versions
- Env vars / config (without secrets)

## 3. Getting started
- Clone, install, first run
- One-line or short command reference

## 4. Project structure
- Directory layout and roles of main folders

## 5. Service Flows (optional)
- Describe important business flows at a high level.
- Examples: authentication flow, order processing, payment flow.
- Focus on sequence of components rather than implementation code.

## 6. Development workflow
- Branching, lint, test, run
- How to run locally / in dev mode

## 7. Conventions & style
- Code style, naming, key patterns (brief)

## 8. Testing
- How to run tests, coverage (if relevant)

## 9. Build & deploy (if applicable)
- Build command, output, deploy flow (high-level)

## 10. Troubleshooting (optional)
- 자주 겪는 오류/증상과 해결 방법
```

Adjust sections (add/remove/rename) to fit the project; keep sections short.

**Writing rules:** Use short paragraphs; prefer bullet points; use code blocks for commands; avoid unnecessary verbosity. 문서는 짧은 문단, bullet list, 명령어는 code block, 불필요한 장문 지양.

### 4. Write or update content

- **Overview**: 1–2 short paragraphs from repo purpose and main tech.
- **Prerequisites**: List tools and versions from config; mention env files (e.g. `.env.example`) without values.
- **Getting started**: Exact clone/install/run commands; verify against config (e.g. npm/pip/cargo scripts).
- **Project structure**: Describe only important directories and their role.
- **Service Flows**: When the project has meaningful business flows, add a short "Service Flows" section. Describe flows at a high level (e.g. authentication, order processing, payment). Focus on the sequence of components or steps, not implementation code.
- **Development workflow**: Commands for lint, test, dev server; mention key scripts from package.json or Makefile.
- **Conventions**: Summarize from linter/config and obvious patterns; link to config files if needed.
- **Testing**: How to run tests and, if present, coverage.
- **Build & deploy**: Only if the project has a clear build/deploy path; keep high-level.

Use present tense and imperative for commands. Prefer bullet lists and short paragraphs.

### 5. Final pass

- Ensure all commands and paths match the current repo.
- Remove or generalize project-specific secrets or internal URLs.
- If updating an existing doc, preserve tone and format of the rest of the file.

## Output format

- Use Markdown.
- Use consistent heading levels (e.g. `#` for title, `##` for main sections, `###` for subsections).
- Prefer fenced code blocks for commands and paths; add a short caption if helpful (e.g. `bash` for shell).
- Keep the manual scannable: short sections, bullets, and code blocks.

## What to avoid

- Do not invent commands or paths; derive from the repo.
- Do not include secrets, API keys, or internal-only URLs.
- Do not write a novel: stay concise and actionable.
- Do not duplicate content that already exists in README or other docs; link or briefly summarize instead.

## Optional: incremental updates

When the user asks to "update the dev manual" after code changes:

1. Identify which part of the project changed (e.g. new script, new env var, new dependency).
2. Locate the corresponding section in the manual.
3. Update only that section; keep the rest unchanged unless the change affects structure or workflow.
