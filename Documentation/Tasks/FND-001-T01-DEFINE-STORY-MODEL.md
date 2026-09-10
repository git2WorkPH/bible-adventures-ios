# FND-001-T01 — Define Reusable Story Model

> Legacy implementation record. Current task disposition is `IMPLEMENTED`, as recorded in `Documentation/Tasks/TASK-REGISTER.md`. This record does not establish retrospective approval or verification under the current task-location policy.

## Requirement

- FND-001 — Story Engine
- Supporting architecture: `Documentation/Architecture/FOUNDATION-ARCHITECTURE.md`
- Assessment source: PA-001 and PA-003 from the read-only project assessment.

## Objective

Define the reusable `Story` content contract that the future Story Engine will load and progress. The contract must describe a story without embedding Noah-specific gameplay rules.

## Scope

- Review the existing `Story`, `StoryID`, and `StoryStep` models.
- Define the minimum reusable story-model contract needed by the Story Engine: stable story identity, title, description, and ordered steps.
- Ensure the contract can represent the current Noah story without adding Noah-specific fields or rules.
- Preserve `NoahStory` as prototype content; make only compatibility changes required by the approved story-model contract.
- Add focused unit tests for the model contract and an in-memory generic fixture story.

## Dependencies

- The product owner must approve this task before implementation.
- FND-001 is currently in Requirements Definition status.
- This task precedes centralized state work in FND-002 and progression behavior in FND-003.

## Expected Changes

- Update or confirm reusable story-domain model types under `BibleAdventure/Core/Models/`.
- Add a generic story fixture within the unit-test target.
- Add model-contract unit tests in `BibleAdventureTests/`.
- Do not add new story content, mini-games, navigation, persistence, or reflection.

## Acceptance Criteria

- A `Story` has a stable identity, player-facing title, description, and ordered steps.
- The model contains no Noah-specific fields, branching rules, or mini-game implementation details.
- The existing Noah story can be represented by the contract without changing its Biblical content or player-visible flow.
- A generic, non-Noah fixture story can be constructed using the same contract.
- The model contract is independently testable.

## Tests / Verification

- Unit test that a generic story preserves its identity, metadata, and ordered steps.
- Unit test that the Noah configuration remains representable by the reusable contract.
- Build and run the relevant unit-test target after implementation.
- Confirm no new Noah-specific branching or mini-game behavior was added to foundation model types.

## Out of Scope

- Implementing Story Engine loading, starting, progression, completion, or restart behavior.
- Creating `StoryState`, observable state, persistence, or progress tracking.
- Conditional, failed, or retryable progression.
- Refactoring Noah mini-game views into a framework.
- Adding reflection, Scripture repository, or JSON story decoding.
- Resolving Scripture wording/translation decisions.

## Status

IMPLEMENTED
