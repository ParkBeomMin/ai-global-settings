---
name: sentry
description: Reads and analyzes Sentry issues, events, and error trends via API. Use when the user asks for 에러 분석, Sentry 이슈, 프로덕션 오류 확인, or error monitoring.
---

Analyze Sentry errors and issues for the request in $ARGUMENTS.

## Authentication Setup

Requires `SENTRY_AUTH_TOKEN` env var with read-only scopes (`project:read`, `event:read`, `org:read`).

If not set, guide the user:
1. Create token at: https://sentry.io/settings/account/api/auth-tokens/
2. Grant read-only scopes
3. `export SENTRY_AUTH_TOKEN=<token>`

Never ask the user to paste the token in chat.

## Defaults

- Time range: `24h`
- Environment: `prod`
- Limit: 20 (max 50)

## Core API Calls

### List Issues (most recent first)
```bash
curl -H "Authorization: Bearer $SENTRY_AUTH_TOKEN" \
  "https://sentry.io/api/0/projects/{org}/{project}/issues/?query=is:unresolved&statsPeriod=24h&limit=20"
```

### Issue Detail
```bash
curl -H "Authorization: Bearer $SENTRY_AUTH_TOKEN" \
  "https://sentry.io/api/0/issues/{issue_id}/"
```

### Issue Events
```bash
curl -H "Authorization: Bearer $SENTRY_AUTH_TOKEN" \
  "https://sentry.io/api/0/issues/{issue_id}/events/?limit=20"
```

## Output Format

**Issue List:**
- title, short_id, status, first_seen, last_seen, count, environments

**Event Detail:**
- culprit, timestamp, environment, release, url

**Rules:**
- Redact PII (emails, IPs) from output
- Never echo auth tokens
- State explicitly if no results found
- After listing issues, offer root cause analysis for top errors
