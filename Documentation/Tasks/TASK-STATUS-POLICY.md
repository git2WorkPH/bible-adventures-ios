# Task and Traceability Status Policy

## Requirement status
| Status | Meaning |
|---|---|
| NOT_STARTED | No meaningful implementation exists. |
| PARTIAL | Some behavior exists, but the full requirement is not satisfied. |
| IMPLEMENTED_UNVERIFIED | Implementation appears to satisfy the requirement, but acceptance/verification evidence is incomplete. |
| IMPLEMENTED_VERIFIED | Acceptance criteria are satisfied and verification evidence exists. |
| OUT_OF_SCOPE | Explicitly excluded from current scope. |
| NEEDS_DECISION | A product, content, or architecture decision is required. |

## Task status
| Status | Meaning |
|---|---|
| PROPOSED | Suggested work; not approved. |
| APPROVED | Explicitly approved for implementation. |
| IN_PROGRESS | Approved and actively being implemented. |
| BLOCKED | Cannot proceed due to dependency or decision. |
| IMPLEMENTED | Code changes completed; verification remains. |
| VERIFIED | Implementation reviewed and verification evidence recorded. |
| CANCELLED | Explicitly cancelled. |

## Rules
1. Only approved tasks may be implemented.
2. Code presence does not prove requirement completion.
3. A completed task does not automatically prove its requirement is verified.
4. Session memory records status but does not override authoritative task documents.
5. Conflicting records must be reconciled before continuing implementation.
6. Verified tasks reference their requirement and acceptance criteria.
7. Verification evidence should be recorded.
