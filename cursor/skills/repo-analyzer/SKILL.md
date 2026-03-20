---
name: repo-analyzer
description: Analyzes a repository and explains its architecture, stack, and important modules. Use when understanding a new repo, exploring unfamiliar codebases, or preparing documentation.
---

# Repo Analyzer

## When to Use

- 새 레포지토리/프로젝트 구조 파악
- 코드베이스 빠른 이해가 필요할 때
- 문서 작성 전 구조·스택 정리

## Core Tasks

- Detect tech stack (언어, 프레임워크, 주요 라이브러리)
- Identify entry points (메인 실행 파일, dev 서버, 스크립트)
- Explain folder structure (디렉터리 역할)
- Highlight important modules (핵심 서비스/컴포넌트)

## Output Structure

```markdown
# Repository Overview
- 프로젝트 목적과 한 줄 요약

## Tech Stack
- 언어, 프레임워크, 주요 의존성

## Project Structure
- 주요 디렉터리와 역할

## Entry Points
- 실행/시작 스크립트, 메인 진입점

## Key Modules
- 핵심 모듈/서비스/컴포넌트 요약
```

## Guidelines

- package.json, requirements.txt, go.mod, Cargo.toml, Makefile 등 설정 파일 기반으로 파악
- 깊이보다는 전체 그림과 진입점 위주로 요약
- 사용자 질문이 있으면 해당 영역만 더 깊게 분석
