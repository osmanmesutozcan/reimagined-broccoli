---
name: committing-code
description: >-
  Use when creating a git commit from current repository changes, especially
  when commit scope, message format, or push boundaries need explicit control
---

# Create a Git Commit

## Overview

Create exactly the requested commit from reviewed changes. Inspect the
working tree, stage only intended files, then use the helper script below.

## Commit format

Subject:

`<type>(<scope>): <summary>`

- `type` is required; use `feat`, `fix`, `docs`, `refactor`, `chore`,
  `test`, or `perf` as appropriate.
- `scope` is optional and should be a short affected-area noun.
- `summary` is imperative, concise, has no trailing period, and is at
  most 50 characters including type and scope.
- Put exactly one blank line between the subject and body.

Body:

- Required; prefer 2-5 concise bullets.
- Start bullets with `- ` and describe concrete changes, outcomes,
  validation, or follow-up notes.
- Mention affected files, packages, or areas when useful.
- Avoid repeating the subject. Keep body lines at most 72 characters;
  the helper also wraps them.

## Commit helper

Run this from the repository root after staging the intended files:

```sh
bash ./_base/skills/commit/commit-staged.sh \
  "fix(ui): keep modal open" \
  $'- Keep the modal visible while save is pending.\n- Preserve dialog state.'
```

The helper:

- Requires exactly two arguments: `title` and `description`.
- Rejects empty or multi-line titles, titles over 50 characters, and
  empty descriptions.
- Wraps descriptions at 72 characters while preserving supplied
  paragraph and bullet line breaks.
- Commits staged changes only and refuses to run with nothing staged.
- Uses `git commit --file` to preserve message contents safely.

Do not call `git commit` directly; use the helper.

## Safety boundaries

- Review `git status`, `git diff`, and `git diff --cached` before
  committing.
- If the prompt names files or globs, stage only those paths.
- If unrelated or ambiguous files are present, stop and use the
  `ask_user_question` tool before staging them.
- If no paths are specified, stage reviewed current changes only; never
  blindly stage everything with `git add .`.
- This skill authorizes the requested commit only. Do not push or perform
  an unrequested amend, reset, or additional commit.
- Keep the message to a subject and body. Add breaking-change metadata,
  footers, or sign-offs only when repository or user instructions require
  them.

Caller-provided paths limit the commit scope. Freeform instructions
influence the subject and body. When both are provided, honor both.

## Rationalizations to reject

| Excuse | Reality |
|--------|---------|
| “`git commit -m` is faster.” | The helper enforces format and safe body handling. |
| “`git add .` is easiest.” | It can include unrelated or sensitive files. |
| “I can push while I am here.” | The request authorizes a commit, not publishing. |
| “The staged diff is probably fine.” | Review it before creating an irreversible commit. |

## Red flags: STOP

- About to run `git commit` directly instead of the helper.
- About to use a hard-coded path from another checkout.
- Staged files have not been reviewed or exceed the requested scope.
- The commit has no body, a multi-line subject, or an overlong subject.
- About to push or perform an unrequested amend, reset, or extra commit.

Correct the red flag before continuing.

## Steps

1. Infer requested paths, scope, and any additional commit guidance.
2. Review `git status` and `git diff`; inspect `git diff --cached` if
   changes are already staged.
3. Ask for clarification if file inclusion or scope is ambiguous.
4. Draft and validate the subject and body from the reviewed diff.
5. Stage only the intended files.
6. Review `git diff --cached` and run `git diff --cached --check`.
7. Run `bash ./_base/skills/commit/commit-staged.sh "<subject>" "<body>"`.
8. Verify `git status --short` and `git log -1 --format='%h %s'`.
