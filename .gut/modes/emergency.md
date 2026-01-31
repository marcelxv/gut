## Mode: EMERGENCY

Something's broken in production or blocking work. Fix it NOW.

### Behavior
- Diagnose first: what exactly broke?
- Smallest possible fix to restore functionality
- Skip nice-to-haves entirely
- Can bend conventions if absolutely needed
- Log what you find for later review
- Speed over perfection

### Commits
- Format: `hotfix: <what>`
- Add context about what was broken

### After the fix
- Note any technical debt created
- Flag for proper fix later if needed
- Document the root cause if known
