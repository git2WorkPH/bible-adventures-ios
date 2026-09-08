# FND-BASE-T07 verification

Date: 2026-09-08
Result: Focused domain verification passed; full iOS target not executed.

The unchanged source files and `ObjectiveQuestionSessionTests.swift` were copied into a temporary Swift package (Swift language mode 5, macOS 15 minimum), with the domain module named `BibleAdventure`. No production source was rewritten for the harness.

Command: `swift test --package-path /private/tmp/bible-t07.9kBqf8 --scratch-path /private/tmp/bible-t07.9kBqf8/build --disable-sandbox`

Result: exit 0; Swift Testing reported **4 tests in 1 suite passed**. The preceding XCTest wrapper reported zero tests; the four executed tests belong to Swift Testing.

| Acceptance | Evidence |
|---|---|
| Stable randomized correctness | 32 seeded shuffles preserve all answer IDs/text and select the correct original index, including duplicate labels; more than one order observed. |
| Feedback and hints | Wrong/correct explanations and feedback kinds are asserted; hint persists across retry. |
| Retry behavior | Incorrect attempt keeps objective active; retry clears attempt state and preserves order/reference. |
| Reference propagation | Session, feedback, and completion report retain the supplied reference. |
| Central completion contract | Completed objective yields one identity-bearing report with `.success`; repeated consumption returns nil. |
| Invalid transitions/content | Pre-start answers, repeated starts, unknown IDs, post-completion actions, and out-of-range correct index are rejected. |

Review: Foundation values only, no repository or UI coupling; existing content and runtime code unchanged. Initial test compilation exposed Swift Testing's handling of mutating calls; evaluating actions before assertions fixed it and the rerun passed.

This verifies the scoped lifecycle behavior, not the complete FND-006–010 requirements or existing app test suite. Prior test-target issues and unrelated repository defects are outside this task.
