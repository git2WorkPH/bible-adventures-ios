# FND-002-T01 — Define Foundation Game State

## Requirement

- FND-002 — Story State
- Supporting architecture: `Documentation/Architecture/FOUNDATION-ARCHITECTURE.md`
- Assessment source: PA-001 from the read-only project assessment.

## Objective

Define the top-level, reusable game-state contract that will become the single source of truth for an active story session. It must establish the ownership boundary between presentation views and foundation state without adding story progression behavior.

## Scope

- Define the foundation `GameState` domain contract under `BibleAdventure/Core/Models/`.
- Represent whether a story session is inactive or active without embedding Noah-specific state or view behavior.
- Establish a clear extension point for the Story State, Objective State, and Mini-game State contracts defined by FND-002-T02 through FND-002-T04.
- Add focused unit tests that construct and inspect generic game-state values.

## Dependencies

- FND-001-T01 — Define Reusable Story Model is complete.
- The product owner must approve this task before implementation.
- FND-002-T02 through FND-002-T04 will define the detailed state held by an active session.
- FND-002-T05 will make the approved state observable and connect it to presentation.

## Expected Changes

- Add or update foundation state model types under `BibleAdventure/Core/Models/`.
- Add focused game-state unit tests in `BibleAdventureTests/`.
- Do not change `StoryPlayerView`, Noah content, mini-games, navigation, or persistence.

## Acceptance Criteria

- A reusable top-level game-state contract exists outside SwiftUI views.
- The contract contains no Noah-specific fields, content, or UI callbacks.
- It can represent the absence of an active story session and reserve a generic active-session extension point.
- It is independently constructible and testable.
- It does not implement step advancement, completion, failure, retry, or persistence behavior.

## Tests / Verification

- Unit test construction of each defined top-level game-state value.
- Unit test that the contract does not require Noah content to be created.
- Build and run the relevant unit-test target after implementation.
- Confirm `StoryPlayerView` retains its current behavior until a separately approved observable-state integration task.

## Out of Scope

- Defining the detailed Story State, Objective State, or Mini-game State contracts.
- Making state observable or migrating `StoryPlayerView` from local state.
- Implementing Story Engine loading, progression, completion, failure, or retry behavior.
- Saving/restoring state, tracking progress, or adding reflection.
- Changing Noah story content, mini-game views, Scripture content, or navigation.

## Status

Proposed
