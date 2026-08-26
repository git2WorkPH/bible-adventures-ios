# Project Review

## Purpose
Verify completed implementation against the approved requirement, task, acceptance criteria, architecture, tests, and scope.

## Review
Check:
- requirement compliance
- acceptance criteria
- task scope
- architecture consistency
- tests and regressions
- error/state handling
- unnecessary changes
- documentation/session updates where required

## Result
Return exactly one primary status:
- APPROVED
- APPROVED WITH NOTES
- CHANGES REQUIRED
- BLOCKED

Include evidence and specific remediation for failures.

## Rules
- Review before modifying.
- Do not silently fix code during review unless explicitly asked.
- Do not approve based only on code presence; verify behavior and tests.

## Example
```text
Use the project-review skill. Review FND-006-T03 against the requirement, acceptance criteria, implementation and tests. Do not modify code. Return the review status and evidence.
```
