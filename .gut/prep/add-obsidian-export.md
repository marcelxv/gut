# Prep: add-obsidian-export

---
status: prepping
recipe: add-obsidian-export
created: 2026-03-09 19:50:00
---

## Recipe

# add obsidian export

---
status: draft
created: 2026-03-09 19:45:00
author: Marcel Scognamiglio
---

## What

Add `gut obsidian` command that generates Obsidian-ready markdown from the existing `.gut/` directory. Enriches files with wikilinks, frontmatter tags, callouts, Mermaid diagrams and generates hub notes — all output to `.gut/obsidian/` without modifying originals.

## Why

gut generates 1,000+ lines of structured markdown that's locked behind terminal reads. Obsidian turns it into a visual, navigable knowledge base with graph view, backlinks, rendered diagrams, and clickable checkboxes — zero plugins required.

## Success Criteria

- [ ] `gut obsidian` generates enriched markdown into `.gut/obsidian/`
- [ ] Original `.gut/` files are never modified
- [ ] Hub notes generated: Dashboard.md, Recipe Board.md, AI Modes.md
- [ ] All notes enriched with `[[wikilinks]]` and frontmatter (project, tags)
- [ ] Dashboard includes Mermaid dependency graph
- [ ] Recipe Board groups recipes by status with progress bars
- [ ] Obsidian callouts for status indicators
- [ ] `--refresh` regenerates, `--open` opens in Obsidian
- [ ] `.gut/obsidian/` added to `.gitignore`
- [ ] Help text updated
- [ ] Works with empty kitchens

## Constraints

- Pure bash, Bash 3.x+, no associative arrays
- Non-destructive: output to `.gut/obsidian/` only
- Obsidian features must be built-in (no community plugins required)

## Out of Scope

- Custom Obsidian plugin, Canvas, Dataview, live watching, bidirectional sync

---

## Project Context

# Project Context

gut-cli is a pure Bash CLI tool (~3,700 lines) for AI-native development workflows using a culinary metaphor (recipe → prep → cook → taste → serve). It manages structured markdown files in `.gut/` directories within user projects.

## Tech Stack

- Language: Bash
- Dependencies: None (pure Bash + git + standard Unix tools)
- Compatibility: Bash 3.x+ (macOS ships 3.2)

## Architecture Overview

Single `gut` bash script with:
- i18n system (en/pt) using case statements
- Helper functions (slugify, timestamps, extract_section, etc.)
- One `cmd_*()` function per command
- Main router via case statement
- Directory constants: GUT_DIR, GUT_RECIPES, GUT_PREP, etc.

## Key Conventions

- Functions named `cmd_<command>()`
- Colors via ANSI escape codes (RED, GREEN, YELLOW, etc.)
- Emojis as status icons (CHEF, RECIPE, PREP, etc.)
- `gut_check_init` at top of each command
- `gut_header`, `gut_success`, `gut_warn`, `gut_error` for output
- Frontmatter parsed with `grep -m1 "^field:" | cut -d' ' -f2`
- No associative arrays (Bash 3.x)

## Important Files

- Entry point: `gut` (single script)
- Config: `.gut/pantry/context.md`, `.gut/pantry/conventions.md`
- Modes: `.gut/modes/planned.md`, `reactive.md`, `emergency.md`

---

## Conventions

- Follow existing code patterns: `cmd_obsidian()` function, `gut_check_init`, same flag parsing style
- Use `gut_header`, `gut_success`, `gut_print` for all output
- Parse flags with `while [[ $# -gt 0 ]]; case` pattern
- Iterate recipes with `for recipe in "$GUT_RECIPES"/*.md; do`
- Extract frontmatter with `grep -m1 "^status:" "$file" | cut -d' ' -f2`
- Don't use `cat <<` for large heredocs when building files line-by-line (prefer `echo >>`)
- Add i18n keys for user-facing strings

---

## Implementation Plan

### Approach

Add a `cmd_obsidian()` function (~200-300 lines) that:

1. Reads all `.gut/` content (recipes, prep, plated, pantry, modes, seasoning, flame)
2. Detects project name from git remote or directory name
3. Generates enriched copies into `.gut/obsidian/` with Obsidian features injected
4. Generates 3 hub notes from scratch by iterating over recipe data

The function delegates to helper functions for each generation step. No external dependencies — uses grep, sed, cut, basename, dirname (all standard Unix).

### Files to Create/Modify

| File | Action | Purpose |
|------|--------|---------|
| `gut` | Modify | Add `cmd_obsidian()` function (~200-300 lines) |
| `gut` | Modify | Add helper: `obsidian_get_project_name()` |
| `gut` | Modify | Add helper: `obsidian_enrich_recipe()` |
| `gut` | Modify | Add helper: `obsidian_enrich_prep()` |
| `gut` | Modify | Add helper: `obsidian_enrich_note()` (generic for pantry/modes/plated) |
| `gut` | Modify | Add helper: `obsidian_generate_dashboard()` |
| `gut` | Modify | Add helper: `obsidian_generate_recipe_board()` |
| `gut` | Modify | Add helper: `obsidian_generate_ai_modes()` |
| `gut` | Modify | Add helper: `obsidian_count_checkboxes()` |
| `gut` | Modify | Add routing in main() case statement |
| `gut` | Modify | Update help text (en + pt) |
| `gut` | Modify | Add i18n keys for obsidian command strings |

### Step-by-Step

1. [ ] Add `obsidian_get_project_name()` — detect from git remote URL, fall back to directory name
2. [ ] Add `obsidian_count_checkboxes()` — count `[x]` and `[ ]` in a file, return done/total
3. [ ] Add `obsidian_enrich_recipe()` — copy recipe, inject frontmatter (project, tags), append See Also section with wikilinks to prep/plated/pantry/modes
4. [ ] Add `obsidian_enrich_prep()` — copy prep, inject frontmatter, append See Also with wikilinks back to recipe and to pantry/conventions
5. [ ] Add `obsidian_enrich_note()` — generic enricher for pantry, modes, plated (inject frontmatter + cross-links)
6. [ ] Add `obsidian_generate_dashboard()` — build Dashboard.md from scratch: overview table, Mermaid dependency graph, quick links, directory map
7. [ ] Add `obsidian_generate_recipe_board()` — iterate recipes grouped by status, show progress bars, link to each recipe note
8. [ ] Add `obsidian_generate_ai_modes()` — comparison table of modes with links to individual mode notes, decision flowchart (Mermaid)
9. [ ] Add `cmd_obsidian()` — orchestrator: parse flags, create `.gut/obsidian/` dirs, call helpers, handle `--open`
10. [ ] Add routing in `main()`: `obsidian) cmd_obsidian "$@" ;;`
11. [ ] Update help text in both `en` and `pt` sections
12. [ ] Add i18n keys: `obsidian_generating`, `obsidian_done`, `obsidian_open`, `obsidian_refreshing`
13. [ ] Add `.gut/obsidian/` to `.gitignore` handling in `cmd_obsidian` (append if not present)
14. [ ] Test with gut-cli's own `.gut/` directory
15. [ ] Test with naomi's `.gut/` directory
16. [ ] Test with empty kitchen (freshly `gut init`'d project)

### Dependencies Needed

None — pure Bash using existing tools (grep, sed, cut, basename, dirname, date).

Optional: `open` command (macOS) or `xdg-open` (Linux) for `--open` flag.

### Risks & Considerations

**Frontmatter injection:**
- Must detect if frontmatter already exists (starts with `---`) vs notes without frontmatter
- Must inject `project:` and `tags:` without breaking existing fields
- Use `sed` to insert after first `---` line, or prepend full block if none exists

**Wikilink generation:**
- Must match recipe slugs to prep/plated filenames (they use the same slug)
- Plated files are prefixed with datestamp: `20260202-add-auth.md` → need to handle this pattern
- Must handle recipes that have no prep or no plated file (skip those links)

**Mermaid dependency graph:**
- Dependencies are expressed as prose in recipes (e.g., "depends on add-user-authentication")
- Parsing natural language deps is fragile — start with a simple approach: look for `[[recipe-name]]` references or lines containing other recipe slugs in the Constraints/Context sections
- v1 can show a flat list of recipes with status colors, without dependency arrows

**Bash 3.x compatibility:**
- No associative arrays — use parallel arrays or case statements
- No `mapfile` — use `while read` loops
- `sed -i` syntax differs between macOS and Linux — use `sed -i '' ` on macOS or write to temp file

**Progress bar rendering:**
- Count `- [x]` and `- [ ]` lines in Success Criteria section
- Render as `█░░░░░░░░░ 10%` — calculate with bash arithmetic

**Edge cases:**
- Recipe with no success criteria → show "no criteria defined"
- Empty seasoning/flame dirs → skip those sections in dashboard
- Recipe status not recognized → default to "draft"
- Very long recipe names → truncate in tables if needed

### Testing Strategy

**Manual tests:**
1. [ ] `gut obsidian` on gut-cli's own `.gut/` → verify all 5 recipes + 4 preps generate
2. [ ] `gut obsidian` on naomi's `.gut/` → verify 2 recipes + 2 preps + 1 resume generate
3. [ ] `gut obsidian` on fresh `gut init` project → verify minimal dashboard, no crash
4. [ ] `gut obsidian --refresh` → verify files are overwritten cleanly
5. [ ] `gut obsidian --open` → verify Obsidian opens (macOS)
6. [ ] Open generated `.gut/obsidian/` in Obsidian → verify graph view clusters properly
7. [ ] Verify all `[[wikilinks]]` resolve (no broken links in Obsidian)
8. [ ] Verify Mermaid diagrams render in Obsidian
9. [ ] Verify callouts render (`> [!success]`, `> [!warning]`)
10. [ ] Verify frontmatter is valid (Obsidian recognizes project and tags fields)
11. [ ] Verify `.gut/obsidian/` is in `.gitignore` after running
12. [ ] Verify original `.gut/recipes/*.md` files are untouched

**Regression:**
- Run `gut menu`, `gut status`, `gut show`, `gut resume` — ensure nothing broke
- Verify help text displays correctly in both languages

---

## AI Instructions

When implementing this recipe:

1. Read the full recipe and prep plan above
2. Follow the project conventions in the pantry
3. Implement step by step, committing logical chunks
4. Update the recipe status as you progress
5. Run tests before marking as complete

To start cooking: `gut cook add-obsidian-export`
