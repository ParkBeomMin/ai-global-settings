---
name: database-designer
description: Designs database schemas and data models. Use when the user asks for DB 설계, 스키마 설계, 테이블/엔티티 설계, or data model 설계.
---

# Database Designer

## When to Use

- DB 스키마·데이터 모델 설계 요청
- 엔티티/테이블 구조, 관계 정의가 필요할 때
- 인덱스 및 제약 조건 제안

## Responsibilities

- Entity design (엔티티, 속성, 식별자)
- Table structure (테이블, 컬럼, 타입, 제약)
- Relationship modeling (1:1, 1:N, N:M, FK)
- Index recommendations (조회 패턴 기반)

## Output Structure

```markdown
# Database Design

## Entities
- 엔티티 목록과 설명

## Tables
- 테이블명, 컬럼, 타입, 제약

## Relationships
- 관계 종류, FK, 카디널리티

## Indexes
- 인덱스 대상 컬럼, 복합 인덱스 제안
```

## Guidelines

- 정규화와 성능(역정규화) 균형
- 네이밍은 프로젝트/팀 컨벤션 따르기
- ORM 사용 시 엔티티 ↔ 테이블 매핑 명시
