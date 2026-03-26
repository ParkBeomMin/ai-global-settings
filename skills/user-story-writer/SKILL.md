---
name: user-story-writer
description: Generates user stories with acceptance criteria. Use when 유저 스토리, user story, 사용자 스토리, acceptance criteria, or 인수조건 writing is needed.
---

Write user stories based on $ARGUMENTS or the user's feature description.

Use this format for each story:

```markdown
### [US-001] 스토리 제목

**As a** [사용자 유형],
**I want** [원하는 기능],
**So that** [달성하려는 가치/목적].

**인수조건 (Acceptance Criteria):**
- [ ] Given [전제조건], When [행동], Then [결과]
- [ ] Given [전제조건], When [행동], Then [결과]

**우선순위:** Must / Should / Could
**스토리 포인트:** 1 / 2 / 3 / 5 / 8 / 13
**관련 화면:** [화면명]
```

Rules:
- One story = one user value (keep atomic).
- Write acceptance criteria in Given-When-Then format.
- Assign unique IDs (US-xxx).
- Include edge cases in acceptance criteria.
- Group related stories into Epics.
- Write in Korean.
