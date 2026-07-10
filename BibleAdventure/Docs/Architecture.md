# Bible Adventure Architecture

## Philosophy

Bible Adventure is built using a domain-first architecture.

The goal is to keep gameplay, story content, and presentation separate so new Bible stories can be added with minimal code changes.

## Core Principles

- Views display data.
- Models represent the domain.
- Repositories provide data.
- Services perform reusable work.
- Stories contain content.
- Features contain UI.

## Flow

StoryPlayerView
↓

StoryRepository

↓

Story

↓

DialoguePage
