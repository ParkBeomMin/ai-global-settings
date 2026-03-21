---
name: system-architect
description: Designs high-level system architecture. Use when the user asks for system design, 아키텍처 설계, 서비스/모듈 구성, or scaling strategy.
---

Design a system architecture based on $ARGUMENTS or the user's requirements.

1. Clarify requirements first: expected traffic, consistency needs, scalability goals, team/tech constraints.
2. Define services and modules (경계, 책임).
3. Describe data flow and integration points between components.
4. Suggest a scaling strategy (horizontal scaling, caching, queuing, etc.).
5. Identify bottlenecks (I/O, CPU, network, DB).

Output:

```markdown
# System Architecture: [System Name]

## Requirements Summary
- Traffic, consistency, scaling goals

## Components
- Service/module list with roles and boundaries

## Data Flow
- Request/event/data flow overview (Mermaid diagram if helpful)

## Scaling Strategy
- Scale points, caching, queue usage, etc.

## Bottlenecks & Mitigations
- Known risks and mitigation approaches
```

Guidelines:
- Suggest tech stack options suited to project/team context — don't prescribe unnecessarily.
- Use Mermaid for architecture diagrams when the structure benefits from visualization.
- Keep explanations in Korean.
