# PA-004 — Next phase assessment

Date: 2026-10-04, Australia/Sydney. Scope: read-only source/requirement assessment and proposal preparation, requested by the owner's “please continue.” No new implementation approval inferred. Baseline: develop ef6ad72; master 2d6e237. Existing personal Xcode edits preserved. No tests rerun for this documentation assessment.

Noah implementation and automated results are retained in PA-003. T01–T07 are VERIFIED at their bounded scopes. T08 remains IMPLEMENTED pending manual iPad model/OS metadata. Owner reported all checks working, confirmed VoiceOver/window resizing/Reduce Motion, and supplied iPhone 14 Pro Max with iOS 26. Do not infer a point release or an iPad configuration.

## Findings

| ID | Status | Observation and evidence | Requirements / implication |
|---|---|---|---|
| PA-004-001 | TASK_PROPOSED | Features/Home/ContentView.swift constructs NoahStory.makeRuntime and displays Noah-only copy. Features/StoryPlayer/StoryPlayerView.swift defaults to Noah and hardcodes restart and Genesis reading links. Core runtime uses injected loaders. | PRD-004, FND-001/018: presentation/composition requires further configuration before another story can share the player safely. |
| PA-004-002 | TASK_PROPOSED | Stories/Noah/NoahStory.swift defines sequencing/dialogue/objectives in Swift; QuestionRepository decodes external JSON. Story is not Codable and StoryRepository is an injected in-memory dictionary. | FND-018/019: externalized story content is partial. Define validated schema and content version/migration rules before choosing a wider JSON implementation. |
| PA-004-003 | TASK_PROPOSED | Core/Models/MiniGameType.swift names Noah-specific activities (measureArk, buildArk, gatherAnimals, etc.). Current lifecycle is reusable; existing mechanics are not established as independently configurable frameworks for every FND-010–014 category. | PRD-004, FND-010–014/026: prove reuse with one bounded mechanic and test fixtures before extracting every game. |
| PA-004-004 | OPEN | FND-021/022 remain explicitly excluded from PA-003. Existing visuals do not establish reusable music/effects and asset loading requirements. | Future work needs separate prioritization; no immediate audio implementation or release decision follows from Noah acceptance. |

## Recommended sequence

Close T08 from owner-reported metadata, then design and prove a story-neutral player/content boundary using test fixtures. Follow with one configurable game mechanic selected after evaluating an actual future-story need. Select and define a second story only through an explicit content/product decision. Audio/assets and release preparation remain later candidates unless the owner chooses them as priority.

This recommendation is not an architecture decision or authorization. Reviewable tasks: ../Tasks/Proposed/PA-004-NEXT-PHASE-TASKS.md. Preserve passing Noah behavior and Scripture policy throughout future changes.


Closure update — 2026-10-04: owner supplied iPad mini/iPadOS 26, completing manual metadata alongside iPhone 14 Pro Max/iOS 26. PA-003-T08 now VERIFIED and Noah IMPLEMENTED_VERIFIED. PA-004 findings/tasks remain proposals; no new implementation approval inferred.
