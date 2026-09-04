# Triage Labels

The skills use six canonical triage roles. Backlog.md stores them as task labels with the same names.

| Canonical role | Backlog label | Meaning |
| --- | --- | --- |
| `needs-triage` | `needs-triage` | A maintainer needs to evaluate the task |
| `needs-human` | `needs-human` | Human review or approval is required |
| `needs-info` | `needs-info` | More information is required before work can continue |
| `ready-for-agent` | `ready-for-agent` | The task is fully specified and ready for an agent |
| `ready-for-human` | `ready-for-human` | Human implementation is required |
| `wontfix` | `wontfix` | The task will not be actioned |

When a skill names a canonical role, apply the matching Backlog label. Add or remove labels through `backlog task edit`; do not edit task files directly.
