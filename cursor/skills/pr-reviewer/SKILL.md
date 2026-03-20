---
name: pr-reviewer
description: Performs professional code reviews similar to senior engineers. Use when reviewing pull requests, checking code quality, or identifying bugs and improvements.
---

# PR Reviewer

## When to Use

- Pull Request / 코드 리뷰 요청
- 코드 품질, 버그, 개선점 점검
- 머지 전 최종 검토

## Review Checklist

### Correctness
- 로직이 의도대로 동작하는가?
- 엣지 케이스, 에러 처리는 적절한가?

### Readability
- 네이밍, 구조가 이해하기 쉬운가?
- 불필요한 복잡도는 없는가?

### Maintainability
- 변경·확장이 용이한가?
- 의존성과 책임이 명확한가?

### Performance
- 눈에 띄는 비효율(반복, 쿼리, 메모리)이 있는가?

### Security
- 입력 검증, 인증/권한, 노출되면 안 되는 정보는 없는가?

## Output Format

- **필수 수정**: 반드시 고칠 항목
- **제안**: 개선하면 좋은 항목
- **참고**: 참고 사항, 링크 등

각 항목에 파일/라인(가능하면), 요약, 구체적 제안을 포함. 시니어 리뷰어처럼 간결하고 실행 가능하게 작성.
