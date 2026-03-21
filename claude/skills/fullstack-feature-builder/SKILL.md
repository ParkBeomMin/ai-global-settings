---
name: fullstack-feature-builder
description: Designs and implements a complete feature across frontend, backend, and database layers. Use when the user asks to build a full feature, end-to-end feature, or implement something across stack layers.
---

Implement a full-stack feature based on $ARGUMENTS or the user's description.

## Workflow

1. **Clarify requirements** — confirm feature scope, constraints, and acceptance criteria with the user if unclear.
2. **Design API** — define endpoints, methods, request/response shapes.
3. **Design DB** — identify entity/table changes, migrations needed.
4. **Implement backend** — routes, services, DB access code.
5. **Implement frontend** — UI components, API calls, state management.
6. **Verify integration** — outline the request flow end-to-end and note test points.

## Output Structure

```markdown
# Feature Plan: [Feature Name]

## Requirements
- 기능 요구사항 정리

## API Design
- Endpoints, methods, request/response shapes

## Database Changes
- Schema/migration summary

## Backend Implementation
- Routes, services, controllers to add/modify

## Frontend Implementation
- Components, state, API integration

## Integration Steps
- Execution order, test checkpoints
```

After planning, implement each layer sequentially.
Read existing code before writing to match project conventions.
