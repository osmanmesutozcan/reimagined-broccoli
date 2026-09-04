# Issue Tracker: Backlog.md

Issues, specs, and implementation work for this repository live in Backlog.md. Use the `backlog` CLI for every read and write; do not edit Backlog task, draft, document, decision, or milestone files directly.

## Read the installed workflow

Backlog.md's own instructions are the source of truth for the installed version.

- Start tracked work with `backlog instructions overview`.
- Before creating work, read `backlog instructions task-creation`.
- Before planning or implementing a task, read `backlog instructions task-execution`.
- Before completing a task, read `backlog instructions task-finalization`.
- Run `backlog <command> --help` before an unfamiliar operation.

Use `--plain` for agent-readable output and `--json` for programmatic reads. Do not combine them.

## Vocabulary

- An **issue** or **ticket** means a Backlog task.
- A **spec** or **design ticket** is a parent Backlog task titled `DESIGN: <topic>`.
- **Implementation tickets** are child tasks of their design task.
- **Blocking relationships** are Backlog task dependencies.
- Triage roles are labels, not task statuses. Use the mappings in `triage-labels.md`.
- Task statuses come from the repository's Backlog configuration. Inspect CLI help rather than assuming custom status names.

## Core operations

Search before creating work:

```bash
backlog search "<query>" --plain
backlog task list --search "<query>" --limit 20 --plain
backlog task view <task-id> --plain
```

Create a task with durable intent and testable acceptance criteria:

```bash
backlog task create "<title>" \
  --description "<outcome and context>" \
  --ac "<testable criterion>"
```

Create an implementation task under a design task, with blockers when required:

```bash
backlog task create "<title>" \
  --parent <design-task-id> \
  --depends-on <blocking-task-id> \
  --labels ready-for-agent \
  --ac "<testable criterion>"
```

Read the relevant Backlog instruction guide before changing status, claiming work, recording a plan, checking acceptance criteria, or finalizing a task.

## Publishing to the issue tracker

When a skill says to publish a design or spec:

1. Read `backlog instructions task-creation`.
2. Create a parent task titled `DESIGN: <topic>` containing the approved design and its acceptance criteria.
3. Apply `needs-human` while human review is required.
4. After approval, replace that label with `ready-for-agent` as directed by the originating skill.
5. Report the created task ID.

When a skill says to publish implementation tickets:

1. Create each ticket as a child of the design task with `--parent`.
2. Encode ordering constraints with `--depends-on`; do not use dependencies merely to express preferred order.
3. Apply `ready-for-agent` only when the ticket is fully specified and unblocked by human input.
4. Use Backlog's task ordinal when explicit sibling ordering is needed.
5. Report every created task ID and title.

When a skill says to fetch a ticket, run:

```bash
backlog task view <task-id> --plain
```

Backlog.md is file-backed. Include its CLI-generated changes in the relevant commit when the workflow calls for committing local tracker artifacts.
