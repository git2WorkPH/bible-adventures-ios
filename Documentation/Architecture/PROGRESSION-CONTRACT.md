# Story Progression Contract

Status: IMPLEMENTED_UNVERIFIED
Task: FND-BASE-T05

## Ownership

`StoryEngine` is the sole owner of `currentStepIndex`. Activities submit a typed `StoryActivityOutcome`; they do not mutate story state or choose a step directly.

## Outcomes and results

| Input outcome | Engine result | State effect |
|---|---|---|
| `success`, `failure`, or `condition(String)` with a configured transition | `advanced` or `completed` | Moves only to the configured destination. |
| `retry` | `retrying` | Leaves the current step unchanged. |
| Any unconfigured outcome, inactive session, or invalid state | `rejected` | Leaves state unchanged. |

## Configuration

`StoryProgression` is a data-defined list of source-index/outcome/destination transitions. Destinations are either another configured step index or completion. A `StoryProgressionLoading` dependency supplies configuration for each story.

The default loader creates a sequential success-only map. A custom loader may configure failure and named conditional paths without introducing story-specific logic into `StoryEngine`.

## Safety rules

- Source and destination indices must be within the story's configured steps.
- Duplicate source/outcome pairs invalidate a configuration and prevent the story from starting.
- No transition is inferred for an unconfigured failure or condition.
- Reset/retry behavior beyond reporting `retrying` is deferred until a separately approved requirement.

## Deferred behavior

Activity execution, UI adapters, mini-game results, persistence, and story-specific branching/content remain out of scope.
