---
name: linear
description: Manages Linear issues, projects, and team workflows. Use when the user asks for Linear 이슈 생성, 티켓 업데이트, 스프린트 관리, or project tracking in Linear.
---

Manage Linear issues and workflows for the request in $ARGUMENTS.

## Prerequisites

Requires Linear MCP server connected via OAuth. Verify connection before proceeding.

## Workflow

1. **Clarify** — Confirm goal, team, priority, and timeline if not specified
2. **Read first** — Always fetch current state before making changes
3. **Execute** — Batch related operations; reads before writes
4. **Summarize** — Report what was done and next actions

## Core Operations

### Read Operations
- List issues: by team, project, assignee, status, or priority
- Get issue detail: title, description, status, assignee, due date
- List projects and their progress
- View team members and workspaces

### Write Operations
- Create issue: title, description, team, assignee, priority, due date, labels
- Update issue: status, assignee, priority, or any field
- Add comment to issue
- Create project or milestone

## Issue Priority Levels
- `urgent` / `high` / `medium` / `low` / `no priority`

## Status Workflow
`Backlog` → `Todo` → `In Progress` → `In Review` → `Done`

## Output Format

After operations, report:
- Issues created/updated (with Linear issue IDs and URLs)
- Current status of affected items
- Suggested next actions
