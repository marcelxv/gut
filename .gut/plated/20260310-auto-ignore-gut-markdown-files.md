# auto-ignore gut markdown files

---
status: served
branch: gut/add-ai-friendly-display-commands
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
