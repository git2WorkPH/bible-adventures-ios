# Approved Tasks

Only explicitly approved tasks belong here.

The development skill may implement tasks from this folder. Proposed tasks remain unapproved until the project owner approves them.

## FND-BASE-T08 — Implement reusable mini-game lifecycle and adapters

- Status: VERIFIED — see `Documentation/Tasks/Completed/FND-BASE-T08-MINI-GAME-LIFECYCLE.md`
- Requirements/findings: FND-009 through FND-014; PA-002-001.
- Dependencies: FND-BASE-T05, FND-BASE-T06.
- Scope: define mini-game configuration, typed result, start/complete/fail/retry lifecycle, and a generic presentation adapter; identify the narrow adapter path for the existing Noah mini-game views.
- Out of scope: wholesale rewrite of Noah interactions, new mini-games, or story expansion.
- Acceptance: mini-games return typed results to the Story Engine; failure/retry are safe; configuration contains no Noah-specific foundation rules; at least generic lifecycle tests exist.
- Verification: lifecycle unit tests and integration test using a generic fake mini-game.
