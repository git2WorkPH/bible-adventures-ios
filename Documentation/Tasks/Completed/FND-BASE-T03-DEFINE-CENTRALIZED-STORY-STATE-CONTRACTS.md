# FND-BASE-T03 — Define Centralized Story-State Contracts

Status: IMPLEMENTED
Approved by: Project owner, 2026-09-04
Implemented: 2026-09-04

## Requirements and findings

- FND-002 — Story State
- PA-002-001 — Prototype progression bypasses the planned foundation boundary

## Implemented scope

- Added pure Foundation `GameState`, `ActiveGameState`, `StoryState`, `ObjectiveState`, and `MiniGameState` contracts.
- Implemented the approved legal lifecycle transitions and rejection of invalid/terminal-state transitions.
- Added direct unit tests for construction, hierarchy, valid transitions, and invalid transitions.
- Documented the ownership hierarchy, lifecycle rules, and state boundary in `Documentation/Architecture/STATE-CONTRACTS.md`.

## Out of scope preserved

- `StoryPlayerView`, all SwiftUI runtime state, and Noah gameplay are unchanged.
- No Story Engine, step progression, retry/reset, persistence, repository, navigation, or content work was added.

## Acceptance status

- [x] Generic game, story, objective, and mini-game state contracts exist.
- [x] Active sessions contain a required story and optional child phase state.
- [x] Ownership and legal lifecycle transitions are documented.
- [x] Illegal transitions are rejected by the contracts.
- [x] Contracts have no SwiftUI dependency, UI callbacks, or story-content fields.
- [x] Focused unit tests were added.
- [x] Existing `StoryPlayerView` and Noah gameplay remain unchanged.
- [ ] Unit tests have a recorded passing simulator run.

## Verification

See `Documentation/Acceptance/FND-BASE-T03-VERIFICATION.md`. The task remains `IMPLEMENTED` rather than `VERIFIED` until the unit tests run successfully in an available iOS Simulator environment.
