# Project Requirements

## Purpose
Turn an approved requirement into implementation-ready, traceable tasks without implementing code.

## Workflow
1. Read the requirement.
2. Identify purpose, scope, non-goals, dependencies, constraints, and acceptance criteria.
3. Inspect existing architecture and reusable capabilities.
4. Identify missing foundation capabilities before proposing story-specific duplication.
5. Derive small, independently verifiable tasks.
6. Define verification/testing for each task.

## Rules
- Do not implement code.
- Do not invent product behavior without clearly marking it as a proposal.
- Do not create approved work from an unapproved recommendation.
- Prefer reuse over duplication.
- Preserve traceability: Requirement → Task → Acceptance Criteria → Verification.

## Task format
Each task should include:
- ID
- requirement ID
- objective
- scope
- dependencies
- expected changes
- acceptance criteria
- tests/verification
- out of scope

## Example
```text
Use the project-requirements skill. Analyze FND-006, identify dependencies and derive implementation tasks. Do not implement anything.
```
