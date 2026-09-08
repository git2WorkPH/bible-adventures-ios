# Foundation Implementation Task Proposals

Status: PROPOSED
Date: 2026-09-04
Source: PA-002 — Implementation Traceability Assessment

## Approval boundary

Except for the completed FND-BASE-T01 entry retained for traceability, these are proposed tasks and not authorization to modify application code or content. Approve each task individually and move its approved record to `Documentation/Tasks/Approved/` before implementation. Preserve the Noah prototype unless a task explicitly authorizes adaptation.

## Dependency sequence

`T01 → T02 → T03 → T04 → T05 → T06/T07/T08 → T09 → T10 → T11/T12/T13`

`T01` and `T02` are decision/documentation gates. No foundation code task should begin until both are resolved and the FND-001-T01 task-status conflict has been reconciled.

## FND-BASE-T01 — Reconcile documentation authority and task status

- Status: VERIFIED — canonical record: `Documentation/Tasks/Completed/FND-BASE-T01-RECONCILE-DOCUMENTATION-AND-TASK-STATUS.md`
- Requirements/findings: project workflow; PA-002-002.
- Scope: inventory authoritative versus legacy planning records; reconcile the `FND-001-T01` completion record with the approval-location policy; update traceability records and session memory.
- Out of scope: application-code changes, requirement rewrites, or retrospective verification claims.
- Acceptance: authoritative sources and task locations are recorded; any status conflict is resolved by an owner decision; no task is reclassified as approved/verified without evidence.
- Verification: documentation review with links to the reconciled records.

## FND-BASE-T02 — Approve Scripture integrity policy

- Status: VERIFIED — canonical record: `Documentation/Tasks/Completed/FND-BASE-T02-APPROVE-SCRIPTURE-INTEGRITY-POLICY.md`
- Requirements/findings: PRD-001, FND-004, FND-027, NOAH-002, NOAH-009; PA-002-002.
- Scope: record owner decisions for Scripture source/translation, quotation formatting, Scripture-versus-interpretation-versus-gameplay labels, and the `gopher wood`/`cypress wood` treatment.
- Out of scope: changing Noah wording, adding passages, or implementing a Scripture repository.
- Acceptance: all FND-027 acceptance criteria have approved policy answers; policy identifies future-story applicability.
- Verification: approved decision record and requirement traceability review.

## FND-BASE-T03 — Define centralized story-state contracts

- Status: IMPLEMENTED — canonical record: `Documentation/Tasks/Completed/FND-BASE-T03-DEFINE-CENTRALIZED-STORY-STATE-CONTRACTS.md`
- Requirements/findings: FND-002; PA-002-001.
- Dependencies: FND-BASE-T01; explicit approval of the existing FND-002-T01 proposal; FND-001-T01 status reconciliation.
- Scope: define generic top-level game, active-story, objective, and mini-game state values outside SwiftUI; document ownership and legal state transitions; add focused unit tests.
- Out of scope: observable integration, step advancement, persistence, Noah content changes, and mini-game refactoring.
- Acceptance: contracts represent inactive and active generic sessions; contain no Noah fields or UI callbacks; are independently constructible/testable; `StoryPlayerView` retains behavior until the integration task.
- Verification: unit tests for valid state construction and transition invariants; review confirms no Noah/UI coupling.

## FND-BASE-T04 — Implement reusable Story Engine boundary

- Status: IMPLEMENTED — canonical record: `Documentation/Tasks/Completed/FND-BASE-T04-IMPLEMENT-REUSABLE-STORY-ENGINE.md`
- Requirements/findings: FND-001, PRD-004; PA-002-001.
- Dependencies: FND-BASE-T03.
- Scope: introduce a generic engine interface that loads, starts, exposes the current configured step, completes, and restarts a story through the centralized state contract; use a generic fixture and preserve Noah content.
- Out of scope: conditional/failure/retry rules, persistence, JSON migration, and adapting existing player navigation.
- Acceptance: engine behavior is independent of Noah; start/restart/completion are centrally represented; generic and Noah-compatible fixtures can load; core behavior has unit tests.
- Verification: focused engine unit tests and a no-Noah-dependency review.

## FND-BASE-T05 — Implement progression and activity-result contracts

- Status: IMPLEMENTED — canonical record: `Documentation/Tasks/Completed/FND-BASE-T05-IMPLEMENT-PROGRESSION-AND-ACTIVITY-RESULT-CONTRACTS.md`
- Requirements/findings: FND-003, FND-009; PA-002-001.
- Dependencies: FND-BASE-T04.
- Scope: define typed outcomes and safe transitions for success, failure, retry, and configured conditional paths; make the Story Engine the only owner of progression decisions.
- Out of scope: converting existing Noah views, adding story branches/content, persistence, or reflection.
- Acceptance: success advances only as configured; failure cannot corrupt state; retry is expressible; conditional progression is data-driven; transitions are tested.
- Verification: unit tests for each outcome and an invalid-transition test.

## FND-BASE-T06 — Separate content and Scripture repositories

- Status: IMPLEMENTED — canonical record: `Documentation/Tasks/Completed/FND-BASE-T06-SEPARATE-CONTENT-AND-SCRIPTURE-REPOSITORIES.md`
- Requirements/findings: FND-004, FND-005, FND-018, FND-019, FND-024; PA-002-002, PA-002-004.
- Dependencies: FND-BASE-T02, FND-BASE-T04.
- Scope: define repository contracts for stories, dialogue, objectives, questions, and Scripture references/content; establish recoverable loading errors and content validation; choose the approved external-content boundary.
- Out of scope: new Noah story content, unapproved Scripture wording, full content migration, and UI redesign.
- Acceptance: repositories do not use fatal termination for expected content failures; Scripture sources follow the approved policy; malformed/missing content has a recoverable result; story-specific selection is outside reusable repository logic.
- Verification: repository contract tests for success, missing content, and malformed content.

## FND-BASE-T07 — Implement reusable objective, question, and learning-feedback lifecycle

- Status: VERIFIED — see `Documentation/Tasks/Completed/FND-BASE-T07-OBJECTIVE-QUESTION-LIFECYCLE.md`
- Requirements/findings: FND-006, FND-007, FND-008, FND-010; PA-002-001.
- Dependencies: FND-BASE-T03, FND-BASE-T05, FND-BASE-T06.
- Scope: define objective/question state and completion contracts, randomized answer ordering that preserves answer correctness, reusable feedback/hints, and Scripture-reference attachment.
- Out of scope: new Noah questions, spiritual-achievement scoring, reflection, and persistence.
- Acceptance: objective completion is centrally reportable; questions can randomize answers safely; correct/incorrect feedback and hints are reusable; references survive the lifecycle; behavior has tests.
- Verification: unit tests for randomization/correctness mapping, feedback, retries, and reference propagation.

## FND-BASE-T08 — Implement reusable mini-game lifecycle and adapters

- Status: VERIFIED — see `Documentation/Tasks/Completed/FND-BASE-T08-MINI-GAME-LIFECYCLE.md`
- Requirements/findings: FND-009 through FND-014; PA-002-001.
- Dependencies: FND-BASE-T05, FND-BASE-T06.
- Scope: define mini-game configuration, typed result, start/complete/fail/retry lifecycle, and a generic presentation adapter; identify the narrow adapter path for the existing Noah mini-game views.
- Out of scope: wholesale rewrite of Noah interactions, new mini-games, or story expansion.
- Acceptance: mini-games return typed results to the Story Engine; failure/retry are safe; configuration contains no Noah-specific foundation rules; at least generic lifecycle tests exist.
- Verification: lifecycle unit tests and integration test using a generic fake mini-game.

## FND-BASE-T09 — Implement reusable Scripture-connected reflection

- Status: VERIFIED — see `Documentation/Tasks/Completed/FND-BASE-T09-SCRIPTURE-CONNECTED-REFLECTION.md`
- Requirements/findings: PRD-002, PRD-006, FND-015, NOAH-012; PA-002-003.
- Dependencies: FND-BASE-T02, FND-BASE-T04, FND-BASE-T06.
- Scope: define reflection content/state, Scripture reference linkage, completion handoff, and a reusable presentation contract that asks what the story teaches about GOD.
- Out of scope: declaring game completion a spiritual achievement, writing new Noah reflection copy before content approval, or persistence.
- Acceptance: Story Engine completion can trigger reflection; reflection is reusable and reference-linked; it distinguishes reflection from Scripture according to policy; flow has tests.
- Verification: generic reflection-flow tests and content-policy review.

## FND-BASE-T10 — Implement progress and persistence boundaries

- Status: VERIFIED — see `Documentation/Tasks/Completed/FND-BASE-T10-PROGRESS-PERSISTENCE.md`
- Requirements/findings: FND-016, FND-017; PA-002-004.
- Dependencies: FND-BASE-T03 through T05, FND-BASE-T09.
- Scope: define saveable player/story/objective progress, restore behavior, and appropriate unlock rules without measuring spiritual status; establish a persistence service boundary and recovery behavior.
- Out of scope: cloud sync, analytics, accounts, or new story content.
- Acceptance: story/objective progress can be saved/restored; corrupted/missing saved state recovers safely; progress language does not claim spiritual achievement; behavior is tested.
- Verification: round-trip, missing-data, and corrupted-data persistence tests.

## FND-BASE-T11 — Establish foundation test and acceptance-evidence strategy

- Status: VERIFIED — see `Documentation/Tasks/Completed/FND-BASE-T11-FOUNDATION-TEST-STRATEGY.md`
- Requirements/findings: FND-026; PA-002-004.
- Dependencies: FND-BASE-T04 through T10 as applicable.
- Scope: define unit, integration, UI/device, regression, and acceptance-evidence expectations for reusable foundation capabilities; configure testable seams and records for results.
- Out of scope: certifying currently unverified prototype behavior or broad feature implementation.
- Acceptance: each foundation capability maps to test types and evidence location; blocked environment conditions are recorded separately from test outcomes; the strategy covers engine, repositories, questions, mini-games, reflection, and persistence.
- Verification: reviewed test matrix and a sample evidence record produced by an approved implementation task.

## FND-BASE-T12 — Establish responsive accessibility and reduced-motion standards

- Status: VERIFIED — see `Documentation/Tasks/Completed/FND-BASE-T12-ACCESSIBILITY-STANDARDS.md`
- Requirements/findings: PRD-005, FND-020, FND-023; PA-002-004.
- Dependencies: FND-BASE-T03 and relevant presentation contracts.
- Scope: define reusable requirements and test cases for Dynamic Type, VoiceOver labels/order, touch targets, iPhone/iPad layout, and reduced motion; add reusable support only where later approved.
- Out of scope: visual redesign of Noah scenes or unapproved device-specific content changes.
- Acceptance: measurable standards and validation matrix exist; reduced-motion behavior is specified; each reusable presentation component has an accessibility ownership boundary.
- Verification: documented iPhone/iPad and accessibility test plan; later implementation must record device/manual evidence.

## FND-BASE-T13 — Implement recoverable error handling and structured logging

- Status: PROPOSED
- Requirements/findings: FND-024, FND-025; PA-002-004.
- Dependencies: FND-BASE-T06.
- Scope: define application/content/gameplay error types, user-safe recovery paths, and development/production logging conventions; replace fatal handling only within approved repository/lifecycle scope.
- Out of scope: external telemetry service, user-data collection, or unrelated code cleanup.
- Acceptance: expected repository/content failures produce recoverable results; logs contain useful non-sensitive context; user-facing recovery does not expose internal error details; error paths have tests.
- Verification: tests for missing/malformed content and review of representative log/recovery behavior.

## Deferred work

No Noah expansion, content corrections, full JSON migration, audio, asset-system work, or prototype replacement is proposed for implementation before the relevant decision gates and reusable foundation tasks are approved.
