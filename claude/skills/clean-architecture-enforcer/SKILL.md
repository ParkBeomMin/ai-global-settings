---
name: clean-architecture-enforcer
description: Ensures code follows clean architecture principles. Use when the user asks for architecture review, 레이어 분리, 의존성 방향 점검, or clean architecture 적용.
---

Review the codebase for clean architecture compliance based on $ARGUMENTS or the current project.

1. Use Glob/Grep to map the project structure and identify layers (domain, use case, interface adapter, framework).
2. Check for violations:
   - UI or framework code referencing DB/domain directly
   - Domain layer depending on external frameworks
   - Circular dependencies between modules
   - Missing interface abstractions at boundaries
3. Output findings:

```markdown
# Architecture Analysis

## Violations
- File/module, description of violation

## Recommended Structure
- Correct layer/module organization

## Refactoring Suggestions
- Concrete steps (code to move, new interfaces to add)
```

4. Apply these principles:
   - **Dependency rule**: outer layers depend on inner; inner never knows outer
   - **Domain at center**: business rules independent of framework/UI/DB
   - **Interfaces at boundaries**: external integrations abstracted via interfaces
