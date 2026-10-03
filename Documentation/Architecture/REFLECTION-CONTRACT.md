# Reflection contract

Status: VERIFIED
Task: FND-BASE-T09
Requirements/findings: PRD-002, PRD-006, FND-015, NOAH-012; PA-002-003.

## Completion handoff

`ReflectionSession.afterStoryCompletion(engine:content:)` is the reusable boundary between Story Engine completion and reflection. It returns a session only when the engine reports its story completed and the reflection content has a nonempty identifier and prompt. An active or inactive story cannot begin reflection.

The lifecycle is `ready → active → completed`. Invalid, early, or repeated actions are rejected without changing state. Completion records only that the reflection opportunity was completed; it does not measure understanding, faith, spiritual growth, or achievement.

## Content and presentation

`ReflectionContent` contains a story-neutral identifier, reflection prompt, and `BibleReference`. It deliberately does not embed a quotation, translation choice, story-specific behavior, or presentation framework.

`ReflectionPresentation` supplies the shared view-facing values:

- reflection copy labeled `Interpretation`;
- the question `What does this story teach you about GOD?`;
- the source label `Scripture — [reference] (ESV)`; and
- the structured Scripture reference.

This separation follows the approved Scripture Integrity Policy: reflection wording is not presented as direct Bible text, and a Scripture source is identified by book, chapter, verse or range, and ESV. If a future view displays the verse text, it must load exact approved ESV text through `ScriptureContentLoading` and place only that quotation beneath the Scripture label. T09 does not add or approve Scripture quotations.

## Deferred integration

The existing Noah completion screen remains prototype presentation. A later approved integration can create a Noah reflection content record after content review, hand the completed Story Engine and content into `ReflectionSession`, and render the resulting presentation. New Noah copy, SwiftUI wiring, persistence, and claims that all of NOAH-012 is verified are outside T09.
