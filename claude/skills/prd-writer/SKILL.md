---
name: prd-writer
description: Generates Product Requirements Documents (PRD). Use when 기획문서, PRD, 제품 요구사항, product spec, or feature specification writing is needed.
---

Write a PRD based on $ARGUMENTS or the user's feature/product description.

Use this template:

```markdown
# PRD: [기능/제품명]

## 1. 개요
- 작성일:
- 작성자:
- 상태: Draft / Review / Approved

## 2. 배경 및 목적
### 문제 정의
(해결하려는 문제)

### 목표
(이 기능으로 달성하려는 것)

### 성공 지표 (KPI)
| 지표 | 현재 | 목표 |
|------|------|------|

## 3. 사용자 시나리오
### 페르소나
### 핵심 유저 플로우
(Mermaid flowchart로 표현)

## 4. 기능 상세

### 4.1 [기능 A]
- 설명:
- 인수조건:
- 화면 구성:
- 예외 처리:

## 5. 화면 설계

| 화면명 | 주요 요소 | 인터랙션 | 비고 |
|--------|----------|----------|------|

## 6. 데이터 요구사항
- 필요한 데이터:
- API 연동:

## 7. 일정 및 마일스톤

| 단계 | 기간 | 산출물 |
|------|------|--------|

## 8. 리스크 및 의존성

| 리스크 | 영향도 | 대응 방안 |
|--------|--------|----------|

## 9. 향후 계획 (Out of Scope)
```

Rules:
- Include Mermaid diagrams for user flows.
- Define acceptance criteria for every feature.
- Write in Korean.
