---
name: test-writer
description: Generates automated test cases for code. Use when the user asks for 테스트 작성, unit test, integration test, or test coverage.
---

Write tests for the code specified in $ARGUMENTS or the current file.

1. Read the target file(s) to understand the code being tested.
2. Identify the project's test framework (Jest, pytest, JUnit, Vitest, etc.) from config files.
3. Write tests covering:
   - **Unit tests**: individual functions/methods in isolation
   - **Integration tests**: API endpoints, DB interactions, external integrations
   - **Edge cases**: null/undefined, empty collections, boundary values, error paths
4. Follow project test style (Given-When-Then or Arrange-Act-Assert).
5. Use mocks/stubs only where necessary — avoid over-mocking.

Output:

```markdown
# Test Plan

## Unit Tests
- Target function/module, test cases, example code

## Integration Tests
- Scenario, dependencies, example code

## Edge Cases
- Boundary/exception cases and how to test them
```

Then write the actual test code in the appropriate test file.
