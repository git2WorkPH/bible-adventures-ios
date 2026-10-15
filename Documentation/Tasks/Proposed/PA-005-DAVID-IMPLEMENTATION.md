# PA-005 — David and Goliath implementation proposal

Date: 2026-10-04. Status: PROPOSED. Created as PA-004-T04 deliverable. The current approval authorizes PA-004 definition and necessary follow-ups; this new story implementation is a separate phase. Requirements: ../../Requirements/Stories/David/DAVID-REQUIREMENTS.md. Decisions: ../../Architecture/Decisions/DAVID-CONTENT-DESIGN.md and PA-004-STORY-COMPOSITION.md. No renewed approval is required for unfinished PA-004 work.

## PA-005-T01 — Extend configured story and activity support

Dependencies: PA-004 T01–T03 verification. Covers DAV-001/003/009/010/012.

Work: support First Samuel in typed book/reference validation; allow typed pair-matching activity to receive per-story items/copy; expose reviewed catalogue selection with one selected runtime and retained per-story saves. Preserve Noah source, sequence, noah-2 save boundaries and existing activity IDs. Keep dynamic execution out of content JSON.

Acceptance: two configured matching activities use one rule implementation; unknown configuration/IDs fail safely; switching/resuming/restarting one story retains the other's progress; missing content does not overwrite saves; old Noah saves restore. Domain/loader/persistence tests pass, plus complete Noah regression on phone/tablet. Record interface/schema/version decisions and handover.

## PA-005-T02 — Review and author David content

Dependencies: selected story requirements/content decision; T01 contract before final JSON. Covers DAV-002–008.

Work: finalize ordered interpretation/dialogue, four source-connected questions and feedback, three-category provisions matching, reading labels and reflection. Use narrator-only copy and references without new direct quotations unless separately audited under the approved policy. Create a component/source/label audit of every displayed text, including success messages and symbols.

Acceptance: all components trace to 1 Samuel 17 or are explicitly Game activity; interpretation uses supporting references; no invented age/height, oversized-armor claim or guaranteed personal victory. Non-graphic outcome remains truthful. Reflection points to GOD/source reading. Questions have one supported answer and readable retry feedback. Review exact quotations and permissions if any are introduced. Final content audit must pass before verification.

## PA-005-T03 — Integrate David lifecycle and durable progress

Dependencies: T01 contract, T02 reviewed content. Covers DAV-001/003/007/009/010/012.

Work: bundle david-1 definition, expose reviewed catalogue entry, wire activity results/quiz/reflection to existing engine and atomic progress. No parallel story engine. Restore/restart/error paths follow composition decision. Preserve Noah independently.

Acceptance: complete configured flow and reflection, wrong-answer retry, activity duplicate/stale rejection, interruption/relaunch at each boundary, completed reflection restore, story switching and incompatible/corrupt-save recovery tested. Production catalogue exposes only reviewed delivered entries. Domain/integration tests pass with actual counts and source fingerprints.

## PA-005-T04 — Device acceptance and handover

Dependencies: T01–T03 implementation/tests/content review. Covers DAV-008/011 and PRD-001–006.

Work: full David flow and Noah regression on named iPhone/iPad configurations; portrait/landscape, largest text, narrow iPad window, VoiceOver and OS Reduce Motion. Record actual OS/device, screenshots/results, assistive-technology limits and owner review. Fix bounded failures and retest affected behavior.

Acceptance: reachable readable controls, selection state communicated beyond color, no clipped required text, no duplicate progression, persistence/reflection correct. Tests and manual checks pass at stated scopes; failures remain visible until resolved. Update requirement statuses, Completed records, acceptance evidence and a fresh technical handover. No release/publication, cloud/accounts, telemetry or audio framework.

## Implementation handover

On approval, copy these tasks to Approved with owner evidence and create PA-005-TECHNICAL-HANDOVER.md using HANDOVER-TEMPLATE.md. Resume order: T01 contract, T02 content in parallel once contract stable, T03 integration, T04 acceptance. Current executable app remains Noah. Do not label David IMPLEMENTED until it is actually bundled/wired; do not label it VERIFIED until content, tests and device criteria pass.

Detailed task-by-task resume instructions and acceptance: ../../SessionMemory/PA-005-TECHNICAL-HANDOVER.md.
