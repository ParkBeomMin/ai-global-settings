---
name: notebooklm
description: NotebookLM 자동화. 노트북 생성, 소스 추가, 오디오 생성.
disable-model-invocation: true---

# NotebookLM 자동화 스킬

notebooklm-py (비공식 Python SDK)를 사용하여 Google NotebookLM을 CLI/Python으로 조작한다.

## 전제 조건

### 1. 설치 확인

```bash
uv tool list | grep notebooklm
```

미설치 시 사용자에게 안내:
```bash
uv tool install "notebooklm-py[browser]"   # browser는 최초 로그인용 Playwright 포함
```

### 2. 인증 확인

```bash
ls ~/.notebooklm/storage_state.json
```

미인증 시 사용자에게 안내:
```bash
notebooklm login
# → Chromium 브라우저가 뜨면 Google 계정으로 로그인
# → 로그인 완료 후 자동으로 쿠키가 저장됨
# → 무료 Google 계정으로 사용 가능
```

**중요**: 세션은 약 1~2주 유효. 만료 시 `notebooklm login` 재실행 필요.
인증 실패 에러 발생 시 "세션이 만료되었을 수 있습니다. `notebooklm login`을 다시 실행해주세요." 안내.

## CLI 사용법

### 노트북 목록 조회
```bash
notebooklm list
```

### 노트북 생성
```bash
notebooklm create "노트북 제목"
```

### 현재 노트북 설정
```bash
notebooklm use "노트북ID"
```

### 소스 추가 (URL / YouTube)
```bash
notebooklm source add -n "노트북ID" "https://www.youtube.com/watch?v=..."
notebooklm source add -n "노트북ID" "https://example.com/article"
notebooklm source add -n "노트북ID" --type youtube "URL"   # 타입 명시
notebooklm source add -n "노트북ID" --type url "URL"       # 웹페이지
notebooklm source add -n "노트북ID" --type text "내용"     # 인라인 텍스트
notebooklm source add -n "노트북ID" ./doc.md               # 파일
```

YouTube URL은 트랜스크립트 기반으로 자동 처리된다.
**참고**: yt-dlp에서 "no subtitles"로 표시되는 영상도 NotebookLM이 자체적으로 트랜스크립트를 추출하여 처리 가능한 경우가 많다 (2026-03-11 확인). 따라서 yt-dlp 자막 체크는 참고용이며, 실제로는 바로 `source add`를 시도하는 것이 더 효율적이다. 비공개 영상이나 극히 짧은 영상 등 일부만 실패한다.

### 소스 목록 확인
```bash
notebooklm source list -n "노트북ID"
```

### 소스 대기 (처리 완료까지)
```bash
notebooklm source wait -n "노트북ID"
```

### Q&A (질문)
```bash
notebooklm ask -n "노트북ID" "질문 내용"
```

### 아티팩트 생성
```bash
notebooklm generate audio -n "노트북ID"       # 오디오 오버뷰
notebooklm generate quiz -n "노트북ID"        # 퀴즈
notebooklm generate mind-map -n "노트북ID"    # 마인드맵
notebooklm generate report -n "노트북ID"      # 보고서
notebooklm generate flashcards -n "노트북ID"  # 플래시카드
notebooklm generate slide-deck -n "노트북ID"  # 슬라이드
```

### 아티팩트 다운로드
```bash
notebooklm download audio -n "노트북ID"
```

### 노트 관리
```bash
notebooklm note list -n "노트북ID"
notebooklm note create -n "노트북ID" --title "제목" --content "내용"
```

### 대화 기록
```bash
notebooklm history -n "노트북ID"
```

## 자막 유무 사전 확인 (YouTube) — 참고용

yt-dlp로 자막 유무를 확인할 수 있지만, **NotebookLM은 자체 트랜스크립트 추출 능력**이 있어 yt-dlp에서 "no subtitles"로 표시되는 영상도 처리 가능한 경우가 많다.
```bash
yt-dlp --list-subs --no-warnings "https://www.youtube.com/watch?v=VIDEO_ID" 2>&1 | head -20
```
**권장**: 자막 체크를 생략하고 바로 `source add`를 시도. 실패 시에만 자막 유무를 확인한다.

## 통합 파이프라인: YouTube 검색 → NotebookLM → Obsidian

사용자가 "유튜브에서 {주제} 영상 N개 검색해서 NotebookLM에 추가해줘" 같은 요청을 하면:

### Step 1: YouTube 검색 (yt-search 스킬)
```bash
yt-dlp "ytsearch5:{주제}" --flat-playlist --print "%(id)s\t%(title)s" --no-warnings
```

### Step 2: NotebookLM 노트북 생성 + 소스 추가
```bash
notebooklm create "리서치: {주제}"
# 검색된 각 URL에 대해:
notebooklm source add -n "노트북ID" "https://www.youtube.com/watch?v={id}"
```

### Step 3: 3단계 심층 분석 (사용자가 요청한 경우)

소스 추가 후, 3단계 Q&A로 깊이 있는 분석을 수행한다:

**1단계 — 상세 요약**: 각 영상별 핵심 주제, 주요 내용(타임스탬프 포함), 실용적 팁, 핵심 인사이트를 500자 이상으로 정리
```bash
notebooklm ask -n "노트북ID" "각 영상별로 핵심 주제, 주요 내용(타임스탬프 포함, 각 포인트 2-3문장), 실용적 팁/도구, 핵심 인사이트를 상세하게 정리해줘. 각 영상당 최소 500자 이상."
```

**2단계 — 확장 질문**: 주제에 맞는 심층 질문 4-6개를 생성하여 추가 분석
```bash
notebooklm ask -n "노트북ID" "다음 질문들에 대해 영상 소스를 기반으로 상세하게 답변해줘: 1. {질문1} 2. {질문2} ... 각 질문당 최소 300자 이상."
```

**3단계 — 종합 분석**: 영상 간 공통 주제, 트렌드, 연결점 분석
```bash
notebooklm ask -n "노트북ID" "영상들 사이에 공통적으로 관통하는 주제와 트렌드는? 영상들 간의 연결점을 분석하고 핵심 흐름을 정리해줘."
```

### Step 4: Obsidian 저장 (사용자가 요청한 경우)
분석 결과를 vault에 마크다운 노트로 저장:
- 경로: `3-Resources/유튜브/` (YouTube 리서치) 또는 적절한 하위 폴더
- 파일명: `YYYY-MM-DD-{주제}-영상-리서치.md`
- frontmatter: `tags: [type/reference, source/youtube, source/notebooklm]`
- 구조:
  - 분석 대상 영상 테이블 (제목, 채널, 조회수, URL)
  - 각 영상별 상세 분석 (1단계 결과)
  - 확장 Q&A (2단계 결과)
  - 종합 분석 / 트렌드 (3단계 결과)
  - 파이프라인 메타 정보 (노트북 ID, 분석 일자, 도구)

## 제한사항

- **비공식 API**: Google이 내부 API를 변경하면 예고 없이 깨질 수 있음
- **세션 만료**: 1~2주마다 `notebooklm login` 재실행 필요
- **무료 계정 제한**: 노트북 수, 소스 수, Audio Overview 생성 횟수에 제한 있음
- **YouTube 소스**: 공개 영상 + 자막이 있는 영상만 지원 (한국 예능 클립은 자막 없는 경우 많음)
- **에러 시**: "API returned no data" → 자막 없는 영상이거나 세션 만료. 세션 확인 후 자막 유무 체크
