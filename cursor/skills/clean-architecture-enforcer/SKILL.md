---
name: clean-architecture-enforcer
description: Ensures code follows clean architecture principles. Use when the user asks for architecture review, 레이어 분리, 의존성 방향 점검, or clean architecture 적용.
---

# Clean Architecture Enforcer

## When to Use

- 아키키처 검토, 레이어 분리 점검 요청
- 의존성 방향이 올바른지 확인하고 싶을 때
- Clean Architecture/헥사고날 적용 여부 검토

## Responsibilities

- Detect architectural violations (예: UI에서 DB 직접 참조, 도메인에 프레임워크 의존)
- Suggest layer separation (도메인, 유스케이스, 인터페이스 어댑터, 프레임워크)
- Recommend dependency direction fixes (의존성은 안쪽으로만)
- Identify boundary violations and circular dependencies

## Output Structure

```markdown
# Architecture Analysis

## Violations
- 발견된 위반 사항 (파일/모듈, 설명)

## Recommended Structure
- 올바른 레이어/모듈 구성 제안

## Refactoring Suggestions
- 구체적인 수정 단계 (이동할 코드, 새 인터페이스 등)
```

## Principles to Check

- **Dependency rule**: 바깥 레이어는 안쪽을 의존; 안쪽은 바깥을 알지 못함
- **Domain at center**: 비즈니스 규칙은 프레임워크/UI/DB에 무관
- **Interfaces at boundaries**: 외부 연동은 인터페이스로 추상화
