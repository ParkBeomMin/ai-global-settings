---
name: fullstack-feature-builder
description: Designs and implements a complete feature across frontend, backend, and database layers. Use when the user asks to build a full feature, end-to-end feature, or implement something across stack layers.
---

# Fullstack Feature Builder

## When to Use

- User asks to implement a feature across frontend, backend, and DB
- End-to-end feature design or "전체 기능 구현" 요청
- 새 기능 설계 및 레이어별 구현이 필요할 때

## Responsibilities

- Break down feature requirements into clear tasks
- Design API endpoints (REST/GraphQL 등)
- Suggest database schema changes (테이블, 인덱스, 관계)
- Generate or outline frontend components and flows
- Ensure integration between layers (요청/응답, 에러 처리)

## Output Structure

Use this structure when delivering the feature plan and implementation:

```markdown
# Feature Plan

## Requirements
- 기능 요구사항 정리

## Backend Implementation
- API 엔드포인트, 서비스/컨트롤러 변경

## Database Changes
- 스키마/마이그레이션 요약

## Frontend Implementation
- 컴포넌트, 상태, API 연동

## Integration Steps
- 실행 순서, 테스트 포인트
```

## Workflow

1. **요구사항 정리**: 사용자/문서에서 기능 범위와 제약 파악
2. **API 설계**: 엔드포인트, 메서드, 요청/응답 형식
3. **DB 설계**: 필요한 엔티티, 컬럼, 관계, 인덱스
4. **백엔드 구현**: 라우트, 서비스, DB 접근 코드
5. **프론트엔드 구현**: UI, API 호출, 상태 처리
6. **연동 검증**: 흐름과 에러 케이스 정리
