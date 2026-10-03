# Project handover process

Applies to every current and future project task. Owner requested this process on 2026-10-03 so work can continue after credit exhaustion, interruption, context loss or a change of agent.

## Files and authority

- CURRENT-CONTEXT.md: short current checkpoint, active work, approval boundary, blockers and next action.
- SESSION-CONTEXT.md: session results and decisions with links to authoritative records; preserve useful history.
- TECHNICAL-HANDOVER.md: latest actionable technical state. Refresh it as work changes.
- HANDOVER-TEMPLATE.md: reusable checklist for a task handover. For multiple unfinished tasks, use one section per task or linked task-specific files.

These files summarize the requirements, task register, decisions and acceptance evidence; they do not create approval or replace those records.

## Checkpoint rules

Update the checkpoint and handover after meaningful edits, decisions, test results, changes of blocker or task, and Git operations. Save a checkpoint before long builds/tests, branch switches, externally visible actions, and ending a session. When a credit/usage warning is visible, save immediately before further work. Do not depend on receiving a warning: interruptions can occur between tool calls, so maintain checkpoints during normal work.

Record work still running, including command, session/process identifier, logs and result paths. Mark a launched test RUNNING until its actual result is read. If a command is interrupted, record possible partial effects. On resume, inspect existing processes/artifacts before relaunching; avoid duplicate test runs, writes or pushes.

Use exact verified paths, commit IDs, test counts and device configurations. Distinguish agent observations, owner reports and assumptions. Keep failed checks alongside passing reruns. Never store passwords, tokens, personal data or full sensitive logs in handovers.

## Resume procedure

1. Read AGENTS.md, project documents, CURRENT-CONTEXT.md and TECHNICAL-HANDOVER.md.
2. Read the linked approved task, requirements, decisions and latest acceptance record.
3. Inspect Git status, current branch and changed files; preserve user edits and stashes.
4. Check whether recorded operations finished and inspect their output before repeating anything.
5. Continue from the first incomplete authorized step. Ask only for missing information or approval outside existing authorization.
6. Update task/evidence/session records from actual outcomes. Mark VERIFIED only when all required criteria have evidence.

After task completion, replace the active handover with the next task's actual state and retain links to completed records. New tasks still follow Requirements -> Assessment -> Finding -> Decision -> Proposed Task -> Approval -> Implementation -> Test -> Review -> Verified -> Session Memory.
