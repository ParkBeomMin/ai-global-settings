---
name: migration-generator
description: Generates safe database migrations when schema changes are detected. Use when the user mentions DB schema change, migration, 마이그레이션 생성, or altering tables/columns.
---

# Migration Generator

## When to Use

- DB 스키마 변경 시 마이그레이션 스크립트가 필요할 때
- 테이블/컬럼 추가·수정·삭제를 안전하게 적용하고 싶을 때
- 롤백 전략이 필요한 변경일 때

## Responsibilities

- Detect schema changes (기존 스키마 vs 목표 스키마)
- Generate migration scripts (ORM/raw SQL 등 프로젝트 방식에 맞게)
- Suggest rollback strategy (다운 마이그레이션 또는 복구 스크립트)
- Consider data preservation and ordering (순서, 의존성)

## Output Structure

```markdown
# Migration Plan

## Schema Changes
- 변경 요약 (테이블/컬럼/인덱스 등)

## Migration Script
- 업 마이그레이션 코드 또는 SQL

## Rollback Strategy
- 다운 스크립트 또는 복구 방법
- 데이터 손실 방지 시 주의사항
```

## Guidelines

- 한 번에 하나의 논리적 변경 단위로 마이그레이션 구성
- 기존 데이터가 있는 컬럼 추가/변경 시 기본값·NULL 정책 명시
- 프로젝트에서 사용하는 도구(Prisma, TypeORM, Alembic, Flyway 등) 형식 따르기
