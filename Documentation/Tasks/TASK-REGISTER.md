# Task Register

Status: Active
Last reconciled: 2026-10-03
Authority: This register records task location and status. It is governed by `Documentation/Tasks/TASK-STATUS-POLICY.md`.

## Authoritative locations

| Record | Authoritative location | Rule |
|---|---|---|
| Proposed task | `Documentation/Tasks/Proposed/` | Does not authorize implementation. |
| Approved task | `Documentation/Tasks/Approved/` | Only an explicitly approved task may be implemented. |
| Completed task | `Documentation/Tasks/Completed/` | Contains implementation scope, verification, and follow-up status. |
| Acceptance evidence | `Documentation/Acceptance/` | Supports, but does not replace, a task status record. |
| Assessment finding | `Documentation/Assessment/` | Observes gaps; does not approve a task. |
| Session memory | `Documentation/SessionMemory/` | Context only; does not override the records above. |

## Reconciled records

| Task | Canonical status | Canonical record | Reconciliation |
|---|---|---|---|
| FND-BASE-T01 — Reconcile documentation authority and task status | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T01-RECONCILE-DOCUMENTATION-AND-TASK-STATUS.md` | Explicitly approved by the project owner on 2026-09-04 and verified by documentation review. |
| FND-BASE-T02 — Approve Scripture integrity policy | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T02-APPROVE-SCRIPTURE-INTEGRITY-POLICY.md` | Explicitly approved by the project owner on 2026-09-04; policy decisions and traceability review are recorded. |
| FND-BASE-T03 — Define centralized story-state contracts | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T03-DEFINE-CENTRALIZED-STORY-STATE-CONTRACTS.md` | Approved scope verified by the passing 2026-10-03 iOS Simulator unit suite; see PA-003-T01-VERIFICATION.md. |
| FND-BASE-T04 — Implement reusable Story Engine boundary | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T04-IMPLEMENT-REUSABLE-STORY-ENGINE.md` | Approved scope verified by the passing 2026-10-03 iOS Simulator unit suite; see PA-003-T01-VERIFICATION.md. |
| FND-BASE-T05 — Implement progression and activity-result contracts | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T05-IMPLEMENT-PROGRESSION-AND-ACTIVITY-RESULT-CONTRACTS.md` | Approved scope verified by the passing 2026-10-03 iOS Simulator unit suite; see PA-003-T01-VERIFICATION.md. |
| FND-BASE-T06 — Separate content and Scripture repositories | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T06-SEPARATE-CONTENT-AND-SCRIPTURE-REPOSITORIES.md` | Approved scope verified by the passing 2026-10-03 iOS Simulator unit suite; see PA-003-T01-VERIFICATION.md. |
| FND-001-T01 — Define Reusable Story Model | IMPLEMENTED | Legacy source record: `Documentation/Tasks/FND-001-T01-DEFINE-STORY-MODEL.md` | Implemented before the current approved-task location policy was enforced. It is not retroactively classified as approved or verified. Automated verification remains unrecorded. |
| FND-002-T01 — Define Foundation Game State | PROPOSED | `Documentation/Tasks/FND-002-T01-DEFINE-GAME-STATE.md` | Remains outside the approved-task area and cannot be implemented until explicitly approved and recorded under `Approved/`. |
| FND-BASE-T07 | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T07-OBJECTIVE-QUESTION-LIFECYCLE.md` | Four focused domain tests passed on 2026-09-08; full iOS target not run. |
| FND-BASE-T08 | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T08-MINI-GAME-LIFECYCLE.md` | Four focused domain tests passed on 2026-09-08; full iOS target not run. |
| FND-BASE-T09 | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T09-SCRIPTURE-CONNECTED-REFLECTION.md` | Four focused reflection tests and content-policy review passed on 2026-09-08; full iOS target not run. |
| FND-BASE-T10 | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T10-PROGRESS-PERSISTENCE.md` | Four focused persistence tests passed on 2026-09-08; full iOS target not run. |
| FND-BASE-T11 | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T11-FOUNDATION-TEST-STRATEGY.md` | Foundation matrix and sample acceptance record reviewed on 2026-09-08; no prior blocked behavior was certified. |
| FND-BASE-T12 | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T12-ACCESSIBILITY-STANDARDS.md` | Standards and validation matrix reviewed on 2026-09-08; prototype/device behavior was not certified. |
| FND-BASE-T13 | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T13-ERROR-HANDLING-LOGGING.md` | Four focused recovery/logging tests passed on 2026-09-08; full iOS target not run. |

## Legacy planning documents

`Documentation/Tasks/FOUNDATION-TASKS.md` and `Documentation/Tasks/FOUNDATION-BASELINE-TASKS.md` are planning indexes. Their checklists and historical status labels are not task authorization or completion evidence; use this register and the canonical task records for current status.


## PA-003 owner-approved sequence — 2026-10-03

Approval: Approved/PA-003-APPROVED-TASKS.md. T01–T03 and T05–T07: VERIFIED. T04: IMPLEMENTED, final owner content review pending. T08: IMPLEMENTED; final acceptance checks remain open. Current evidence supersedes the historical Simulator blocker for foundation T03–T06; see PA-003-T01-VERIFICATION.md. All in-scope follow-up work is authorized by the owner.

| Task | Canonical status | Record / evidence |
|---|---|---|
| PA-003-T01 | VERIFIED | Completed/PA-003-T01-REPAIR-UNIT-TESTS.md |
| PA-003-T02 | VERIFIED | Completed/PA-003-T02-PROJECT-SCOPE.md |
| PA-003-T03 | VERIFIED | Completed/PA-003-T03-RUNTIME-DESIGN.md |
| PA-003-T04 | IMPLEMENTED | Completed/PA-003-T04-NOAH-CONTENT.md; final owner content review pending |
| PA-003-T05 | VERIFIED | Completed/PA-003-T05-NOAH-RUNTIME.md |
| PA-003-T06 | VERIFIED | Completed/PA-003-T06-NOAH-REFLECTION.md |
| PA-003-T07 | VERIFIED | Completed/PA-003-T07-NOAH-PERSISTENCE.md |
| PA-003-T08 | IMPLEMENTED | Completed/PA-003-T08-NOAH-DEVICE-ACCEPTANCE.md; full manual acceptance remains outstanding |
