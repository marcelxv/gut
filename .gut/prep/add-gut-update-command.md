# Prep: add-gut-update-command

---
status: prepping
recipe: add-gut-update-command
created: 2026-02-02 17:51:14
---

## Recipe

# add gut update command

---
status: draft
created: 2026-02-02 17:41:54
author: Marcel Scognamiglio 
---

## What

Add `gut update` command that pulls latest changes from the git repository when gut is installed as a local clone. This allows users to easily update their gut installation without manually running git commands.

## Why

Currently, users who install gut from source need to:
- Remember to cd into the gut-cli directory
- Run `git pull` manually
- No easy way to check if they're on the latest version

This makes it hard to stay up-to-date with new features and bug fixes.

## Success Criteria

- [ ] `gut update` pulls latest changes when gut is a git clone
- [ ] Detects if gut is installed from git (has .git directory)
- [ ] Shows helpful message if not installed from git
- [ ] Shows current version before and after update
- [ ] Handles errors gracefully (merge conflicts, network issues)
- [ ] Works with both main and custom branches
- [ ] Updates help text with new command

## Context

Users can install gut in different ways:
- Git clone (can be updated)
- Homebrew (uses `brew upgrade gut`)
- Manual copy (can't be auto-updated)

We only support auto-update for git clone installations.

## Constraints

- Must detect installation method reliably
- Don't break if .git directory is missing
- Respect user's current branch
- Pure bash implementation
- Should work on both macOS and Linux

## Out of Scope

- Updating homebrew installations (use `brew upgrade`)
- Auto-update checking on every command
- Version pinning or rollback
- Updating dependencies

## Decisions

- Only support git-based installations
- Use `git pull` for simplicity (rebase can be manual)
- Show version info before/after update

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

Add `cmd_update()` function that:
1. Detects if gut is installed from git (check for .git directory in script location)
2. Gets current version/commit hash
3. Runs `git pull` in the gut directory
4. Shows before/after version info
5. Handles errors gracefully

Simple, focused implementation: ~50 lines of bash.

### Files to Create/Modify

| File | Action | Purpose |
|------|--------|---------|
| `gut` | Modify | Add `cmd_update()` function and routing |
| `gut` | Modify | Add `cmd_version()` enhancement to show commit hash |
| `gut` | Modify | Update help text with `gut update` command |

### Step-by-Step

1. [ ] Add `cmd_update()` function that detects git installation
2. [ ] Get script directory path using `$0` and resolve symlinks
3. [ ] Check if `.git` directory exists in script directory
4. [ ] If not git: show helpful message (try homebrew or manual install)
5. [ ] Store current commit hash for comparison
6. [ ] Run `git pull` in script directory
7. [ ] Show before/after commit info
8. [ ] Handle git errors (network, merge conflicts, detached HEAD)
9. [ ] Add routing in main() case statement: `update) cmd_update ;;`
10. [ ] Update help text in both languages

### Dependencies Needed

None - uses existing git commands.

### Risks & Considerations

**Risks:**
- Script might be symlinked (e.g., in /usr/local/bin) → Resolve symlink to find actual location
- User might have uncommitted changes in gut repo → Check and warn
- Merge conflicts during pull → Show error, suggest manual resolution
- Network issues → Show clear error message
- Not a git repo → Detect and show alternative update methods

**Edge cases:**
- Detached HEAD state → Warn user
- Custom branch (not main) → Pull from current branch
- Shallow clone → Should still work with git pull

### Testing Strategy

**Manual tests:**
- [ ] `gut update` in git clone → pulls latest changes
- [ ] `gut update` in non-git install → shows helpful error
- [ ] `gut update` with uncommitted changes → shows warning
- [ ] `gut update` with network offline → shows error
- [ ] `gut update` when already up-to-date → shows "already up-to-date"
- [ ] Verify version changes after update
- [ ] Test with symlinked gut script

---

## AI Instructions

When implementing this recipe:

1. Read the full recipe and prep plan above
2. Follow the project conventions in the pantry
3. Implement step by step, committing logical chunks
4. Update the recipe status as you progress
5. Run tests before marking as complete

To start cooking: `gut cook add-gut-update-command`
