---
name: api-doc-generator
description: Automatically generates API documentation from backend routes or controllers. Use when documenting REST APIs, creating API references, or building backend documentation.
---

# API Doc Generator

## When to Use

- REST API 문서 작성 요청
- 백엔드 라우트/컨트롤러 기반 API 레퍼런스 생성
- 엔드포인트 목록·요청/응답 형식 정리

## Responsibilities

- Extract routes and handlers from backend code
- Document method, path, parameters, body, response shape
- Include authentication requirements if present
- Add example request/response and error codes

## Output Structure

```markdown
# API Documentation

## Base URL
- (개발/운영 환경 등)

## Authentication
- 방식 (Bearer, API Key 등), 필요한 경우

## Endpoints

### GET /example
- **Parameters**: query/path
- **Request**: body 예시 (해당 시)
- **Response**: 예시, 상태 코드
- **Error Codes**: 4xx, 5xx 요약
```

## Guidelines

- 실제 코드(라우트/스키마)에서 추출한 정보만 사용
- OpenAPI/Swagger 스펙 생성이 필요하면 해당 형식으로 제안
- 민감한 키/토큰 예시는 제외
