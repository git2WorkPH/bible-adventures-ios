# Mini-game lifecycle

Task: FND-BASE-T08. Requirements: FND-009–014. Finding: PA-002-001.

`MiniGameAdapter` is a Foundation-only presentation boundary. Configuration supplies an activity identifier and whether retry is allowed; it contains no Noah-specific rules. The caller selects the view and associates its configuration with the current story step. Game-specific mechanics and configuration payloads remain outside this shared lifecycle.

The adapter owns a value copy of `StoryEngine`. A coordinator must use `adapter.engine` as the authoritative updated engine while the adapter owns the activity, then transfer that value to the next activity; it must not independently advance an older engine copy.

- `start()` requires a nonempty identifier and active story step, and returns a unique attempt token.
- `receive(.completed, attempt:)` maps to engine `.success`; `.failed` maps to `.failure`. Only the engine chooses the next step.
- Results terminate the attempt even when progression rejects an unconfigured outcome. A rejected failure leaves the story unchanged and the activity failed.
- Retry is allowed only after failure, when configured, and while the engine remains on the original step. It sends `.retry` and issues a fresh token. A failure branch to another step or story completion cannot retry the original activity.
- Pre-start, duplicate and stale callbacks are rejected without advancing the story. Completed activities cannot retry.

## Existing Noah presentation adapter path

The existing `MiniGameView` selects Noah-specific views using `MiniGameType`; those views expose `onComplete: () -> Void`. A future presentation coordinator can start this adapter, capture the attempt token, and translate each existing `onComplete` into `receive(.completed, attempt: token)`. Any future failure callback maps to `.failed`; retry must recreate/reset the view with the newly issued token. The coordinator handles the returned progression result and reads the adapter's updated engine.

T08 does not wire this into the prototype, change its views, or introduce failure UI. This implements the common boundary, not all game-specific capabilities described by FND-010–014.
