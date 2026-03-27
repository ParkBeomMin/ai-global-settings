---
name: gws
description: gws CLI로 Google Workspace 조작. 메일, 일정, 드라이브, 시트.
disable-model-invocation: true---

# Google Workspace CLI (gws) Skill

Google Workspace CLI를 사용하여 Google 서비스를 조작하는 스킬.

## 기본 문법

```
gws <service> <resource> [sub-resource] <method> [flags]
```

### 공통 플래그

| 플래그 | 설명 |
|--------|------|
| `--params '<JSON>'` | URL/Query 파라미터 |
| `--json '<JSON>'` | Request body (POST/PATCH/PUT) |
| `--upload <PATH>` | 파일 업로드 |
| `--output <PATH>` | 바이너리 응답 저장 경로 |
| `--format <FMT>` | 출력 형식: json (기본), table, yaml, csv |
| `--page-all` | 자동 페이지네이션 (NDJSON) |
| `--page-limit <N>` | 최대 페이지 수 (기본: 10) |
| `--dry-run` | 실제 요청 없이 미리보기 |

### 스키마 조회

명령어 파라미터가 불확실할 때 반드시 스키마를 먼저 조회:

```bash
gws schema <service.resource.method>
# 예: gws schema gmail.users.messages.list
# 예: gws schema drive.files.list
# 예: gws schema calendar.events.insert
```

## 사용자 계정 설정

gws는 멀티 계정을 네이티브로 지원하지 않으며, `GOOGLE_WORKSPACE_CLI_CREDENTIALS_FILE` 환경변수로 계정을 전환한다.
계정별로 `gws auth login` 후 credentials 파일을 별도 저장해두고 아래처럼 전환:

```bash
# club20608 계정으로 전환
export GOOGLE_WORKSPACE_CLI_CREDENTIALS_FILE=~/.config/gws/credentials_club20608.enc

# bmpark.sbs 계정으로 전환
export GOOGLE_WORKSPACE_CLI_CREDENTIALS_FILE=~/.config/gws/credentials_bmpark.enc

# jisobkim 계정으로 전환
export GOOGLE_WORKSPACE_CLI_CREDENTIALS_FILE=~/.config/gws/credentials_jisobkim.enc
```

### 등록된 계정 목록

| 계정 | 용도 |
|------|------|
| `club20608@gmail.com` | 기본 계정 (현재 로그인) |
| `bmpark.sbs@gmail.com` | 추가 계정 |
| `jisobkim@gmail.com` | 추가 계정 |

### jisobkim 계정 캘린더 설정

- **일정 쓰기** (생성/수정/삭제): MK2JOBS 캘린더만 사용
  - ID: `un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com`
- **일정 읽기** (조회): 아래 전체 캘린더에서 조회 (병렬 호출)
  - `jisobkim@gmail.com` (구글캘린더, primary)
  - `un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com` (MK2JOBS)
  - `c6937607a1d516fbe1e0329bf097ba6e17866542db4c8244d1b7550717652ba7@group.calendar.google.com` (플랫폼개발팀[2026])
  - `ko.south_korea#holiday@group.v.calendar.google.com` (대한민국의 휴일)

---

## Gmail

### 메일 목록 조회

```bash
# 최근 메일 10개
gws gmail users messages list --params '{"userId": "me", "maxResults": 10}'

# 검색 쿼리 (Gmail 검색 문법 동일)
gws gmail users messages list --params '{"userId": "me", "q": "from:someone@example.com is:unread"}'

# 오늘 받은 메일
gws gmail users messages list --params '{"userId": "me", "q": "after:2026/03/05"}'
```

### 메일 읽기

```bash
# 메일 상세 조회 (id는 list에서 획득)
gws gmail users messages get --params '{"userId": "me", "id": "<messageId>"}'

# 메타데이터만
gws gmail users messages get --params '{"userId": "me", "id": "<messageId>", "format": "metadata"}'
```

### 메일 보내기

```bash
# Base64 인코딩된 RFC 2822 메시지 필요
# raw 필드에 Base64url 인코딩된 메일 내용을 넣음
gws gmail users messages send --params '{"userId": "me"}' \
  --json '{"raw": "<base64url-encoded-message>"}'
```

> **메일 발송 헬퍼**: raw 메시지를 생성할 때 아래 패턴 사용:
> ```bash
> echo -e "To: recipient@example.com\nSubject: 제목\nContent-Type: text/plain; charset=utf-8\n\n본문 내용" | base64 | tr '+/' '-_' | tr -d '='
> ```

### 라벨 관리

```bash
# 라벨 목록
gws gmail users labels list --params '{"userId": "me"}'

# 메일에 라벨 추가/제거
gws gmail users messages modify --params '{"userId": "me", "id": "<messageId>"}' \
  --json '{"addLabelIds": ["UNREAD"], "removeLabelIds": ["INBOX"]}'
```

### 드래프트

```bash
# 드래프트 생성
gws gmail users drafts create --params '{"userId": "me"}' \
  --json '{"message": {"raw": "<base64url-encoded-message>"}}'

# 드래프트 목록
gws gmail users drafts list --params '{"userId": "me"}'
```

---

## Calendar

### 일정 조회

```bash
# 오늘 일정
gws calendar events list --params '{"calendarId": "un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com", "timeMin": "2026-03-05T00:00:00+09:00", "timeMax": "2026-03-05T23:59:59+09:00", "singleEvents": true, "orderBy": "startTime"}'

# 이번 주 일정
gws calendar events list --params '{"calendarId": "un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com", "timeMin": "2026-03-03T00:00:00+09:00", "timeMax": "2026-03-07T23:59:59+09:00", "singleEvents": true, "orderBy": "startTime"}'

# 검색
gws calendar events list --params '{"calendarId": "un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com", "q": "회의"}'
```

### 일정 생성

```bash
gws calendar events insert --params '{"calendarId": "un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com"}' \
  --json '{
    "summary": "팀 회의",
    "location": "회의실 A",
    "description": "주간 스탠드업",
    "start": {"dateTime": "2026-03-05T14:00:00+09:00"},
    "end": {"dateTime": "2026-03-05T15:00:00+09:00"},
    "attendees": [{"email": "colleague@example.com"}],
    "reminders": {"useDefault": false, "overrides": [{"method": "popup", "minutes": 10}]}
  }'

# 종일 일정
gws calendar events insert --params '{"calendarId": "un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com"}' \
  --json '{
    "summary": "연차",
    "start": {"date": "2026-03-10"},
    "end": {"date": "2026-03-11"}
  }'
```

### 일정 수정/삭제

```bash
# 수정
gws calendar events patch --params '{"calendarId": "un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com", "eventId": "<eventId>"}' \
  --json '{"summary": "수정된 제목"}'

# 삭제
gws calendar events delete --params '{"calendarId": "un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com", "eventId": "<eventId>"}'
```

### 캘린더 목록

```bash
gws calendar calendarList list
```

---

## Drive

### 파일 검색/목록

```bash
# 최근 파일 10개
gws drive files list --params '{"pageSize": 10}'

# 이름으로 검색
gws drive files list --params '{"q": "name contains '\''보고서'\''", "pageSize": 10}'

# 특정 폴더 내 파일
gws drive files list --params '{"q": "'\''<folderId>'\'' in parents", "pageSize": 20}'

# 특정 타입 검색
gws drive files list --params '{"q": "mimeType='\''application/vnd.google-apps.spreadsheet'\''", "pageSize": 10}'

# 공유된 파일
gws drive files list --params '{"q": "sharedWithMe=true", "pageSize": 10}'
```

### 파일 다운로드

```bash
# 바이너리 파일 다운로드
gws drive files get --params '{"fileId": "<fileId>", "alt": "media"}' --output ./downloaded-file.pdf

# Google Docs → PDF 내보내기
gws drive files export --params '{"fileId": "<fileId>", "mimeType": "application/pdf"}' --output ./document.pdf

# Google Sheets → CSV
gws drive files export --params '{"fileId": "<fileId>", "mimeType": "text/csv"}' --output ./data.csv
```

### 파일 업로드

```bash
# 파일 업로드
gws drive files create --json '{"name": "report.pdf", "parents": ["<folderId>"]}' \
  --upload ./report.pdf

# 폴더 생성
gws drive files create --json '{"name": "새 폴더", "mimeType": "application/vnd.google-apps.folder"}'
```

### 파일 이동/복사/삭제

```bash
# 파일 이동 (기존 부모에서 제거, 새 부모로 이동)
gws drive files update --params '{"fileId": "<fileId>", "addParents": "<newFolderId>", "removeParents": "<oldFolderId>"}'

# 파일 복사
gws drive files copy --params '{"fileId": "<fileId>"}' \
  --json '{"name": "복사본"}'

# 파일 삭제 (휴지통으로)
gws drive files update --params '{"fileId": "<fileId>"}' \
  --json '{"trashed": true}'
```

### 권한 관리

```bash
# 공유 권한 확인
gws drive permissions list --params '{"fileId": "<fileId>"}'

# 공유 추가
gws drive permissions create --params '{"fileId": "<fileId>"}' \
  --json '{"role": "reader", "type": "user", "emailAddress": "user@example.com"}'
```

---

## Sheets

### 스프레드시트 생성

```bash
gws sheets spreadsheets create --json '{"properties": {"title": "매출 보고서"}}'
```

### 데이터 읽기

```bash
# 범위 읽기
gws sheets spreadsheets.values get --params '{"spreadsheetId": "<id>", "range": "Sheet1!A1:D10"}'

# 여러 범위
gws sheets spreadsheets.values batchGet --params '{"spreadsheetId": "<id>", "ranges": "Sheet1!A1:B5", "ranges": "Sheet2!A1:C3"}'
```

### 데이터 쓰기

```bash
# 값 쓰기
gws sheets spreadsheets.values update \
  --params '{"spreadsheetId": "<id>", "range": "Sheet1!A1", "valueInputOption": "USER_ENTERED"}' \
  --json '{"values": [["이름", "점수"], ["김철수", 95], ["이영희", 88]]}'

# 행 추가
gws sheets spreadsheets.values append \
  --params '{"spreadsheetId": "<id>", "range": "Sheet1!A1", "valueInputOption": "USER_ENTERED"}' \
  --json '{"values": [["새 항목", 100]]}'
```

---

## Docs

### 문서 생성

```bash
gws docs documents create --json '{"title": "회의록 2026-03-05"}'
```

### 문서 읽기

```bash
gws docs documents get --params '{"documentId": "<docId>"}'
```

### 문서 편집

```bash
gws docs documents batchUpdate --params '{"documentId": "<docId>"}' \
  --json '{
    "requests": [
      {"insertText": {"location": {"index": 1}, "text": "새로운 내용 추가\n"}}
    ]
  }'
```

---

## Tasks

### 태스크 목록

```bash
# 태스크 리스트 조회
gws tasks tasklists list

# 태스크 조회
gws tasks tasks list --params '{"tasklist": "<tasklistId>"}'
```

### 태스크 생성

```bash
gws tasks tasks insert --params '{"tasklist": "<tasklistId>"}' \
  --json '{"title": "할 일 제목", "notes": "상세 설명", "due": "2026-03-10T00:00:00.000Z"}'
```

### 태스크 완료

```bash
gws tasks tasks patch --params '{"tasklist": "<tasklistId>", "task": "<taskId>"}' \
  --json '{"status": "completed"}'
```

---

## Chat

### 스페이스 목록

```bash
gws chat spaces list
```

### 메시지 보내기

```bash
gws chat spaces messages create --params '{"parent": "spaces/<spaceId>"}' \
  --json '{"text": "메시지 내용"}'
```

---

## 사용 규칙

1. **스키마 먼저**: 파라미터가 불확실하면 `gws schema <method>` 로 확인 후 실행
2. **dry-run 활용**: 중요한 작업(삭제, 발송 등)은 `--dry-run`으로 미리보기
3. **userId는 "me"**: Gmail에서 현재 사용자는 항상 `"userId": "me"`
4. **일정 쓰기**: MK2JOBS 캘린더(`un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com`)에만 생성/수정/삭제
5. **일정 읽기**: 위 "사용자 계정 설정"의 전체 5개 캘린더를 병렬 조회 후 통합 정리
5. **시간대**: 한국 시간대는 `+09:00` (예: `2026-03-05T14:00:00+09:00`)
6. **페이지네이션**: 대량 데이터 조회 시 `--page-all --page-limit 5`
7. **format 활용**: 사람이 볼 데이터는 `--format table`, 파싱할 데이터는 `--format json`
8. **에러 시**: `accessNotConfigured` 에러 → 해당 API 활성화 필요 (`gws auth setup`)

## 빌트인 워크플로우 (v0.11+)

```bash
# 오늘 회의 + 미완료 태스크 요약
gws wf +standup-report --format table

# 다음 회의 준비 (참석자, 문서, 아젠다)
gws wf +meeting-prep --format table

# 이메일 → 태스크 변환
gws wf +email-to-task --message-id <MSG_ID>

# 주간 다이제스트
gws wf +weekly-digest --format table

# 드라이브 파일을 Chat 스페이스에 공유
gws wf +file-announce --file-id <FILE_ID> --space <SPACE_ID>
```

## 추가 서비스 (v0.11+)

slides, people, chat, classroom, forms, keep, meet, events

## 워크플로우 예시

### 오늘 일정 확인 후 요약 메일 발송

```bash
# 1. 오늘 일정 조회
gws calendar events list --params '{"calendarId": "un7d5jen9nvl4nb6oi7vg44vfo@group.calendar.google.com", "timeMin": "2026-03-05T00:00:00+09:00", "timeMax": "2026-03-05T23:59:59+09:00", "singleEvents": true, "orderBy": "startTime"}' --format table

# 2. 요약 작성 후 메일 발송
# (Claude가 일정 내용을 보고 요약 메일 raw 메시지를 생성)
```

### 드라이브 파일 찾아서 시트로 데이터 추출

```bash
# 1. 파일 검색
gws drive files list --params '{"q": "name contains '\''매출'\'' and mimeType='\''application/vnd.google-apps.spreadsheet'\''", "pageSize": 5}' --format table

# 2. 시트 데이터 읽기
gws sheets spreadsheets.values get --params '{"spreadsheetId": "<찾은ID>", "range": "Sheet1!A1:Z100"}' --format csv
```
