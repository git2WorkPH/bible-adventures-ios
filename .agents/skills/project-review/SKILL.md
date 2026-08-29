# Project Review Skill

## Purpose
Verify implementation against the approved requirement, task, acceptance criteria, architecture, and tests.

## Rules
1. Read the requirement before reviewing.
2. Read the approved task and acceptance criteria.
3. Inspect actual code changes.
4. Do not assume code presence means completion.
5. Do not modify code during review unless explicitly asked to perform a repair task.
6. Identify scope expansion and unrelated changes.
7. Verify appropriate tests and record evidence.
8. Use `IMPLEMENTED_VERIFIED` only when acceptance criteria and evidence support it.

## Result
Return one primary result: `APPROVED`, `APPROVED_WITH_NOTES`, `CHANGES_REQUIRED`, or `BLOCKED`. Then report requirement, task, files reviewed, acceptance criteria, evidence, scope deviations, risks, and follow-ups.

## Important distinction
A task can be `IMPLEMENTED` while its requirement remains `IMPLEMENTED_UNVERIFIED`.
