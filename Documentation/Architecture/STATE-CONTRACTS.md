# Foundation State Contracts

Status: IMPLEMENTED_UNVERIFIED
Task: FND-BASE-T03

## Ownership hierarchy

```text
GameState
└── ActiveGameState (only when the game is active)
    ├── StoryState (required)
    ├── ObjectiveState (optional)
    └── MiniGameState (optional)
```

`GameState.inactive` carries no active session. `GameState.active` carries one `ActiveGameState`, which requires one `StoryState`. Objective and mini-game state are absent until an active story enters the relevant phase.

## Lifecycle rules

| Contract | Legal transitions | Terminal states |
|---|---|---|
| GameState | `inactive → active`, `active → inactive` | None |
| StoryState | `active → completed` | `completed` |
| ObjectiveState | `inactive → active`, `active → completed`, `active → failed` | `completed`, `failed` |
| MiniGameState | `inactive → active`, `active → completed`, `active → failed` | `completed`, `failed` |

The state contracts return `nil` for an illegal transition. Reset and retry are intentionally absent until a separately approved requirement defines them.

## Boundaries

The contracts are pure Foundation domain values. They contain no SwiftUI types, views, bindings, callbacks, persistence, progression behavior, or story-content fields. `StoryPlayerView` continues to own its existing prototype state until a separately approved observable-state integration task.

## Verification status

The model source type-checks directly with `swiftc`. Unit-test execution remains unverified because the available environment cannot start an iOS Simulator; see the FND-BASE-T03 acceptance evidence.
