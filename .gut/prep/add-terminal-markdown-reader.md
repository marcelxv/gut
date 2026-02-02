# Prep: add-terminal-markdown-reader

---
status: prepping
recipe: add-terminal-markdown-reader
created: 2026-02-02 17:10:52
---

## Recipe

# add terminal markdown reader

---
status: draft
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

Add `gut read <target>` command with smart file resolution and pretty markdown rendering:

1. **Argument parsing**: Handle recipe names, special targets (pantry, context), and flags (--prep, --plain, --full)
2. **File resolution**: Map user input to actual file paths in `.gut/` structure
3. **Renderer selection**: Check for `bat`, use if available with warm theme, fallback to custom renderer
4. **Custom renderer**: ANSI color codes for warm food-themed styling (orange headers, yellow highlights, red emphasis)
5. **TOC generation**: Extract headers and display at top for quick navigation reference
6. **Paging**: Pipe through `less -R` for color support and search/navigation (unless --full)

Keep it minimal: ~150-200 lines, reuse existing gut patterns (error messages, color definitions).

### Files to Create/Modify

| File | Action | Purpose |
|------|--------|---------|
| `gut` | Modify | Add `gut_read()` function and route `read` subcommand |
| `gut` | Modify | Add warm color definitions (ORANGE, YELLOW, RED) to existing colors |
| `gut` | Modify | Update help text to document `gut read` usage |

### Step-by-Step

1. [ ] Define warm color variables (ORANGE='\033[38;5;208m', YELLOW='\033[1;33m', RED='\033[38;5;203m')
2. [ ] Create `gut_read()` function with argument parsing
3. [ ] Implement file resolution logic (recipe → prep with --prep, pantry shortcuts)
4. [ ] Add `command -v bat` check and use bat if available with food theme colors
5. [ ] Implement custom markdown renderer for fallback:
   - Headers (# → ORANGE, bold)
   - Bold text (**text** → YELLOW)
   - Code blocks (```→ dim gray background)
   - Lists (- → YELLOW bullet)
   - Links/emphasis (_text_ → RED)
6. [ ] Add TOC generator (extract lines starting with #, format as index)
7. [ ] Pipe output through `less -R` (unless --full or --plain flags)
8. [ ] Add friendly error messages for file-not-found (suggest alternatives)
9. [ ] Update help text with usage examples
10. [ ] Test with: recipes, preps, pantry files, missing files, --flags

### Dependencies Needed

**Required**: None (pure bash)

**Optional enhancements** (auto-detected):
- `bat` - for enhanced syntax highlighting (graceful fallback if missing)
- `less` - for paging (fallback to `more` or direct output)

### Risks & Considerations

**Risks:**
- Color codes may not render on all terminals → Detect NO_COLOR env var, provide --plain flag
- `bat` versions vary in theme support → Use safe color codes that work everywhere
- Large files (>1000 lines) could be slow → Profile rendering, optimize if needed
- Tab characters in markdown → Expand tabs to spaces for consistent display

**Edge cases:**
- Recipe exists but prep doesn't (or vice versa) → Show what exists, clear message
- Multiple pantry files → Detect context.md vs conventions.md vs custom
- Empty files → Show friendly message
- Binary or non-text files → Detect and warn

**Compatibility:**
- Bash 3.x on macOS → Avoid associative arrays, use case statements
- Light vs dark terminals → Use ANSI codes that work in both (avoid pure black/white)

### Testing Strategy

**Manual testing checklist:**
- [ ] `gut read <recipe-name>` → Shows recipe with warm colors
- [ ] `gut read <recipe-name> --prep` → Shows prep file
- [ ] `gut read pantry` → Shows context.md
- [ ] `gut read context` → Same as pantry
- [ ] `gut read --plain <recipe>` → No colors
- [ ] `gut read --full <recipe>` → No paging
- [ ] `gut read nonexistent` → Friendly error + suggestions
- [ ] Test with `bat` installed → Uses bat
- [ ] Test without `bat` → Falls back to custom renderer
- [ ] Test on light terminal theme → Colors readable
- [ ] Test on dark terminal theme → Colors readable
- [ ] Large file (>500 lines) → Paging works, search works (/pattern in less)
- [ ] Recipe with all markdown elements (headers, lists, code, links, bold, italic)

**Validation:**
- Compare output side-by-side with `cat` to ensure no content loss
- Verify TOC matches actual section headers
- Check color codes don't leak (clean output piping)

---

## AI Instructions

When implementing this recipe:

1. Read the full recipe and prep plan above
2. Follow the project conventions in the pantry
3. Implement step by step, committing logical chunks
4. Update the recipe status as you progress
5. Run tests before marking as complete

To start cooking: `gut cook add-terminal-markdown-reader`
