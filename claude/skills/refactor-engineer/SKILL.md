---
name: refactor-engineer
description: Improves code quality and refactors code while maintaining behavior. Use when cleaning legacy code, improving maintainability, or applying best practices.
---

Refactor the code specified in $ARGUMENTS or the current file without changing its behavior.

1. Read the target file(s) to understand the current implementation.
2. Identify refactoring opportunities:
   - Simplify logic (복잡한 조건/반복 단순화)
   - Remove duplication (공통 함수/모듈 추출)
   - Improve naming (변수, 함수, 타입 명확화)
   - Modularize (책임 분리, 의존성 정리)
3. Apply one type of refactoring at a time to keep changes focused and reviewable.
4. Verify behavior is preserved — if tests exist, confirm they still pass.
5. Output:
   - Before/after code or diff
   - One or two sentences explaining the change and its benefit
   - Optional: further improvement suggestions (brief)

Rules:
- Scope: limit to the files/modules specified by the user.
- Do not change public interfaces or fix bugs as a side effect — flag separately.
- If tests are absent for critical paths, note this as a risk.
