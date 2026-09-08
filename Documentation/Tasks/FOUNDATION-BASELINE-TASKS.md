# Foundation Baseline Tasks

Status: Historical proposal index; current task status is recorded in `Documentation/Tasks/TASK-REGISTER.md`.
Source: Baseline repository assessment dated 2026-08-29

These tasks are not approved by the assessment itself.

## Phase 0 — Documentation and decisions

### FND-BASE-T01 — Reconcile authoritative documentation
- Status: VERIFIED
- Canonical record: `Documentation/Tasks/Completed/FND-BASE-T01-RECONCILE-DOCUMENTATION-AND-TASK-STATUS.md`
- Goal: Establish `Documentation/` as the authoritative source.
- Acceptance:
  - [ ] Legacy duplicate sources identified.
  - [ ] Authoritative documents identified.
  - [ ] Conflicting status records reconciled.
  - [ ] Session memory updated.

### FND-BASE-T02 — Approve Scripture integrity policy
- Status: VERIFIED
- Canonical record: `Documentation/Tasks/Completed/FND-BASE-T02-APPROVE-SCRIPTURE-INTEGRITY-POLICY.md`
- Requirement: FND-027
- Acceptance:
  - [ ] Scripture source/translation policy approved.
  - [ ] Scripture vs interpretation vs gameplay policy approved.
  - [ ] Noah wood terminology decision recorded.
  - [ ] Policy applies to future stories.

## Phase 1 — Story foundation

### FND-BASE-T03 — Define Story State contract
- Status: IMPLEMENTED
- Canonical record: `Documentation/Tasks/Completed/FND-BASE-T03-DEFINE-CENTRALIZED-STORY-STATE-CONTRACTS.md`
- Requirement: FND-002
- Acceptance:
  - [ ] Central story state model defined.
  - [ ] Current step is not owned solely by a SwiftUI view.
  - [ ] Completion is centrally represented.
  - [ ] State behavior has unit tests.

### FND-BASE-T04 — Define Story Engine contract
- Status: IMPLEMENTED
- Canonical record: `Documentation/Tasks/Completed/FND-BASE-T04-IMPLEMENT-REUSABLE-STORY-ENGINE.md`
- Requirement: FND-001
- Dependencies: FND-BASE-T03
- Acceptance:
  - [ ] Engine can start a story.
  - [ ] Engine advances according to story data.
  - [ ] Engine reports completion.
  - [ ] Engine is independent of Noah-specific content.
  - [ ] Core behavior is tested.

### FND-BASE-T05 — Define progression contract
- Status: IMPLEMENTED
- Canonical record: `Documentation/Tasks/Completed/FND-BASE-T05-IMPLEMENT-PROGRESSION-AND-ACTIVITY-RESULT-CONTRACTS.md`
- Requirement: FND-003
- Dependencies: FND-BASE-T04
- Acceptance:
  - [ ] Success advances progression.
  - [ ] Failure can be represented safely.
  - [ ] Retry can be represented.
  - [ ] Conditional progression is supported where required.
  - [ ] Transition behavior is tested.

## Phase 2 — Reusable content/game contracts

### FND-BASE-T06 — Separate Scripture/content repository concerns
- Status: IMPLEMENTED
- Canonical record: `Documentation/Tasks/Completed/FND-BASE-T06-SEPARATE-CONTENT-AND-SCRIPTURE-REPOSITORIES.md`
- Requirements: FND-004, FND-018, FND-019

### FND-BASE-T07 — Establish objective/question lifecycle
- Status: PROPOSED
- Requirements: FND-006, FND-007, FND-008

### FND-BASE-T08 — Establish mini-game lifecycle
- Status: PROPOSED
- Requirements: FND-009–014

## Phase 3 — Completion and persistence

### FND-BASE-T09 — Establish reflection contract
- Status: PROPOSED
- Requirements: FND-015, PRD-006
- Acceptance:
  - [ ] Story completion can trigger reflection.
  - [ ] Reflection connects to Scripture.
  - [ ] Reflection asks what the story teaches about GOD.
  - [ ] Reflection is reusable.

### FND-BASE-T10 — Establish progress and persistence
- Status: PROPOSED
- Requirements: FND-016, FND-017

## Phase 4 — Quality foundations

### FND-BASE-T11 — Establish foundation testing strategy
- Status: PROPOSED
- Requirement: FND-026

### FND-BASE-T12 — Establish accessibility and reduced-motion standards
- Status: PROPOSED
- Requirements: FND-020, FND-023

### FND-BASE-T13 — Establish repository error/logging strategy
- Status: PROPOSED
- Requirements: FND-024, FND-025

## Explicitly deferred
Do not expand Noah with new story content until required foundation contracts are approved. Do not discard or rewrite the Noah prototype solely because it differs from the target architecture. Adapt it incrementally through approved tasks.
