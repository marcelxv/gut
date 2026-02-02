# Prep: add-ai-friendly-display-commands

---
status: prepping
recipe: add-ai-friendly-display-commands
created: 2026-02-01 22:03:10
---

## Recipe

# add-ai-friendly-display-commands

---
status: draft
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

---

## Project Context

# Project Context

> This file helps AI understand your project. Keep it updated!

## What is this project?

[Describe your project in 2-3 sentences]

## Tech Stack

- Language:
- Framework:
- Database:
- Other:

## Architecture Overview

[Describe the high-level architecture]

## Key Conventions

- Naming:
- File structure:
- Testing approach:
- Error handling:

## Important Files

- Entry point:
- Config:
- Tests:

## Current State

[What's working? What's in progress?]

## Out of Scope / Don't Touch

[Things AI should NOT modify]

---

## Conventions

# Coding Conventions

## Style

[Your code style preferences]

## Patterns We Use

[Common patterns in this codebase]

## Patterns We Avoid

[Anti-patterns, things not to do]

## Dependencies

[How we handle dependencies, what's approved]

---

## Implementation Plan

### Approach

Add helper functions for section extraction, then implement two new commands (`show` and `next`) as new case handlers in the gut script. Follow the existing pattern used by commands like `menu`, `status`, and `resume`. Use sed/grep for parsing markdown sections since we can't use associative arrays (Bash 3.x).

### Files to Create/Modify

| File | Action | Purpose |
|------|--------|---------|
| gut | modify | Add helper functions for section extraction |
| gut | modify | Add `cmd_show()` function |
| gut | modify | Add `cmd_next()` function |
| gut | modify | Update main case statement to route new commands |
| gut | modify | Update help text with new commands |

### Step-by-Step

1. [ ] Add helper function `extract_section()` to extract markdown sections by header
2. [ ] Add helper function `show_prep_summary()` for smart summary display
3. [ ] Add helper function `get_active_recipe()` to find the current cooking recipe
4. [ ] Implement `cmd_show()` with support for summary/section/full/json modes
5. [ ] Implement `cmd_next()` to show the next uncompleted step
6. [ ] Update main command router (case statement) to handle `show` and `next`
7. [ ] Update help text to document new commands
8. [ ] Test all modes: summary, sections, json, full, next
9. [ ] Test error handling: missing files, no prep file, no active recipe

### Dependencies Needed

None - pure Bash using existing tools (grep, sed, cut)

### Risks & Considerations

**Bash 3.x compatibility:**
- Cannot use associative arrays
- Must use case statements instead of hash lookups
- Test on macOS (ships with Bash 3.2)

**Markdown parsing:**
- Current prep files use `###` for subsections
- Need robust section extraction that handles various heading levels
- Should handle missing sections gracefully

**Edge cases:**
- Recipe exists but no prep file (should fallback to showing recipe)
- Prep file exists but empty Implementation Plan section
- Multiple recipes cooking at once (for `gut next` with no arg)
- Malformed prep files

**Backward compatibility:**
- Must work with existing prep file format
- Don't break existing commands
- Ensure color codes work across terminals

### Testing Strategy

**Manual testing:**
1. Create test recipe and prep it
2. Test `gut show test-recipe` (summary mode)
3. Test `gut show test-recipe --json` (verify valid JSON)
4. Test each section: `gut show test-recipe approach|steps|files|risks|testing`
5. Test `gut show test-recipe --full`
6. Test `gut next` and `gut next test-recipe`
7. Test error cases: nonexistent recipe, no prep file

**Regression testing:**
- Run existing gut commands to ensure nothing broke
- Check `gut menu`, `gut status`, `gut resume` still work
- Verify help text displays correctly

**AI agent testing:**
- Have Claude Code run `gut show` and parse output
- Test JSON mode for structured parsing
- Verify token reduction vs reading full prep file

---

## AI Instructions

When implementing this recipe:

1. Read the full recipe and prep plan above
2. Follow the project conventions in the pantry
3. Implement step by step, committing logical chunks
4. Update the recipe status as you progress
5. Run tests before marking as complete

To start cooking: `gut cook add-ai-friendly-display-commands`
