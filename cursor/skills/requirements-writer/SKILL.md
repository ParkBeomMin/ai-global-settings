---
name: requirements-writer
description: >-
  Generates Software Requirements Specification (SRS) documents.
  Use when 요구사항 명세서, SRS, 요구사항 정의, requirements document,
  or functional/non-functional requirements writing is needed.
---

# Requirements Writer

Generate a structured SRS document using this template:

## Template

```markdown
# 요구사항 명세서 (SRS)

## 1. 개요
- 프로젝트명:
- 작성일:
- 버전:
- 작성자:

## 2. 목적 및 범위
- 시스템 목적:
- 대상 사용자:
- 범위 (In-Scope / Out-of-Scope):

## 3. 기능 요구사항

| ID | 기능명 | 설명 | 우선순위 | 비고 |
|----|--------|------|----------|------|
| FR-001 | | | Must/Should/Could | |

## 4. 비기능 요구사항

| ID | 항목 | 요구사항 | 기준 |
|----|------|----------|------|
| NFR-001 | 성능 | | |
| NFR-002 | 보안 | | |
| NFR-003 | 가용성 | | |

## 5. 제약사항
- 기술적 제약:
- 일정 제약:
- 예산 제약:

## 6. 용어 정의

| 용어 | 정의 |
|------|------|
```

## Rules

- Assign unique IDs (FR-xxx, NFR-xxx) to every requirement
- Prioritize using MoSCoW (Must / Should / Could / Won't)
- Write in Korean
- Keep requirements atomic (one requirement per row)
