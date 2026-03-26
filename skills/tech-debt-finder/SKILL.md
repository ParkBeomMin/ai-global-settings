---
name: tech-debt-finder
description: Finds technical debt in a codebase and suggests improvements. Use when the user asks for tech debt 분석, 기술 부채 탐지, or code quality/refactoring opportunities.
---

Analyze the codebase for technical debt based on $ARGUMENTS or the current project.

1. Use Glob/Grep to scan relevant files for debt indicators.
2. Look for:
   - Outdated patterns (deprecated APIs, outdated library usage)
   - Risky code (high complexity, tight coupling, missing tests for critical paths)
   - Duplication, long methods, deep nesting
   - Inconsistent naming or style
   - Unsafe patterns or security smells
3. Prioritize findings by impact and effort.

Output:

```markdown
# Technical Debt Report

## Problem Areas
- File/module, issue summary

## Risk Level
- High / Medium / Low (or priority ranking)

## Suggested Improvements
- Concrete improvement steps (short, incremental)
```

4. Group related issues by module or theme.
5. Provide a prioritized top-3 "quick wins" that are high-impact and low-effort.
