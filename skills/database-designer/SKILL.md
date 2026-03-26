---
name: database-designer
description: Designs database schemas and data models. Use when the user asks for DB 설계, 스키마 설계, 테이블/엔티티 설계, or data model 설계.
---

Design a database schema based on the user's requirements or $ARGUMENTS.

1. Clarify domain entities and their relationships from the requirements.
2. Design entities, tables, columns, types, and constraints.
3. Model relationships (1:1, 1:N, N:M) with FK references.
4. Recommend indexes based on expected query patterns.
5. Output using this structure:

```markdown
# Database Design

## Entities
- Entity list with descriptions

## Tables
- Table name, columns, types, constraints (PK, FK, NOT NULL, UNIQUE, DEFAULT)

## Relationships
- Relationship type, FK reference, cardinality

## Indexes
- Target columns, composite index suggestions based on query patterns
```

6. Balance normalization vs. performance (denormalize where justified).
7. Follow project/team naming conventions if discernible from existing code.
8. If an ORM is used, include entity ↔ table mapping notes.
