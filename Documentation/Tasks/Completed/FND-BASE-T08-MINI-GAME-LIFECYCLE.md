# FND-BASE-T08 — Implement reusable mini-game lifecycle and adapters

Status: VERIFIED
Date: 2026-09-08
Authorization: project owner requested implementation of the task recorded in `Documentation/Tasks/Approved/README.md`.
Requirements/findings: FND-009 through FND-014; PA-002-001.
Dependencies: FND-BASE-T05, FND-BASE-T06 (implemented; their prior verification limitations remain).

## Implemented scope

Added story-neutral mini-game configuration, typed completed/failed results, attempt-token-protected start/result/retry handling, and a presentation-neutral adapter that passes outcomes to StoryEngine. Documented the narrow adapter path for existing Noah completion callbacks without changing those views.

## Acceptance and review

- [x] Typed mini-game results flow to StoryEngine.
- [x] Failure/retry and repeated/stale callbacks are safe in focused tests.
- [x] Configuration contains no Noah-specific foundation rules.
- [x] Generic lifecycle tests and fake mini-game integration test pass.
- [x] Existing Noah adapter path documented; no new mini-games or story expansion.

Evidence: `Documentation/Acceptance/FND-BASE-T08-VERIFICATION.md` (4 tests passed).
Contract: `Documentation/Architecture/MINI-GAME-LIFECYCLE.md`.

Verification covers this narrow domain task, not full iOS integration or completion of all FND-009–014 requirements. Runtime view integration remains outside this task.
