# PA-003 — Approved implementation tasks

Date: 2026-10-03
Revision: Expanded at the owner's request to cover Noah implementation and final verification.
All tasks: APPROVED by the project owner on 2026-10-03. Implementation and necessary follow-up tasks within these scopes are authorized.

## Coverage and execution order

| Requested outcome | Tasks |
|---|---|
| Connect Noah to the reusable engine and activity lifecycle | T03 design/decisions, T05 implementation |
| Correct and review Scripture quotations, questions and labels | T04 audit/remediation, T08 final content acceptance |
| Present Scripture-connected reflection after completion | T04 reviewed copy, T06 runtime presentation |
| Save and restore gameplay progress | T03 storage/resume decisions, T07 implementation |
| Verify the complete story on iPhone/iPad, including accessibility | T08 end-to-end/device acceptance and bounded fixes |

Start with T01 to establish executable tests. T02 and T03 establish scope and integration decisions. T04 may proceed alongside design after approval. T05 follows T01/T03; T06 follows T04/T05; T07 follows T03/T05 and coordinates with T06. T08 follows T04–T07. Approval is recorded in `Approved/PA-003-APPROVED-TASKS.md`. New product/content/architecture choices remain explicit decisions within the approved work.

## PA-003-T01 — Repair existing unit-test compilation and establish current evidence

Finding: PA-003-001. Requirements: FND-026 and pending T03–T06 acceptance.
Scope: Repair test-only mutating macro calls and Story assertions; run existing iOS unit suite; review T03–T06 criteria and update evidence/status only where justified. Production changes require a separately documented finding/approval if tests expose defects.
Acceptance: Test target compiles; existing tests execute with recorded counts/results; failures remain visible; no weakened assertions or unsupported verification claims. Preserve unrelated Xcode changes.

## PA-003-T02 — Confirm project profile, scope and current coverage

Finding: PA-003-005.
Scope: Obtain owner decisions for missing profile/scope information; populate authoritative project documents and reconcile historical assessment/planning/status language.
Acceptance: Explicit scope and platform/stage decisions; current requirement coverage map; historical evidence retained; no inferred approvals.

## PA-003-T03 — Design staged player integration

Finding: PA-003-002.
Requirements: PRD-004, PRD-006; FND-001–003, FND-006–009, FND-015–017, FND-024–025.
Scope: Define runtime composition of engine, objective/question sessions, mini-game outcomes, reflection, persistence and recoverable errors for T05–T07. Record decisions for local durable storage, save points, resume/restart behavior, navigation, activity configuration and progress restoration. Resolve the existing snapshot's handling of partial activities and post-story reflection; define content-version/step validation and recovery without claiming unsupported mid-game restoration.
Acceptance: Owner-approved decisions and traceable contracts are recorded in `Architecture/Decisions/`; T05–T07 are reconciled with those decisions before approval; generic foundation is preserved and Noah details remain in content/configuration. Design must support the complete Noah path and deterministic automated verification.

## PA-003-T04 — Audit and remediate Noah Scripture-policy content

Finding: PA-003-003. Requirements: FND-027, PRD-001, Noah requirements.
Scope: Review all Noah quotations/questions/feedback/game descriptions against exact approved ESV source and policy; review ark wood/door claims and other uncertain details; approve replacement content, implement labels/artifact cleanup, verify attribution/permissions and Scripture-connected reflection copy within the approved scope.
Acceptance: Every displayed quotation has exact reviewed source/reference/translation; interpretation and gameplay are distinctly labelled; questions do not assert unsupported Biblical facts; permission/attribution evidence and owner content review recorded.

Additional scope: Define each NOAH-001–012 component's Biblical source, purpose, learning objective, mechanic, dialogue, success/failure behavior, acceptance criteria and reflection opportunity. Review the existing sequence for missing requirements, including ark blueprint/construction, and record omissions before expanding gameplay. Produce approved Noah reflection content for T06. T04 may remediate content and presentation labels; lifecycle, storage and new gameplay mechanics belong to their approved tasks.

## PA-003-T05 — Integrate Noah with the reusable story and activity lifecycle

Status: APPROVED.
Finding: PA-003-002. Requirements: PRD-003–004; FND-001–003, FND-005–014, FND-018–019, FND-024–025; NOAH-001–011.
Dependencies: T01 passing unit suite; T03 approved composition decisions. Policy-reviewed content from T04 is required for final acceptance.

Scope: Replace player-local progression with a coordinator using StoryEngine and repository/configuration boundaries. Wire dialogue, objectives/questions and every existing Noah mini-game to typed outcomes through reusable sessions/adapters. Preserve existing visuals where compatible with approved behavior. Present recoverable load/activity errors through the error contract and appropriate logging. Provide start/restart and completion handoff to T06. Implement configured failure/retry behavior, rather than inventing game rules; unresolved or missing game mechanics become separately scoped proposals.

Acceptance:

- The player runs the entire configured Noah sequence under one authoritative engine; views do not independently increment steps.
- Objective/question completion uses stable answer identity, randomized order, feedback, hints/references and once-only outcomes.
- Mini-game success/failure/retry follows approved configuration; stale and duplicate callbacks cannot advance the story.
- Generic integration tests exercise engine/coordinator/activity boundaries; Noah configuration tests cover every step and completion.
- Missing/invalid content and failed activities have usable recovery; new reusable code contains no Noah-specific gameplay rules.
- Changes and criteria are reviewed and recorded in `Acceptance/PA-003-T05-VERIFICATION.md`.

## PA-003-T06 — Present Noah reflection after story completion

Status: APPROVED.
Finding: PA-003-002. Requirements: PRD-001–002, PRD-006; FND-015, FND-027; NOAH-012.
Dependencies: T04 approved reflection content and T05 completion handoff; T03 navigation/resume decisions.

Scope: Create the runtime reflection handoff through ReflectionSession, render reviewed Noah prompts and Scripture references, include the GOD-centered reflection question, and provide an accessible way to read the relevant source and finish reflection. Any displayed quotation comes from reviewed Scripture content with its required label. Coordinate reflection completion/resume state with T07 under the approved decision.

Acceptance:

- Reflection is offered after Noah completes, never before engine completion; repeated callbacks do not duplicate the handoff.
- Players encounter the reviewed prompts, the GOD-centered question and a clear invitation to read the cited Scripture.
- Scripture, interpretation and gameplay labels follow policy; no spiritual score or inferred understanding is recorded.
- Navigation, completion and restart/resume behavior match T03; integration tests cover the handoff and invalid/repeated actions.
- Evidence is recorded in `Acceptance/PA-003-T06-VERIFICATION.md`; device presentation is checked in T08.

## PA-003-T07 — Implement durable Noah progress saving and restoration

Status: APPROVED.
Finding: PA-003-002. Requirements: FND-002–003, FND-016–017, FND-024–026.
Dependencies: T03 approved storage/save/resume decisions; T05 coordinator; T06 reflection contract where persistence affects its state.

Scope: Implement the approved local ProgressDataStoring adapter, runtime snapshot mapping and engine/session restoration boundary. Wire New Adventure, Continue and restart to the approved semantics. Save at defined lifecycle points, validate restored story/content/step identities and reconcile objective/activity/reflection state at the agreed restoration granularity. Extend snapshots/contracts only as specified by approved T03 decisions, with version/recovery handling. Cloud sync, accounts and telemetry remain outside this task.

Acceptance:

- Progress survives termination/relaunch and Continue resumes the agreed point with consistent engine and activity state.
- Restart/new-game behavior follows the decision and does not accidentally resume stale progress.
- Missing, corrupt, unsupported, outdated-content or unwritable storage produces safe, understandable recovery; unreadable data is not silently overwritten during restore.
- Integration tests use the real adapter with isolated temporary storage and cover round trip, lifecycle save points, invalid progress and storage failures.
- No progress value represents faith or spiritual achievement; reflection persistence follows the explicit decision.
- Evidence is recorded in `Acceptance/PA-003-T07-VERIFICATION.md`, including relaunch observations later confirmed in T08.

## PA-003-T08 — Verify and complete Noah acceptance on iPhone and iPad

Status: APPROVED.
Findings: PA-003-001–004. Requirements: PRD-001–006; applicable FND requirements including FND-020, FND-023, FND-026–027; NOAH-001–012.
Dependencies: T01 and T04–T07 verified at their approved scopes; T02 confirmed scope and T04 per-component criteria.

Scope: Run complete Noah acceptance against the requirement/component matrix and existing accessibility device matrix. Select and record supported iPhone/iPad models and OS versions. Exercise start, every dialogue/objective/game, configured failure/retry, completion/reflection, restart and relaunch/resume. Run automated regression/integration/UI checks where appropriate and manual VoiceOver, Dynamic Type, touch-target, reduced-motion, rotation/layout and Scripture-label checks. Implement bounded navigation/layout/accessibility/animation defects exposed by these checks within existing approved behavior, then rerun affected checks. Missing gameplay or changed content/product/architecture decisions require separately approved proposals.

Acceptance:

- Complete story runs pass on at least one named iPhone and one named iPad, including supported orientations, largest supported accessibility text sizes, VoiceOver and reduced motion under the existing standards.
- All Noah component criteria and relevant product/foundation criteria map to direct passing evidence; generic launch tests alone do not count as story acceptance.
- Persistence/recovery and activity retry work on device; no inaccessible mandatory drag interaction or navigation dead end blocks completion.
- Final content review confirms reviewed quotations, labels, questions, attribution and reflection in the actual presentation.
- Record device/OS, commands, test counts, manual procedures, screenshots/results, defects and reruns in `Acceptance/PA-003-T08-VERIFICATION.md` and the validation matrix.
- Outstanding criteria remain explicit. Noah is marked verified only when all approved Noah acceptance criteria pass; unrelated foundation capabilities such as audio/assets are not certified by this task.

## Approval evidence

Owner instruction: “all proposed tasks are approved, kindly implement them and also, all future tasks that needs approval within this tasks are approved.” Current execution: T01–T03 and T05–T07 VERIFIED; T04 IMPLEMENTED pending final owner content review; T08 IMPLEMENTED pending full manual acceptance. Canonical results are in Completed/ and TASK-REGISTER.md.


Final status reconciliation — 2026-10-04: all PA-003-T01–T08 VERIFIED at their approved scopes. Owner manual device metadata completes T08; Noah IMPLEMENTED_VERIFIED. Earlier execution summaries are historical. PA-004 remains PROPOSED.
