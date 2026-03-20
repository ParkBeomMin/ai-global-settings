---
name: smart-commit-writer
description: Generates clean, conventional commit messages from code changes. Use when the user asks for a commit message, 커밋 메시지 작성, or to summarize staged/diff changes.
---

# Smart Commit Writer

## When to Use

- 커밋 메시지 작성/자동 생성 요청
- Staged 또는 diff 변경 분석 후 메시지 생성
- Conventional Commits 형식으로 정리하고 싶을 때

## Responsibilities

- Analyze changed files (추가/수정/삭제)
- Determine change type: feat, fix, docs, style, refactor, test, chore 등
- Generate short, descriptive subject line (50자 이내 권장)
- Optionally add body with summary and impacted modules

## Output Format

**Subject (필수):**
```
type(scope): short description
```

**Body (선택):**
- Summary of changes
- Impacted modules or files

**Example:**
```
feat(auth): add OAuth login support
fix(reports): correct date formatting in timezone conversion
docs(readme): update setup instructions
```

## Rules

- **type**: feat, fix, docs, style, refactor, test, chore 등 Conventional Commits 준수
- **scope**: 프로젝트 내 모듈/영역 (선택)
- **description**: 명령형, 현재형 ("add" not "added")
- 영문 기본; 사용자가 한글 요청 시 한글 메시지도 가능
