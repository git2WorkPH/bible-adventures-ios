# AI Project Instructions

This repository uses a requirements-first, traceable AI-assisted development workflow.

## Before significant work
Read:
1. `Documentation/Project/PROJECT.md`
2. `Documentation/Project/VISION.md`
3. `Documentation/Project/SCOPE.md`
4. `Documentation/Project/GLOSSARY.md` when domain terminology matters
5. relevant requirements
6. relevant architecture decisions
7. relevant tasks and session memory

## Mandatory workflow
Requirements -> Assessment -> Finding -> Decision -> Proposed Task -> Approval -> Implementation -> Test -> Review -> Verified -> Session Memory.

## Rules
- `Documentation/` is authoritative.
- A finding is an observation, not permission to implement.
- A proposed task is not an approved task.
- Only an approved task authorizes implementation.
- Do not silently expand scope.
- Do not silently resolve product, security, compliance, content, or architecture decisions.
- Preserve useful existing work unless an approved task requires changing it.
- Record findings in `Documentation/Assessment/`.
- Record proposed tasks in `Documentation/Tasks/Proposed/`.
- Record approved tasks in `Documentation/Tasks/Approved/`.
- Record completed work in `Documentation/Tasks/Completed/`.
- Record decisions in `Documentation/Architecture/Decisions/`.
- Record verification evidence in `Documentation/Acceptance/`.
- Update `Documentation/SessionMemory/` after meaningful work.

## Status
Requirement: `NOT_STARTED`, `PARTIAL`, `IMPLEMENTED_UNVERIFIED`, `IMPLEMENTED_VERIFIED`, `OUT_OF_SCOPE`, `NEEDS_DECISION`.
Task: `PROPOSED`, `APPROVED`, `IN_PROGRESS`, `BLOCKED`, `IMPLEMENTED`, `VERIFIED`, `CANCELLED`.
Finding: `OPEN`, `DECISION_REQUIRED`, `TASK_PROPOSED`, `ACCEPTED`, `RESOLVED`, `WONT_FIX`.

Project-specific principles belong in `Documentation/Project/` and project requirements/architecture. Do not assume rules from another project.
