# Project Session Context

## Date
2026-08-29

## Current phase
Foundation baseline and decision stage.

## Project direction
Bible Adventure is a Scripture-first interactive Bible game intended to encourage children or other players to truly read the Bible with the intention of seeking GOD. Gameplay supports Scripture engagement rather than replacing Scripture.

## Current state
Codex completed a read-only baseline assessment. No code, requirements, tasks, or documentation were changed by the assessment. The repository contains a working Noah prototype, but the reusable foundation is not yet implemented.

## Key findings
- Story progression is owned by `StoryPlayerView`.
- No centralized story state model exists.
- Mini-games lack a common lifecycle/result contract.
- Scripture, objectives, and questions are tightly coupled.
- Reflection, progress, and persistence are absent.
- Foundation tests are insufficient.
- Repository error handling uses crash-oriented behavior.
- Accessibility/reduced-motion behavior is not sufficiently defined or verified.
- Documentation/task/session status has conflicts.
- Scripture source/translation policy is not documented.

## Noah disposition
Preserve Noah as prototype/reference material. Adapt reusable models and boundaries into the foundation when approved. Keep Noah-specific content and visual details story-specific. Refactor or replace only through approved tasks.

## Decisions required
1. Establish `Documentation/` as authoritative.
2. Reconcile task/status inconsistencies, including FND-001-T01.
3. Approve Scripture source/translation policy.
4. Decide treatment of uncertain interpretations such as `gopher wood` / `cypress wood`.
5. Approve initial foundation task sequence.

## Next action
Review and approve/revise the baseline decision, Scripture integrity, task status, and foundation task documents before implementation.
