# Backlog

## Next Up

### AI Integration Prompts
Add suggested prompts that work well with different AI assistants.

```bash
gut prompts           # show prompt templates
gut prompts prep      # show prep prompt
gut prompts review    # show code review prompt
```

Templates:
- **Prep prompt**: "Read the context and recipe below. Create an implementation plan..."
- **Cook prompt**: "Implement the plan step by step. After each file, explain what you did..."
- **Review prompt**: "Review this code against the recipe requirements..."

Could also add `.gut/prompts/` directory for custom prompts.

---

## Ideas

- `gut diff` — Show what changed since recipe started
- `gut timeline` — Visual timeline of recipe progress
- `gut pair` — Real-time sync between devs working on same recipe
- `gut learn` — Capture lessons learned after serving
- `gut template` — Recipe templates for common patterns (API endpoint, component, etc.)
- `gut import` — Import GitHub issue as recipe
- `gut link` — Link recipe to GitHub issue
- `gut metrics` — Track recipe velocity (time from draft to served)
