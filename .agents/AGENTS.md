# AI Project Instructions

## Mandatory workflow
Requirements -> Assessment -> Decision -> Task -> Approval -> Implementation -> Test -> Review -> Verified -> Session Memory.

## Source of truth
- `Documentation/Requirements/` defines product requirements.
- `Documentation/Tasks/` defines implementation tasks.
- `Documentation/Architecture/` defines structural decisions.
- `Documentation/Acceptance/` defines verification criteria.
- `Documentation/SessionMemory/` records current project context.
- Legacy root documents do not override these sources.

## Status rules
Use: `NOT_STARTED`, `PARTIAL`, `IMPLEMENTED_UNVERIFIED`, `IMPLEMENTED_VERIFIED`, `OUT_OF_SCOPE`, `NEEDS_DECISION`.
A requirement is `IMPLEMENTED_VERIFIED` only when acceptance criteria are satisfied and verification evidence exists.

## AI behavior
1. Read relevant requirements before implementation.
2. Read the approved task and acceptance criteria before coding.
3. Implement only approved scope.
4. Do not perform unrelated refactoring.
5. Report newly discovered requirements or decisions instead of silently expanding scope.
6. Preserve prototype code unless an approved task requires change.
7. Prefer reusable foundation capabilities before story-specific duplication.
8. Do not treat assumptions as project decisions.
9. Run appropriate verification before claiming completion.
10. Update session memory after meaningful work.

## Bible Adventure principles
- Scripture is the source of truth for Biblical claims.
- Distinguish Scripture, interpretation, and gameplay representation.
- The game should encourage players to read Scripture and seek GOD, not replace Scripture.
- Every story should provide an opportunity to reflect on what it teaches about GOD.
