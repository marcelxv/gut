# add-ai-friendly-display-commands

---
status: cooking
branch: gut/add-ai-friendly-display-commands
created: 2026-02-01 22:01:48
author: Marcel Scognamiglio 
---

## What

Add AI-friendly commands to gut that help coding agents (Claude Code, Cursor Agent, etc.) read and navigate prep/recipe files efficiently. Specifically:
- `gut show <recipe> [section] [--json]` - Smart display of prep/recipes with section extraction
- `gut next [recipe]` - Show the next action to take
- Enhanced section extraction utilities

## Why

Currently, AI agents must read entire 200+ line prep files to understand what to do next. This:
- Wastes tokens (expensive for users)
- Slows down agent response time
- Makes it hard to get quick status updates
- Reduces the fluency of AI-human collaboration

With smart display commands, AI agents can request exactly what they need (e.g., "just show me the next step" or "what's the approach?") leading to faster, more efficient workflows.

## Success Criteria

- [ ] `gut show <recipe>` displays a smart summary (status, progress, approach, next steps)
- [ ] `gut show <recipe> --json` outputs structured JSON for AI parsing
- [ ] `gut show <recipe> approach|steps|files|risks|testing` extracts specific sections
- [ ] `gut show <recipe> --full` shows complete prep file
- [ ] `gut next [recipe]` shows the next uncompleted step with context
- [ ] All commands work with existing prep file format
- [ ] Commands handle missing files gracefully
- [ ] Help text updated with new commands

## Context

This was requested after observing how Cursor Agent displays gut output. The goal is to make gut feel native to AI coding workflows, where progressive disclosure and structured data are critical for good DX.

Current pain point: AI reads entire prep file (200+ lines) just to answer "what's next?"
Desired state: AI runs `gut next` and gets a 5-line actionable response.

## Constraints

- Must be pure Bash (no new dependencies)
- Must maintain backward compatibility with existing prep files
- Should follow gut's existing code style and structure
- Must work on Bash 3.x+ (macOS compatibility)
- No associative arrays (Bash 3.x limitation)

## Out of Scope

- Interactive TUI/browser interface (marked as low priority)
- Phase navigation (can be added later)
- Modifying prep file format (work with current structure)
- Real-time file watching
- Web UI or server component

## Open Questions

- Should `gut show` default to summary or full view? (Proposal: summary)
- Should JSON output include file contents or just metadata? (Proposal: metadata only)
- What should happen if recipe has no prep file yet? (Proposal: show recipe file instead)
