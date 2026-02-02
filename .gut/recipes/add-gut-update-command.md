# add gut update command

---
status: cooking
branch: gut/add-ai-friendly-display-commands
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
