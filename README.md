# EmpathyLabs Super-Repo

## Purpose

Super-repo for EmpathyLabs projects: ACDC, LilScrappy, Unigami, PrinciplesOS, LifeOS.

## Structure

- `ACDC/` — Continuous Learning Experiment & JackAss Award Tracking
- `LilScrappy/` — Lightweight scraping toolkit
- `Unigami/` — Unified gaming platform
- `PrinciplesOS/` — Operating principles and governance framework
- `LifeOS/` — Life management system

## Workspace

This repo uses **pnpm workspaces** for shared scripts and dependency efficiency.

```bash
# Install all dependencies across workspaces
pnpm install

# Run shared scripts
pnpm run lint
pnpm run format
pnpm run typecheck
```

## Hybrid Repo Model

We use a phased evaluation model for external tools:

### Phase 1: Evaluation (Subtree)
- Add external repo as a subtree to test and adjust locally.
- Remote stays external; we can pull updates.

### Phase 2: Internship (Subtree with adjustments)
- Continue using subtree; we may make local modifications.
- Sync upstream periodically via `git subtree pull`.

### Phase 3: Full-time (Submodule)
- Convert subtree to submodule to pin to a specific commit.
- Project becomes its own “baby” with its own remote.

#### Migration: Subtree → Submodule
```bash
# Remove subtree folder from index
git rm -r <folder>
git commit -m "remove <folder> subtree"

# Add as submodule
git submodule add <remote-url> <folder>
git commit -m "add <folder> as submodule"
```

## Onboarding

- Clone with `git clone https://github.com/mawazawa/empathy-labs.git && cd empathy-labs`
- Run `pnpm install` to bootstrap workspace dependencies.
- Each project folder contains its own README and development instructions.

## Notes

- JusticeOS lives in its own repo (https://github.com/mawazawa/JusticeOS) and is **not** included here to avoid dual-source-of-truth and secret-scanning issues.
- Submodule usage is reserved for third-party libs we want pinned; internal projects use subtree until they graduate to submodule.
