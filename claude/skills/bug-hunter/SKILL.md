---
name: bug-hunter
description: Analyzes code to detect potential bugs. Use when the user asks for 버그 찾기, bug 분석, 잠재적 오류, or code review for defects.
---

Analyze the provided code or $ARGUMENTS for potential bugs.

1. Read the relevant files using Glob/Grep to locate the code in question.
2. Check for:
   - Logical errors (잘못된 조건, 반복, 상태 관리)
   - Edge cases (null/undefined, 빈 배열, 경계값, 동시성)
   - Unsafe patterns (예외 무시, 리소스 미해제, race condition)
   - Input validation and security-related issues
3. Output findings using this structure:

```markdown
# Bug Analysis

## Potential Bugs
- Location (file:line), symptom, root cause

## Risk Level
- Critical / High / Medium / Low

## Suggested Fixes
- Concrete fix or code snippet for each issue
```

4. Be specific — include file paths and line numbers where possible.
5. Prioritize by risk level (Critical first).
