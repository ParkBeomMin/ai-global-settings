---
name: security-ownership-map
description: Analyzes git history to map file ownership, bus factor, and security risk concentration. Use when the user asks for 코드 소유권 분석, bus factor, 보안 오너십 맵, or ownership risk.
---

Analyze code ownership and security risk from git history for $ARGUMENTS.

## Purpose

Build a security-focused ownership graph: who owns what files, where ownership is concentrated, and where critical code lacks adequate ownership coverage.

## Analysis Steps

### 1. Extract Git History
```bash
git log --follow --format="%ae %H" -- <path> | head -1000
```

### 2. Build Ownership Metrics
For each file, calculate:
- Primary owner (most commits)
- Co-owners (significant contributors)
- Bus factor (minimum people whose absence breaks knowledge continuity)
- Last modified date and by whom

### 3. Identify Risk Areas

Focus on security-sensitive paths:
- Authentication / authorization code
- Cryptography / key management
- Payment / financial logic
- PII handling
- Infrastructure / deployment configs

### 4. Flag Risk Patterns

- **Orphaned code**: Security-sensitive files with no recent commits or departed owners
- **Single-point-of-failure**: Bus factor = 1 on critical files
- **Stale ownership**: CODEOWNERS entries that don't match actual contributors
- **Hidden owners**: Files changed frequently by unlisted contributors

## Exclude from clustering
Lockfiles, `.github/*`, editor config, generated files (common glue files distort results).

## Output Format

```markdown
# Security Ownership Report

## High-Risk Files (Bus Factor = 1)
- file/path.ts — Owner: user@email.com, Last: 2024-01-15

## Orphaned Security Code
- auth/middleware.go — Last owner left team, no commits in 180+ days

## CODEOWNERS Gaps
- payments/ — listed owner has 0 commits in 90 days

## Recommendations
- Add co-owners to: ...
- Review/reassign: ...
```
