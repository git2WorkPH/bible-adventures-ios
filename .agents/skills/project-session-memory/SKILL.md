# Project Session Memory

## Purpose
Maintain a compact, durable project context so future AI sessions do not need to reconstruct the entire conversation.

## Start of session
Read `Documentation/SessionMemory/CURRENT-CONTEXT.md` and relevant recent session records.

Summarize:
- current objective
- completed work
- active task
- important decisions
- known issues
- next recommended action

## End of session
Record:
- discussions that changed project direction
- decisions
- requirements/tasks created or changed
- files changed
- tests run/results
- unresolved issues
- next steps

## Rules
- Keep the current context concise.
- Preserve links/IDs to requirements and tasks.
- Do not rewrite history to hide mistakes.
- Do not store secrets, credentials, or unnecessary personal information.
- Session memory is context, not the product source of truth; approved requirements and code remain authoritative.

## Example
```text
Use the project-session-memory skill. Load current context and summarize where we are and the next approved task. Do not implement anything.
```

