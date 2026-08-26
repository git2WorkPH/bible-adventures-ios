# Project Assessment

## Purpose
Perform a read-only health check of the repository against requirements, architecture, implementation, tests, documentation, and project goals.

## Required areas
- repository structure
- requirements traceability
- architecture and coupling
- implementation quality
- testing
- reliability/security where applicable
- performance risks where evidence supports them
- documentation
- reusable foundation opportunities
- product/UX risks when requirements support the observation

## Finding format
Each finding should contain:
- ID
- category
- severity: CRITICAL/HIGH/MEDIUM/LOW/INFO
- evidence with file/symbol references where possible
- impact
- recommendation
- related requirement/task

## Task rule
Assessment may propose tasks but must not approve or implement them.

```text
Finding → Recommendation → Proposed Task → Human Approval → Implementation
```

## Rules
- Read-only by default.
- No silent scope changes.
- No speculative criticism.
- Do not recommend abstraction merely for style; show reuse or maintainability value.
- Distinguish facts, risks, and recommendations.

## Example
```text
Use the project-assessment skill. Perform a read-only assessment against requirements, architecture, tests and session context. Identify gaps, risks, duplicated functionality, foundation opportunities and proposed tasks. Do not modify code.
```
