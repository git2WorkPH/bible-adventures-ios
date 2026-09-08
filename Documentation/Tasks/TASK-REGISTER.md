# Task Register

Status: Active
Last reconciled: 2026-09-04
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
| FND-BASE-T03 — Define centralized story-state contracts | IMPLEMENTED | `Documentation/Tasks/Completed/FND-BASE-T03-DEFINE-CENTRALIZED-STORY-STATE-CONTRACTS.md` | Explicitly approved by the project owner on 2026-09-04. Unit-test execution is unverified because no iOS Simulator is available in the assessment environment. |
| FND-BASE-T04 — Implement reusable Story Engine boundary | IMPLEMENTED | `Documentation/Tasks/Completed/FND-BASE-T04-IMPLEMENT-REUSABLE-STORY-ENGINE.md` | Explicitly approved by the project owner on 2026-09-08. Unit-test execution remains unverified because no iOS Simulator is available in the assessment environment. |
| FND-BASE-T05 — Implement progression and activity-result contracts | IMPLEMENTED | `Documentation/Tasks/Completed/FND-BASE-T05-IMPLEMENT-PROGRESSION-AND-ACTIVITY-RESULT-CONTRACTS.md` | Explicitly approved by the project owner on 2026-09-08. Unit-test execution remains unverified because no iOS Simulator is available in the assessment environment. |
| FND-BASE-T06 — Separate content and Scripture repositories | IMPLEMENTED | `Documentation/Tasks/Completed/FND-BASE-T06-SEPARATE-CONTENT-AND-SCRIPTURE-REPOSITORIES.md` | Explicitly approved by the project owner on 2026-09-08. Unit-test execution remains unverified because no iOS Simulator is available in the assessment environment. |
| FND-001-T01 — Define Reusable Story Model | IMPLEMENTED | Legacy source record: `Documentation/Tasks/FND-001-T01-DEFINE-STORY-MODEL.md` | Implemented before the current approved-task location policy was enforced. It is not retroactively classified as approved or verified. Automated verification remains unrecorded. |
| FND-002-T01 — Define Foundation Game State | PROPOSED | `Documentation/Tasks/FND-002-T01-DEFINE-GAME-STATE.md` | Remains outside the approved-task area and cannot be implemented until explicitly approved and recorded under `Approved/`. |
| FND-BASE-T07 | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T07-OBJECTIVE-QUESTION-LIFECYCLE.md` | Four focused domain tests passed on 2026-09-08; full iOS target not run. |
| FND-BASE-T08 | VERIFIED | `Documentation/Tasks/Completed/FND-BASE-T08-MINI-GAME-LIFECYCLE.md` | Four focused domain tests passed on 2026-09-08; full iOS target not run. |
| FND-BASE-T09 through FND-BASE-T13 | PROPOSED | `Documentation/Tasks/Proposed/FOUNDATION-IMPLEMENTATION-PROPOSALS.md` | Proposed only; no implementation authority. |

## Legacy planning documents

`Documentation/Tasks/FOUNDATION-TASKS.md` and `Documentation/Tasks/FOUNDATION-BASELINE-TASKS.md` are planning indexes. Their checklists and historical status labels are not task authorization or completion evidence; use this register and the canonical task records for current status.
