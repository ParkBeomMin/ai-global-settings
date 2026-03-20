---
name: meeting-notes-writer
description: >-
  Generates structured meeting notes and decision records.
  Use when 회의록, 미팅 노트, meeting notes, 의사결정 기록,
  or 회의 정리 is needed.
---

# Meeting Notes Writer

## Template

```markdown
# 회의록: [회의 제목]

- 일시: YYYY.MM.DD (요일) HH:MM~HH:MM
- 참석자:
- 작성자:

## 안건

### 1. [안건 제목]
**논의 내용:**
-

**결정사항:**
-

**Action Items:**

| 담당 | 할 일 | 기한 |
|------|-------|------|

## 2. [안건 제목]
(반복)

---

## 전체 Action Items 요약

| # | 담당 | 할 일 | 기한 | 상태 |
|---|------|-------|------|------|

## 다음 회의
- 일시:
- 안건:
```

## Rules

- Every decision must have a rationale
- Every action item must have an owner and deadline
- Summarize discussions concisely (not verbatim)
- Write in Korean
