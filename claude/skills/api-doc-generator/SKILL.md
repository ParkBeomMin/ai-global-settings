---
name: api-doc-generator
description: Automatically generates API documentation from backend routes or controllers. Use when documenting REST APIs, creating API references, or building backend documentation.
---

Generate API documentation from the current project's backend code.

1. Read project structure to locate route/controller files (e.g. routes/, controllers/, src/).
2. Extract each endpoint: method, path, parameters, request body, response shape, auth requirements.
3. Only use information derived from actual code — do not invent fields.
4. Output structured documentation using this format:

```markdown
# API Documentation

## Base URL
- Development: ...
- Production: ...

## Authentication
- Method (Bearer, API Key, etc.) and required headers

## Endpoints

### GET /example
- **Parameters**: query/path params with types
- **Request Body**: JSON shape (if applicable)
- **Response (200)**: JSON shape and status code
- **Error Codes**: 4xx, 5xx summary
```

5. If OpenAPI/Swagger spec is needed, offer to generate that format instead.
6. Exclude any sensitive keys or tokens from examples.
