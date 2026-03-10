# add obsidian export

---
status: served
branch: gut/add-ai-friendly-display-commands
created: 2026-03-09 19:45:00
author: Marcel Scognamiglio
---

## What

Add `gut obsidian` command that generates Obsidian-ready markdown from the existing `.gut/` directory. The command enriches gut's markdown files with Obsidian features (wikilinks, frontmatter tags, callouts, Mermaid diagrams) and generates hub notes (Dashboard, Recipe Board, AI Modes) — all output to `.gut/obsidian/` without modifying original files.

```bash
gut obsidian              # generate Obsidian vault from .gut/
gut obsidian --refresh    # regenerate after changes
gut obsidian --open       # generate + open in Obsidian
```

## Why

gut already generates ~1,000+ lines of structured markdown across `.gut/` (recipes, prep, plated, pantry, modes, seasoning, flame). This content is rich but locked behind terminal commands and raw file reads.

Obsidian is the most popular markdown knowledge base tool. By exporting `.gut/` as an Obsidian-ready vault, developers get:

- **Visual dashboard** of all recipes by status with progress tracking
- **Graph view** showing recipe → prep → plated lineage and dependencies
- **Clickable checkboxes** for success criteria (vs reading `[x]` in terminal)
- **Full-text search** across all recipes, preps, seasonings, flame logs
- **Rendered Mermaid diagrams** for dependency graphs and architecture
- **Backlinks** — click any recipe and see everything that references it

This is a zero-dependency, pure-bash feature that turns a hidden folder into a visual project management layer.

## Success Criteria

- [ ] `gut obsidian` generates enriched markdown into `.gut/obsidian/`
- [ ] Original `.gut/` files are never modified (non-destructive)
- [ ] Hub notes generated: Dashboard.md, Recipe Board.md, AI Modes.md
- [ ] Recipe notes enriched with `[[wikilinks]]` to prep, plated, pantry, modes
- [ ] Prep notes enriched with `[[wikilinks]]` back to recipe and to pantry/conventions
- [ ] Plated notes enriched with `[[wikilinks]]` to original recipe and prep
- [ ] Pantry and mode notes enriched with cross-links
- [ ] All notes include `project: <name>` in frontmatter (from git repo name)
- [ ] All notes include `tags:` arrays based on note type (recipe, prep, plated, etc.)
- [ ] Dashboard includes Mermaid dependency graph between recipes
- [ ] Recipe Board groups recipes by status (draft, prepped, cooking, tasting, served, spoiled)
- [ ] Progress bars rendered from success criteria checkbox counts
- [ ] Obsidian callouts used for status indicators (`> [!success]`, `> [!warning]`, etc.)
- [ ] `--refresh` flag regenerates all files (overwrites previous output)
- [ ] `--open` flag opens `.gut/obsidian/` in Obsidian after generation
- [ ] `.gut/obsidian/` added to `.gitignore` (generated output, not source)
- [ ] Help text updated with `gut obsidian` command
- [ ] Works with empty kitchens (no recipes yet — generates minimal dashboard)

## Context

This feature was designed after a hands-on investigation of gut + Obsidian integration. Key findings:

1. **No existing Obsidian plugin** does what gut needs — the closest are generic kanban boards and Dataview queries, neither of which understand gut's recipe lifecycle
2. **A custom Obsidian plugin is overkill** — bash-generated markdown with wikilinks and Mermaid gets 90% of the value at 10% of the effort
3. **`.gut/` is already a near-perfect vault shape** — folders map to categories, frontmatter exists, cross-references are natural
4. **The graph view needs project anchoring** — without a `project:` field in frontmatter, gut notes mix with other vault content

A working prototype was built and tested in Obsidian (naomi project), confirming that the approach works well with graph view, backlinks, Mermaid rendering, and callouts — all built-in Obsidian features, no plugins required.

## Constraints

- Pure bash (no new dependencies)
- Must work on Bash 3.x+ (macOS compatibility)
- No associative arrays (Bash 3.x limitation)
- Non-destructive: never modify files in `.gut/recipes/`, `.gut/prep/`, etc.
- All output goes to `.gut/obsidian/` only
- Must handle missing directories gracefully (no seasoning? skip it)
- Must parse existing frontmatter without breaking it
- Obsidian features used must be built-in (no Dataview, no community plugins required)

## Out of Scope

- Custom Obsidian plugin (TypeScript)
- Obsidian Canvas (.canvas JSON) generation
- Dataview queries (requires plugin installation)
- Live file watching / auto-refresh
- Syncing changes from Obsidian back to `.gut/`
- Modifying gut's core markdown format
- Supporting vaults with multiple gut projects (v2)

## Open Questions

- [ ] Should `gut obsidian` auto-detect the project name from git remote, directory name, or `context.md`?
- [ ] Should `.gut/obsidian/` mirror the `.gut/` folder structure or flatten it?
- [ ] Should the command warn if Obsidian is not installed, or just generate the files silently?
- [ ] Should seasoning and flame logs be individual notes or aggregated into summary notes?
