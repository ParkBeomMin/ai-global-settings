---
name: test-writer
description: Generates automated test cases for code. Use when the user asks for 테스트 작성, unit test, integration test, or test coverage.
---

# Test Writer

## When to Use

- 단위/통합 테스트 작성 요청
- 엣지 케이스 검증이 필요할 때
- 테스트 계획 또는 케이스 목록이 필요할 때

## Responsibilities

- Unit tests (함수/메서드 단위, 격리)
- Integration tests (API, DB, 외부 연동)
- Edge case detection (경계값, null, 에러 경로)
- Use project test framework (Jest, pytest, JUnit 등)

## Output Structure

```markdown
# Test Plan

## Unit Tests
- 대상 함수/모듈, 케이스 요약, 예시 코드

## Integration Tests
- 시나리오, 의존성, 예시 코드

## Edge Cases
- 경계/예외 케이스 목록 및 테스트 방법
```

## Guidelines

- 기존 테스트 스타일과 프레임워크에 맞춰 작성
- Given-When-Then 또는 Arrange-Act-Assert 유지
- Mock/Stub 사용 시 과도한 모킹 지양, 필요한 것만 격리
