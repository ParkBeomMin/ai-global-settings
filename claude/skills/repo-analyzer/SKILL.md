---
name: repo-analyzer
description: Analyzes a repository and explains its architecture, stack, and important modules. Use when understanding a new repo, exploring unfamiliar codebases, or preparing documentation.
---

Analyze the repository at $ARGUMENTS (or current working directory) and produce a structured overview.

1. Read config files to detect tech stack: package.json, requirements.txt, go.mod, Cargo.toml, pom.xml, Makefile, docker-compose.yml.
2. Identify entry points (main executable, dev server command, test command).
3. Map key directories and their roles using Glob.
4. Identify important modules/services/components using Grep.

Output:

```markdown
# Repository Overview
- Project purpose (one-line summary)

## Tech Stack
- Language, framework, key dependencies

## Project Structure
- Key directories and their roles

## Entry Points
- Run/start scripts, main entry points

## Key Modules
- Core services/components summary
```

Focus on the big picture and entry points — depth over breadth only where the user asks.
If the user has a specific question about the repo, answer that directly after the overview.
