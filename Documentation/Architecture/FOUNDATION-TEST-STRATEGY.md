# Foundation test and acceptance-evidence strategy

Status: VERIFIED
Task: FND-BASE-T11
Requirement/finding: FND-026; PA-002-004.

## Purpose

Every reusable foundation capability must be independently testable, and every verification claim must point to durable evidence in `Documentation/Acceptance/`. A compile, code review, manual observation, or blocked test is never silently promoted to a passing test result.

## Verification levels

| Level | Purpose | Expected location |
|---|---|---|
| Unit | Verify one Foundation model, engine, validator, transition, or recovery rule through public/internal contracts. | `BibleAdventureTests/`; result summarized in `Documentation/Acceptance/<TASK>-VERIFICATION.md`. |
| Integration | Verify two or more real foundation boundaries together, using a deterministic fake only at the external edge. | `BibleAdventureTests/`; result summarized in the task evidence record. |
| UI/device | Verify SwiftUI presentation, navigation, accessibility behavior, responsive layouts, and platform integration on named device/OS combinations. | Test target or manual checklist; screenshots/result bundle links recorded in task evidence. |
| Regression | Preserve behavior affected by a defect or high-risk change. A failing reproduction is added before or with the approved fix when practical. | Relevant automated suite and the fixing task's evidence record. |
| Acceptance review | Match approved acceptance criteria to direct evidence and record limitations. | `Documentation/Acceptance/<TASK>-VERIFICATION.md`. |

Tests use generic fixtures unless a story requirement explicitly requires story-specific content. Foundation tests must not depend on network availability, current time, nondeterministic ordering, production user data, or a concrete storage/repository implementation when an injected seam exists.

## Foundation capability matrix

| Capability | Testable seam | Unit expectations | Integration expectations | UI/device expectations | Regression focus | Evidence location |
|---|---|---|---|---|---|---|
| Story Engine and state | `StoryLoading`, `StoryProgressionLoading`, `StoryEngine` value state | Start/reject, current step, completion, restart, legal/illegal state transitions | Generic loader plus configured progression through completion | Story-player wiring and completion handoff on supported devices when integration is approved | Duplicate starts/completions; invalid content/state | `Documentation/Acceptance/FND-BASE-T03-VERIFICATION.md`, `FND-BASE-T04-VERIFICATION.md`, `FND-BASE-T05-VERIFICATION.md` |
| Content and Scripture repositories | `ContentDataLoading`, repository protocols, `Result` errors | Decode/validation, missing/malformed/invalid/not-found recovery, reference/translation preservation | Injected data source through repository contract to consumer | User-safe unavailable-content presentation; exact ESV label/text review when displayed | Malformed resources, duplicate IDs, source artifacts, policy-label errors | `Documentation/Acceptance/FND-BASE-T06-VERIFICATION.md` and content-task evidence |
| Objectives, questions, feedback | `ObjectiveQuestionSession`, injected/random generator overload | Lifecycle, stable identity/order, answer validation, hints/references, feedback, once-only completion | Generic question session result passed to Story Engine | Answer order, retry feedback, readable labels/order and Dynamic Type when view integration is approved | Wrong-answer retry, stale/double completion, randomization identity | `Documentation/Acceptance/FND-BASE-T07-VERIFICATION.md` |
| Mini-games | `MiniGameAdapter`, `MiniGameConfiguration`, attempt token | Start/complete/fail/retry, stale/duplicate callbacks, configuration validation | Generic fake mini-game result passed to Story Engine | Each game adapter/view on required devices after separately approved wiring | Failure branch, retry token, repeated completion | `Documentation/Acceptance/FND-BASE-T08-VERIFICATION.md` plus game-specific evidence |
| Reflection | `ReflectionSession.afterStoryCompletion`, `ReflectionPresentation` | Completion gate, lifecycle, reference linkage, required GOD-centered question and labels | Completed Story Engine handed to generic reflection session | Scripture/Interpretation distinction, navigation and reading layout after approved view work | Early/repeated actions; Scripture mislabeled as reflection | `Documentation/Acceptance/FND-BASE-T09-VERIFICATION.md` and story-content evidence |
| Progress and persistence | `ProgressDataStoring`, `ProgressPersistenceService`, Codable snapshots | Round trip, schema/semantic validation, missing/corrupt/unavailable recovery, unlock rules | Coordinator save/restore through a deterministic fake store; production adapter later | Relaunch/restore and user-safe recovery on supported devices after adapter integration | Migration/version changes, partial/corrupt writes, inappropriate unlocks | `Documentation/Acceptance/FND-BASE-T10-VERIFICATION.md` and storage-adapter evidence |

## Result vocabulary

Every evidence item uses one of these outcomes:

- `PASS`: the named check ran or was reviewed and satisfied its stated criterion.
- `FAIL`: the named check ran and did not satisfy its criterion.
- `BLOCKED`: the check did not complete because a named external/environment condition prevented it.
- `NOT RUN`: the check was in scope but was not attempted; state why.
- `NOT APPLICABLE`: the approved scope does not require the check; state why.

`REVIEWED` may describe a review activity but is not interchangeable with an automated `PASS`. A task can be `IMPLEMENTED` while required verification is blocked. It becomes `VERIFIED` only when its approved acceptance criteria have adequate passing evidence; narrow domain verification must explicitly exclude untested UI/runtime claims.

## Blocked-environment rule

Record a blocker separately from test outcome:

- exact command/check and intended target;
- date and environment (platform, OS/device/runtime when relevant);
- observed blocker and diagnostic evidence;
- what, if anything, still passed independently;
- rerun condition and outstanding verification;
- no pass/fail claim for a check that never executed.

When the environment becomes available, append or supersede the blocker with the rerun result. Do not rewrite history to imply the earlier blocked run passed.

## Acceptance evidence record

Use `Documentation/Acceptance/ACCEPTANCE-EVIDENCE-TEMPLATE.md`. Each record must identify requirement/task, approved scope and exclusions, criterion-to-evidence mapping, exact commands or manual procedure, environment, result counts, limitations/blockers, reviewed files, and final status rationale. Evidence filenames use the task or requirement ID so they remain traceable.

The FND-BASE-T11 verification record is the sample populated record for this strategy. Existing T03–T06 records correctly keep simulator-blocked unit execution separate from successful source checks; this strategy does not retroactively certify those tasks.
