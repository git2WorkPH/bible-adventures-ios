# FND-BASE-T02 — Approve Scripture Integrity Policy

Status: VERIFIED
Approved by: Project owner, 2026-09-04
Completed: 2026-09-04

## Requirements and findings

- PRD-001 — Scripture-Centered Experience
- FND-004 — Scripture System
- FND-027 — Scripture Integrity Requirement
- NOAH-002 — Wood Selection
- NOAH-009 — Flood
- PA-002-002 — Scripture integrity decision gate remains unresolved

## Implemented scope

- Recorded the project owner's ESV, citation, labelling, gameplay, and Noah wood decisions in `Documentation/Architecture/Decisions/SCRIPTURE-INTEGRITY-POLICY.md`.
- Recorded ESV permissions/attribution as a mandatory implementation and release-compliance gate.
- Linked FND-027 and the related assessment finding to the approved policy without changing Noah content or application code.

## Out of scope

- Changing Noah wording or displayed Scripture.
- Adding passages or a Scripture repository.
- Verifying ESV permission compliance for a released app.
- Claiming existing prototype content meets the new policy.

## Acceptance criteria

- [x] Scripture source/translation policy is approved: ESV.
- [x] Scripture, interpretation, and gameplay representation have distinct required labels.
- [x] Noah wood terminology is decided: `gopher wood`; `cypress` only as labelled interpretation.
- [x] Policy applies to future stories and records quotation/citation obligations.

## Verification

See `Documentation/Acceptance/FND-BASE-T02-VERIFICATION.md`.

## Follow-up

FND-BASE-T06 must implement compliant repository/content handling before existing or future Scripture content can be verified. FND-002-T01 remains proposed and requires separate approval.
