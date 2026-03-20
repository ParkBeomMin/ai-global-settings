---
name: api-spec-writer
description: >-
  Generates API specifications in a structured format.
  Use when API 명세서, API spec, 엔드포인트 정의,
  OpenAPI, or REST API 설계 is needed.
---

# API Spec Writer

## Template per Endpoint

```markdown
### [METHOD] /api/v1/resource

**설명:** 리소스 조회

**인증:** Bearer Token / None

**Request:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|

**Request Body:**
\`\`\`json
{
  "field": "type — 설명"
}
\`\`\`

**Response (200):**
\`\`\`json
{
  "code": 200,
  "data": {}
}
\`\`\`

**Error Responses:**

| Code | Message | Description |
|------|---------|-------------|
| 400 | Bad Request | 잘못된 요청 파라미터 |
| 401 | Unauthorized | 인증 필요 |
| 404 | Not Found | 리소스 없음 |
```

## Full Spec Structure

```markdown
# API 명세서

## 기본 정보
- Base URL: `https://api.example.com`
- Version: v1
- Auth: Bearer JWT

## 공통 응답 포맷
## 공통 에러 코드
## 엔드포인트 목록

| Method | Path | Description |
|--------|------|-------------|

## 엔드포인트 상세
(위 템플릿 반복)
```

## Rules

- Group endpoints by resource/domain
- Include request/response examples with realistic data
- Document all error cases
- Note rate limits if applicable
- Write descriptions in Korean, keep field names in English
