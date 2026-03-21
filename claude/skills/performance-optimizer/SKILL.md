---
name: performance-optimizer
description: Analyzes code and suggests performance improvements. Use when the user asks for 성능 최적화, 병목 분석, or slow code/query 개선.
---

Analyze the provided code or $ARGUMENTS for performance issues and suggest improvements.

1. Read the relevant files to understand the code.
2. Identify bottlenecks:
   - N+1 queries, unnecessary repeated computations
   - Missing indexes, expensive joins, unselected columns
   - Heavy synchronous operations, missing caching
   - Inefficient algorithms or data structures
3. Output:

```markdown
# Performance Analysis

## Bottlenecks
- Location (file:line), description of the slow operation

## Optimizations
- Prioritized list of applicable improvements

## Suggested Improvements
- Concrete code/query-level suggestions or examples
```

4. Guidelines:
   - Reference measurable metrics (response time, CPU, memory) if available.
   - If profiling results are provided, focus suggestions on hot paths.
   - Do not sacrifice readability/maintainability for marginal gains.
