---
name: setup-skills
description: "Configure a repository for the standard skills baseline: AGENTS.md rules, Backlog.md, canonical triage labels, domain docs, and tool-readiness checks. Run once before first use of the other skills."
disable-model-invocation: true
---

# Setup Skills

Configure the repository conventions that the other skills assume. This is a prompt-driven setup workflow: inspect first, show the exact proposal, wait for approval, apply it, and verify the result. A rerun must update the existing setup without duplicating sections or discarding user instructions.

## Fixed defaults

Do not ask the user to choose these:

- Agent instructions live in root `AGENTS.md`. Leave `CLAUDE.md` untouched.
- Backlog.md is the issue tracker. Use the `backlog` CLI for all tracker operations.
- Triage uses the canonical labels in [triage-labels.md](./triage-labels.md).
- Domain docs use single-context layout unless existing files or clear monorepo evidence establish multiple contexts.
- Missing tools are reported, never installed or upgraded by this skill.

## 1. Explore

Inspect the repository without changing it.

### Project shape

- Read root `AGENTS.md`, if present, including existing `## Rules` and `## Agent skills` sections.
- Read `docs/agents/`, `CONTEXT.md`, `CONTEXT-MAP.md`, and relevant `docs/adr/` directories.
- Inspect manifests, lockfiles, workspace configuration, source directories, and platform configuration to identify the stack, package manager, and target platforms.
- Detect Shopify from evidence such as `shopify.app*.toml`, Shopify dependencies, and extension directories. Distinguish an embedded Admin app from a theme or unrelated Shopify integration.
- Preserve unrelated working-tree changes and existing instructions.

### Backlog.md

- Check whether `backlog` is available.
- If it is available, run `backlog instructions overview` to determine whether the repository is initialized and to read the installed CLI's current workflow.
- Treat the CLI output and `backlog <command> --help` as the source of truth. Do not infer current syntax from memory.
- If Backlog.md is not initialized, plan to run `backlog init --defaults --agent-instructions none` after approval.

### Domain layout

Use an existing layout when one is already established:

- `CONTEXT-MAP.md` means multi-context.
- Root `CONTEXT.md` without a map means single-context.

Otherwise, select multi-context only when the repository has clear monorepo evidence, such as workspace configuration plus multiple packages with their own source trees. Ambiguous repositories are single-context. Record the selection, but do not create empty `CONTEXT.md`, `CONTEXT-MAP.md`, or ADR files; the domain-modeling skill creates them when there is real content.

### Tool readiness

Check, at minimum:

- `backlog`
- `dprint`

For detected Shopify projects, also check tools required by the proposed validation rules, including `pnpm`, `cargo`, and `shopify` where applicable. Inspect project scripts before claiming a validation command exists.

Report each missing executable or script and why it is needed. Do not run package-manager, installer, or upgrade commands.

## 2. Build the proposal

Show one grouped proposal containing all of the following.

### AGENTS.md merge

`AGENTS.md` must begin with this section:

```markdown
## Rules

- Format code with `dprint fmt`.
- Leave development servers under user control. Do not start, stop, or restart one; ask the user when a restart is required.
```

When an embedded Shopify Admin app is detected, add:

```markdown
- For embedded Shopify Admin UI, prefer Polaris web components over custom HTML or CSS.
```

When a Shopify app is detected, add:

```markdown
- Default to `pnpm typecheck` for validation. When Shopify Function code changes or the user requests it, also run the Functions query validator, `cargo fmt --check`, `cargo check`, `shopify app function build --no-color`, and extension tests.
```

Merge these rules with existing rules rather than replacing them. If `## Rules` exists elsewhere, move the complete merged section to the beginning. Do not duplicate equivalent rules.

Create or update these subsections under `## Agent skills` while preserving unrelated subsections:

```markdown
## Agent skills

### Issue tracker

Issues, specs, and implementation work are tracked with Backlog.md. See `docs/agents/issue-tracker.md`.

### Triage labels

Use the canonical triage labels. See `docs/agents/triage-labels.md`.

### Domain docs

This repository uses a <single-context|multi-context> domain layout. See `docs/agents/domain.md`.
```

Replace the domain-layout placeholder in the proposal with the selected layout.

### Generated docs

Show the exact proposed contents of:

- `docs/agents/issue-tracker.md`, based on [issue-tracker-backlog.md](./issue-tracker-backlog.md)
- `docs/agents/triage-labels.md`, based on [triage-labels.md](./triage-labels.md)
- `docs/agents/domain.md`, rendered from [domain.md](./domain.md) with the selected layout

If these files already exist, show the exact merge. Preserve relevant repository-specific additions and surface conflicts instead of silently overwriting them.

### Planned action and readiness gaps

- Show `backlog init --defaults --agent-instructions none` when initialization is needed and the executable is available.
- List missing tools separately. Missing tools are not approval requests to install them.

## 3. Approval gate

Ask for one grouped approval of the complete proposal. Do not create files, edit instructions, initialize Backlog.md, or install anything before the user explicitly approves it.

If the user changes the proposal, revise the affected drafts and ask again. Approval applies only to the drafts and command shown.

## 4. Apply

After approval:

1. If planned, run `backlog init --defaults --agent-instructions none`. Stop and report the command output if initialization fails.
2. Create `docs/agents/` when needed and write the approved tracker, triage, and domain docs.
3. Create or merge root `AGENTS.md` exactly as approved. Keep `## Rules` first and preserve unrelated instructions.
4. Do not edit `CLAUDE.md`.
5. Do not install missing tools.

When setup-owned headings already exist, update them in place. Never append duplicate `## Rules`, `## Agent skills`, or `docs/agents/` content merely because the wording differs.

## 5. Verify

Setup is complete only after checking all applicable conditions:

- The first heading in `AGENTS.md` is `## Rules`.
- The baseline rules appear exactly once; applicable Shopify rules appear exactly once.
- `## Agent skills` points to all three readable files under `docs/agents/`.
- No unresolved template placeholders remain.
- When `backlog` is available, `backlog instructions overview` confirms initialization.
- The recorded domain layout matches the detected repository shape.
- Existing unrelated instructions and files remain intact.

Report:

- Files created and updated
- Whether Backlog.md was initialized or already present
- The selected domain layout
- Shopify-specific rules added, if any
- Missing tools or scripts the user still needs to handle

If `backlog` is missing or initialization failed, describe the repository as partially configured rather than complete.
