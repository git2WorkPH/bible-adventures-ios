# Story Engine Contract

Status: IMPLEMENTED_UNVERIFIED
Task: FND-BASE-T04

## Boundary

`StoryEngine` is a pure Foundation value that owns one configured story session. It accepts a `StoryLoading` dependency, so it does not reference a repository implementation or story-specific content.

## Supported behavior

| Operation | Result |
|---|---|
| `start(storyID:)` | Loads a story from an inactive session and creates active `GameState`. |
| `currentStory` | Exposes the loaded story configuration for the active session. |
| `currentStep` | Exposes the current configured story step while the story is active. |
| `apply(outcome:)` | Applies an injected, data-defined progression transition for a typed activity outcome. |
| `complete()` | Marks the active story complete through `StoryState`. |
| `restart()` | Reloads the active story as a fresh active session. |

`start` rejects missing content and concurrent starts. `complete` rejects inactive or already-completed sessions. `restart` does not introduce retry or progression behavior; it only establishes a new session using the active story identity.

## Deferred behavior

Activity execution, persistence, repository implementations, and SwiftUI integration are deliberately deferred to separately approved tasks. Progression configuration and typed outcomes are defined by FND-BASE-T05.

## Verification status

The engine source type-checks as a Foundation contract. Focused unit tests are present, but test-target execution requires a working iOS Simulator and remains unverified in the current environment.
