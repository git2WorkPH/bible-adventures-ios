# FND-BASE-T06 — Separate Content and Scripture Repositories

Status: IMPLEMENTED
Approved by: Project owner, 2026-09-08
Implemented: 2026-09-08

## Requirements and findings

- FND-004 — Scripture System
- FND-005 — Dialogue System
- FND-018 — Content Repository
- FND-019 — JSON Content
- FND-024 — Error Handling
- PA-002-002 and PA-002-004

## Implemented scope

- Added reusable story, dialogue, objective, question, Scripture, and raw-data repository contracts.
- Added typed recoverable content errors and a generic in-memory story repository.
- Replaced question-resource fatal termination with injected JSON decoding and validation.
- Moved Noah question resource selection to the Noah content layer.
- Added a minimal recoverable question-unavailable presentation state without redesigning the view.
- Defined the external-content and Scripture-policy boundaries in `Documentation/Architecture/CONTENT-REPOSITORY-CONTRACTS.md`.
- Added focused success, missing, malformed, and invalid-content tests.

## Out of scope preserved

- Noah story content, Scripture wording, JSON migration for stories/dialogue/objectives/Scripture, and visual redesign were not changed.
- No new Bible quotations or content repositories for new stories were added.
- ESV release permission/attribution compliance remains a future content/release verification step.

## Acceptance status

- [x] Reusable repository contracts exist for all required content categories.
- [x] Expected loading failures use typed recoverable errors rather than `fatalError`.
- [x] External JSON question content is decoded and validated through an injected source.
- [x] Missing, malformed, invalid, and absent-item outcomes are represented safely.
- [x] Noah resource selection is outside reusable repository code.
- [x] Scripture content contract is restricted to the approved ESV policy boundary.
- [x] Focused repository tests were added.
- [ ] Unit tests have a recorded passing simulator run.

## Verification

See `Documentation/Acceptance/FND-BASE-T06-VERIFICATION.md`. The task remains `IMPLEMENTED` until focused tests run successfully in a working iOS Simulator environment.
