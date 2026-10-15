# PA-004 — Approved next phase

Date: 2026-10-04. All tasks approved by the owner; current execution status is recorded below. Assessment: ../../Assessment/PA-004-NEXT-PHASE-ASSESSMENT.md. Approval evidence: “i have approved the proposed next phase.” Authorization covers the four task scopes and acceptance criteria below. Noah closure is complete. Pending story/mechanic choices remain explicit dependencies; approval does not select them.

## PA-004-T01 — Design reusable story composition and content contracts

Finding: PA-004-001/002. Requirements: PRD-004; FND-001/018/019/024/026.
Scope: define story catalogue/selection, injected player metadata, reading/restart labels, repository boundaries and a versioned external-content schema. Decide which content belongs in JSON and which mechanics stay typed in Swift. Explicitly decide whether multiple saved stories or a single active save is supported; do not silently change current replacement/resume behavior.
Deliverables: architecture decision, schema/examples, migration/recovery rules and revised T02 acceptance scope.
Acceptance: two synthetic test fixtures can be represented without Biblical content claims; unknown activity IDs, invalid references and incompatible content versions have defined recovery; existing noah-2 progress behavior is accounted for. No user-facing second story is shipped by this design task.

## PA-004-T02 — Implement and verify configured player/content boundaries

Dependencies: T01 approved decision; T08 closure before final regression acceptance.
Scope: implement the agreed catalogue/composition and content loader; remove Noah-specific defaults/copy from shared player presentation using injected configuration. Preserve Noah's reviewed quotation, sequence, reflection and save behavior. Synthetic alternate story belongs in tests only.
Acceptance: fixture stories share the same player/runtime without Noah copy; schema errors recover; content loads deterministically; old saves follow T01's explicit migration policy. Appropriate domain/repository tests and full Noah regression pass with recorded counts. iPhone/iPad presentation changes receive targeted layout/accessibility checks. Handover records all changed interfaces and data versions.

## PA-004-T03 — Prove one independently reusable game mechanic

Finding: PA-004-003. Requirements: FND-009–014/026; PRD-004.
Dependencies: approved choice of mechanic and its contract. Suggested candidate: matching/selection; final choice remains explicit after evaluating future-story needs.
Scope: extract one mechanic into story-neutral state/rules with injected cards/items, prompts, feedback and activity result. Preserve Noah rules; do not replace all games or invent a new ruler interaction.
Acceptance: two distinct non-Biblical configurations pass independent tests for selection, mismatch/retry, completion and stale/duplicate outcomes. Noah integration passes affected game/full-flow checks. Accessible controls, reduced motion and non-color state work on recorded phone/tablet configurations.

## PA-004-T04 — Select and define the next Bible story

Requirements: PRD-001–006, Scripture Integrity Policy. Depends on an explicit owner story choice; no Moses/David selection is inferred from StoryID cases.
Scope: assess candidate story/source, audience needs and foundation reuse; define component requirements, exact quotation/interpretation/game distinctions, questions/reflection, content review and acceptance plan. Identify any required foundation tasks and propose them separately.
Acceptance: owner-selected story, reviewed requirements/content decisions, traceable implementation proposal with tests and device acceptance. Story implementation requires its own approved tasks. No audio, account/cloud, telemetry or public release is included.

## Approval and execution

Recommended order: T01 -> T02, then T03 when a mechanic is selected; T04 requirements may proceed alongside design after a story choice. Owner may instead prioritize audio/assets or release preparation through a separately scoped proposal. Each approved task must update session checkpoints and TECHNICAL-HANDOVER.md throughout work under HANDOVER-PROCESS.md.


## Execution checkpoint

T01–T04: APPROVED; implementation not started. T01 is the first executable task. T02 depends on T01's recorded design decision. T03 depends on an explicitly selected mechanic/contract. T04 depends on the owner's story choice and authorizes definition/proposal, not shipment of a new story. Required task handover: ../../SessionMemory/PA-004-TECHNICAL-HANDOVER.md.


## Execution checkpoint — 2026-10-04

Owner authorized PA-004 and all necessary approvals within its task scopes; selected David and Goliath. T01 design recorded in Architecture/Decisions/PA-004-STORY-COMPOSITION.md. T02 IN_PROGRESS: version-1 JSON definition/validation, injected presentation metadata and unchanged noah-2 export implemented; first unit run RUNNING (exec session 49088), log /private/tmp/BibleAdventure-PA004-units-v1.log, result /private/tmp/BibleAdventure-PA004-units-v1.xcresult, derived /private/tmp/BibleAdventure-PA004-derived. Inspect result before rerun. Source/document changes local; no push. T03 mechanic selected: pair matching. T04 definition: David and Goliath/1 Samuel 17; story shipment remains a future implementation proposal. Next: inspect unit output, fix genuine failures, extract matching state and complete T04 reviewed requirements. Preserve personal Xcode edits.

## Current status — 2026-10-04

T01 VERIFIED (design/contract); T02 IMPLEMENTED (regression in progress); T03 IMPLEMENTED (regression in progress); T04 VERIFIED (David/Goliath requirements/proposal). See individual Acceptance/PA-004-T0x-VERIFICATION.md and Completed records for exact scope. T02/T03 cannot become VERIFIED until actual passing phone/tablet evidence and final units are recorded. This supersedes historical checkpoints above.

## Final execution status — 2026-10-04

T01 VERIFIED (composition design/contract), T02 VERIFIED (configured player/content with recorded regression), T03 VERIFIED (one reusable pair-matching mechanic with recorded regression), T04 VERIFIED (David/Goliath requirements/proposal). Completed and Acceptance records trace each result and limitations. Owner chose David/Goliath; pair matching was selected under authorized necessary in-scope decisions. No PA-004 work remains. PA-005 is the next story implementation proposal, outside this phase's shipment scope.
