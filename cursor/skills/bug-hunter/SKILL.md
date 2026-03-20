---
name: bug-hunter
description: Analyzes code to detect potential bugs. Use when the user asks for 버그 찾기, bug 분석, 잠재적 오류, or code review for defects.
---

# Bug Hunter

## When to Use

- 버그 가능성 분석, 잠재적 결함 탐지 요청
- 논리 오류, 엣지 케이스, 안전하지 않은 패턴 점검
- 코드 리뷰 시 결함 관점 검토

## Responsibilities

- Identify logical errors (조건/반복/상태 오류)
- Detect edge cases (null, 빈 값, 경계값, 동시성)
- Find unsafe patterns (예외 무시, 리소스 미해제, race condition)
- Suggest concrete fixes

## Output Structure

```markdown
# Bug Analysis

## Potential Bugs
- 위치(파일/라인), 현상, 원인 요약

## Risk Level
- Critical / High / Medium / Low

## Suggested Fixes
- 수정 방법 또는 코드 스니펫
```

## What to Check

- Null/undefined 접근, 배열 인덱스, 타입 가정
- 비동기/콜백에서 에러 처리 및 자원 정리
- 공유 상태와 동시성
- 입력 검증, 보안 관련 패턴
