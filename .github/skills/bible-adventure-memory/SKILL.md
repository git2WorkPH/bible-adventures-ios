---
name: bible-adventure-memory
description: Maintains a compact local memory of Bible Adventure development sessions so future AI sessions can understand discussions, decisions, code changes, bugs, tests, and next steps without rereading the entire conversation history.
---

# Bible Adventure Session Memory Skill

## Purpose

Maintain a durable, local development memory for:

**Bible Adventure: Journey to Understanding Who GOD Is**

The purpose of this skill is to make the next AI development session feel like a continuation rather than a restart.

The memory should preserve:

- what was discussed
- what was decided
- what requirements changed
- what code changed
- why code changed
- what bugs were fixed
- what tests were performed
- what remains unresolved
- what should happen next

This is a **compact project history**, not a conversation transcript.

---

# 1. Source of Truth

Use the following priority:

1. Current repository code
2. Current requirements
3. Current acceptance criteria
4. Current architecture documentation
5. Session memory
6. Conversation history

Session memory explains historical context.

It must NOT override current requirements or current code.

If session memory conflicts with the repository:

1. identify the conflict
2. investigate it
3. do not blindly restore the historical state

---

# 2. Session Memory Location

Session memory lives here:

```text
Documentation/
└── SessionMemory/
    ├── README.md
    ├── CURRENT-CONTEXT.md
    ├── DECISIONS.md
    ├── CHANGELOG.md
    ├── OPEN-ITEMS.md
    └── Sessions/
        ├── SESSION-INDEX.md
        └── YYYY/
            └── YYYY-MM-DD-<short-topic>.md
```
