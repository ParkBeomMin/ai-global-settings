---
name: tech-debt-finder
description: Finds technical debt in a codebase and suggests improvements. Use when the user asks for tech debt 분석, 기술 부채 탐지, or code quality/refactoring opportunities.
---

# Tech Debt Finder

## When to Use

- 코드베이스의 기술 부채(tech debt) 파악 요청
- 리팩토링 우선순위를 정하고 싶을 때
- 레거시/위험 패턴 식별

## Responsibilities

- Detect outdated patterns (deprecated API, 오래된 라이브러리 사용)
- Identify risky code (복잡도, 결합도, 테스트 부재)
- Suggest refactoring opportunities (중복 제거, 모듈화, 네이밍)
- Prioritize by impact and effort

## Output Structure

```markdown
# Technical Debt Report

## Problem Areas
- 파일/모듈별 이슈 요약

## Risk Level
- High / Medium / Low 또는 우선순위

## Suggested Improvements
- 구체적인 개선 방안 (짧은 단계별 제안)
```

## What to Look For

- Duplication, long methods, deep nesting
- Missing or weak tests for critical paths
- Tight coupling, unclear boundaries
- Deprecated dependencies or unsafe patterns
- Inconsistent naming or style
