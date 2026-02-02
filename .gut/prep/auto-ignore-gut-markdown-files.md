# Prep: auto-ignore-gut-markdown-files

---
status: prepping
recipe: auto-ignore-gut-markdown-files
created: 2026-02-02 17:51:19
---

## Recipe

# auto-ignore gut markdown files

---
status: draft
created: 2026-02-02 17:42:02
author: Marcel Scognamiglio 
---

## What

Automatically add `.gut/` directory to `.gitignore` when running `gut init`, so that recipes, preps, and other gut markdown files don't clutter `git status` or accidentally get committed to the project repository.

## Why

Currently, `.gut/` files (recipes, preps, seasonings, etc.) show up in `git status` as untracked files. This:
- Clutters the git working tree
- Can accidentally be committed to the project
- Makes it harder to see actual project changes
- Violates the principle that gut files are local workflow artifacts

Gut files are personal workflow tools, not project code. They should be gitignored by default, similar to `.vscode/` or `.idea/`.

## Success Criteria

- [ ] `gut init` adds `.gut/` to `.gitignore` automatically
- [ ] Creates `.gitignore` if it doesn't exist
- [ ] Appends to existing `.gitignore` if it exists
- [ ] Doesn't duplicate entry if `.gut/` already in .gitignore
- [ ] Preserves existing .gitignore content and formatting
- [ ] Shows confirmation message when adding to .gitignore
- [ ] Optional: `--track` flag to skip gitignore (for gut-cli repo itself)

## Context

Current behavior:
```bash
$ gut init
$ git status
  Untracked files:
    .gut/pantry/
    .gut/recipes/
    .gut/modes/
```

Desired behavior:
```bash
$ gut init
✅ Added .gut/ to .gitignore
$ git status
  nothing to commit (working tree clean)
```

Exception: The gut-cli repository itself might want to track some `.gut/` files as examples.

## Constraints

- Must handle missing .gitignore gracefully
- Don't corrupt existing .gitignore
- Should work on all platforms (macOS, Linux)
- Pure bash implementation
- Idempotent (safe to run multiple times)

## Out of Scope

- Retroactively gitignoring existing tracked .gut files (user can `git rm --cached`)
- Global gitignore configuration
- Selective gitignoring (e.g., track recipes but not preps)

## Decisions

- Add `.gut/` entry by default on `gut init`
- Add `--track` flag for opt-out (for gut-cli repo itself)
- Show clear message when modifying .gitignore

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

Modify `cmd_init()` to automatically add `.gut/` to `.gitignore`:
1. Check if `.gitignore` exists, create if missing
2. Check if `.gut/` already in .gitignore (avoid duplicates)
3. Append `.gut/` entry with helpful comment
4. Support `--track` flag to skip gitignore (for gut-cli repo)
5. Show confirmation message

Minimal change: ~20-30 lines added to `cmd_init()`.

### Files to Create/Modify

| File | Action | Purpose |
|------|--------|---------|
| `gut` | Modify | Update `cmd_init()` to handle .gitignore |
| `gut` | Modify | Add `--track` flag support to init command |

### Step-by-Step

1. [ ] Add `--track` flag parsing to `cmd_init()`
2. [ ] After creating `.gut/` directory, check for `--track` flag
3. [ ] If not `--track`: run gitignore logic
4. [ ] Check if `.gitignore` exists in project root
5. [ ] If missing: create with `.gut/` entry and comment
6. [ ] If exists: check if `.gut/` already present using grep
7. [ ] If not present: append `.gut/` with blank line and comment
8. [ ] Show success message: "✅ Added .gut/ to .gitignore"
9. [ ] If `--track`: show message "⚠️ .gut/ files will be tracked (--track mode)"
10. [ ] Update help text with `--track` flag documentation

### Dependencies Needed

None - uses standard bash commands (grep, echo, touch).

### Risks & Considerations

**Risks:**
- Corrupting existing .gitignore → Use `>>` append, test thoroughly
- Duplicate entries → Check with grep before adding
- Different .gitignore formats → Keep it simple, add at end
- File permissions → Handle write errors gracefully

**Edge cases:**
- .gitignore is read-only → Show error, suggest manual edit
- .gut/ is already tracked in git → Can't retroactively untrack (user needs `git rm --cached`)
- Multiple .gut/ patterns already exist → Skip if any variant exists
- .gitignore in subdirectory vs root → Only handle root .gitignore

**Format:**
```gitignore
# gut workflow files (added by gut init)
.gut/
```

### Testing Strategy

**Manual tests:**
- [ ] `gut init` in fresh repo → creates .gitignore with .gut/
- [ ] `gut init` with existing .gitignore → appends .gut/
- [ ] `gut init` when .gut/ already in .gitignore → doesn't duplicate
- [ ] `gut init --track` → skips gitignore modification
- [ ] Verify .gitignore formatting (no corruption)
- [ ] `git status` after init → .gut/ not shown
- [ ] Existing .gitignore content preserved exactly

---

## AI Instructions

When implementing this recipe:

1. Read the full recipe and prep plan above
2. Follow the project conventions in the pantry
3. Implement step by step, committing logical chunks
4. Update the recipe status as you progress
5. Run tests before marking as complete

To start cooking: `gut cook auto-ignore-gut-markdown-files`
