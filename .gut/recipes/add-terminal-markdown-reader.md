# add terminal markdown reader

---
status: cooking
branch: gut/add-ai-friendly-display-commands
created: 2026-02-02 15:04:02
author: Marcel Scognamiglio 
---

## What

Add terminal-based commands for reading and reviewing gut markdown files (recipes, preps, context.md, conventions.md, etc.) with excellent developer experience. This should work offline, independent of AI agents, providing:

- Pretty-printed markdown with syntax highlighting and formatting
- Easy navigation between files and sections
- Quick access to different gut files (recipes, preps, pantry)
- Search and filtering capabilities
- Responsive to terminal width and colors

Primary command: `gut read <recipe|file>` with options for formatting and navigation.

## Why

Currently, developers need to:
- Use `cat` or `less` (poor formatting, no syntax highlighting)
- Open files in an editor (slower, context switching)
- Remember file paths in `.gut/` structure
- Read large markdown files without structure/navigation

This hurts DX when:
- Quickly reviewing what's in a recipe before starting work
- Checking context files during development
- Navigating between related files (recipe ↔ prep)
- Working offline without AI assistance
- Reviewing completed work in plated/

A dedicated terminal reader improves solo developer productivity and makes gut files first-class citizens in the terminal workflow.

## Success Criteria

- [ ] `gut read <recipe>` displays recipe with warm, food-themed colors
- [ ] Defaults to recipe file, `--prep` flag shows prep file
- [ ] Minimal section navigation: TOC at top, use `less` search to jump
- [ ] `gut read pantry` or `gut read context` shows pantry files
- [ ] Auto-detect and use `bat` if available, fallback to custom rendering
- [ ] Custom rendering uses warm colors (orange headers, yellow highlights)
- [ ] Support `--plain` (no colors), `--full` (no paging)
- [ ] Pipe through `less -R` for paging and color support
- [ ] File-not-found errors are friendly and suggest alternatives
- [ ] `gut read --help` documents all options
- [ ] Works completely offline (no external dependencies required)

## Context

This complements the AI-friendly `gut show` command:
- `gut show`: Structured output optimized for AI parsing (JSON, summaries)
- `gut read`: Human-optimized display for terminal reading

Inspiration:
- `bat` (syntax highlighting, but not a dependency)
- `glow` (markdown rendering, but we want pure bash)
- `less` (paging, searching)

Should follow gut's philosophy: simple, pure bash, no heavy dependencies.

## Constraints

- Pure Bash (Bash 4.0+ for macOS compatibility)
- No external dependencies required (optional enhancements ok if available)
- Work offline completely
- Must handle terminals without color support gracefully
- Should work with both light and dark terminal themes
- File reading must be efficient (no performance issues with large files)
- Maintain backward compatibility with existing gut structure

## Out of Scope

- Web UI or GUI viewer
- Real-time file watching/auto-reload
- Markdown editing capabilities (use `gut pantry edit` for that)
- Converting markdown to other formats (HTML, PDF)
- Integration with external tools (VSCode, etc.)
- Complex TUI with mouse support (keep it simple)
- Image rendering in terminal

## Decisions

- **Default file**: Show recipe by default, use `--prep` flag for prep file
- **Section navigation**: Yes, minimal (show TOC at top, use `less` search to jump)
- **Color scheme**: Warm, food-related colors (oranges, yellows, reds)
- **Interactive browser**: Not in v1, keep it minimal
- **External tools**: Detect and use `bat` if available, fallback to custom rendering
- **Paging**: Use `less -R` for color support and built-in search/navigation
