# Approved Tasks

Only explicitly approved tasks belong here.

The development skill may implement tasks from this folder. Proposed tasks remain unapproved until the project owner approves them.

## FND-BASE-T07 — Implement reusable objective, question, and learning-feedback lifecycle

- Status: VERIFIED (approval retained below)
- Requirements/findings: FND-006, FND-007, FND-008, FND-010; PA-002-001.
- Dependencies: FND-BASE-T03, FND-BASE-T05, FND-BASE-T06.
- Scope: define objective/question state and completion contracts, randomized answer ordering that preserves answer correctness, reusable feedback/hints, and Scripture-reference attachment.
- Out of scope: new Noah questions, spiritual-achievement scoring, reflection, and persistence.
- Acceptance: objective completion is centrally reportable; questions can randomize answers safely; correct/incorrect feedback and hints are reusable; references survive the lifecycle; behavior has tests.
- Verification: unit tests for randomization/correctness mapping, feedback, retries, and reference propagation.

Completion: FND-BASE-T07 is VERIFIED; see `Documentation/Tasks/Completed/FND-BASE-T07-OBJECTIVE-QUESTION-LIFECYCLE.md`. Approval above is retained as history; no additional task is authorized.
