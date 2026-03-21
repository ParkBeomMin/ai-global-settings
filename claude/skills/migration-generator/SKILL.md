---
name: migration-generator
description: Generates safe database migrations when schema changes are detected. Use when the user mentions DB schema change, migration, 마이그레이션 생성, or altering tables/columns.
---

Generate a database migration based on $ARGUMENTS or the described schema change.

1. Identify the current schema (read existing migration files or entity definitions).
2. Identify the target schema from the user's description.
3. Generate migration scripts using the project's ORM/tool (Prisma, TypeORM, Alembic, Flyway, raw SQL — detect from config files).
4. Include a rollback strategy (down migration or recovery script).

Output:

```markdown
# Migration Plan

## Schema Changes
- Summary of changes (tables/columns/indexes added, modified, or dropped)

## Migration Script (Up)
\`\`\`sql
-- or ORM-specific format
\`\`\`

## Rollback Strategy (Down)
\`\`\`sql
-- or ORM-specific format
\`\`\`

## Notes
- Data preservation considerations
- Ordering/dependency notes
- Default value / NULL policy for new columns with existing data
```

Rules:
- One logical change per migration file.
- For columns added to tables with existing data, always specify DEFAULT or NULL policy.
- Never generate destructive changes (DROP TABLE, DROP COLUMN) without explicit user confirmation.
