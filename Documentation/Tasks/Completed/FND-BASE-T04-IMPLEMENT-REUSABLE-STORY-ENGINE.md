# FND-BASE-T04 — Implement Reusable Story Engine Boundary

Status: IMPLEMENTED
Approved by: Project owner, 2026-09-08
Implemented: 2026-09-08

## Requirements and finding

- FND-001 — Story Engine
- PRD-004 — Reusable Foundation
- PA-002-001 — Prototype progression bypasses the planned foundation boundary

## Implemented scope

- Added `StoryLoading` and `StoryEngine` under `BibleAdventure/Core/StoryEngine.swift`.
- Added injected loading, start, current-story/current-step access, completion, and restart behavior using `GameState` and `StoryState`.
- Added focused tests with an in-memory generic fixture plus Noah compatibility coverage.
- Documented the supported boundary and deliberately deferred behavior in `Documentation/Architecture/STORY-ENGINE-CONTRACT.md`.

## Out of scope preserved

- No `StoryPlayerView`, navigation, repository, Noah content, mini-game, persistence, JSON, conditional progression, failure, or retry behavior changed.
- The engine does not advance beyond the first configured step; progression is deferred to FND-BASE-T05.

## Acceptance status

- [x] Engine loads, starts, exposes, completes, and restarts generic configured stories.
- [x] Engine is independent of Noah-specific loading/repository code.
- [x] A generic fixture and Noah-compatible content load through the same injected loader contract.
- [x] Core behavior has focused unit-test coverage.
- [ ] Unit tests have a recorded passing simulator run.

## Verification

See `Documentation/Acceptance/FND-BASE-T04-VERIFICATION.md`. This task remains `IMPLEMENTED` until focused unit tests execute successfully in a working iOS Simulator environment.
