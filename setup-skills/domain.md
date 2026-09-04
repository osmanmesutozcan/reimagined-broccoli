# Domain Docs

**Configured layout:** `{{DOMAIN_LAYOUT}}`

Replace `{{DOMAIN_LAYOUT}}` with `single-context` or `multi-context` when rendering this file into a repository. No placeholder may remain in the generated document.

## Before exploring

Read the domain documentation relevant to the work:

- In a single-context repository, read root `CONTEXT.md` when it exists.
- In a multi-context repository, read root `CONTEXT-MAP.md`, then each linked `CONTEXT.md` relevant to the request.
- Read ADRs under root `docs/adr/` that affect the work.
- In a multi-context repository, also inspect context-scoped ADR directories identified by `CONTEXT-MAP.md`.

If these files do not exist, proceed silently. The domain-modeling skill creates them lazily when terminology or a durable architectural decision is actually resolved.

## Layouts

Single-context:

```text
/
├── CONTEXT.md
├── docs/
│   └── adr/
└── src/
```

Multi-context:

```text
/
├── CONTEXT-MAP.md
├── docs/
│   └── adr/
└── <context paths>/
    ├── CONTEXT.md
    └── docs/
        └── adr/
```

`CONTEXT-MAP.md` is authoritative for context paths. Do not assume contexts live under `src/` or that package boundaries always equal domain boundaries.

## Use the glossary vocabulary

Use terms exactly as defined in the relevant `CONTEXT.md` in ticket titles, plans, tests, interfaces, and explanations. Do not drift to synonyms the glossary rejects.

When a required concept is absent, reconsider whether the project already uses another term. If the gap is real, invoke the domain-modeling skill and resolve the term before adding it.

## Respect architectural decisions

Surface any conflict with an existing ADR explicitly. Do not silently override the decision. Create a new ADR only through the domain-modeling workflow when the choice is hard to reverse, surprising without context, and based on a real trade-off.
