---
name: deployment-checklist
description: Generates pre-deployment checklists for safe releases. Use when 배포 체크리스트, deployment checklist, 릴리즈 점검, or 배포 전 확인 is needed.
---

Generate a deployment checklist tailored to the current project based on $ARGUMENTS (service name, version, deploy date).

Read the project structure to identify tech stack and customize items accordingly. Remove items that don't apply.

Output:

```markdown
# 배포 체크리스트

- 서비스명:
- 버전:
- 배포일:
- 담당자:

## 1. 코드 점검
- [ ] 모든 PR이 리뷰/승인됨
- [ ] main 브랜치에 머지 완료
- [ ] 불필요한 console.log / debug 코드 제거
- [ ] 환경변수 확인 (.env 누락 없는지)

## 2. 테스트
- [ ] 단위 테스트 통과
- [ ] 통합 테스트 통과
- [ ] 스테이징 환경에서 QA 완료

## 3. 데이터베이스
- [ ] 마이그레이션 스크립트 준비
- [ ] 마이그레이션 롤백 스크립트 준비
- [ ] 데이터 백업 완료

## 4. 인프라
- [ ] 서버 리소스 충분한지 확인
- [ ] SSL 인증서 유효 확인
- [ ] 모니터링/알림 설정 확인

## 5. 배포 실행
- [ ] 배포 시간 공지 완료
- [ ] 헬스체크 엔드포인트 확인
- [ ] 배포 후 스모크 테스트 항목 준비

## 6. 배포 후 확인
- [ ] 스모크 테스트 통과
- [ ] 로그에 에러 없는지 확인
- [ ] 주요 지표 정상 확인 (응답시간, 에러율)
- [ ] 롤백 기준 및 절차 확인

## 7. 커뮤니케이션
- [ ] 릴리즈 노트 작성
- [ ] 팀/고객 공지
```
