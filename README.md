# personal-rules

Single source of truth for personal global rules that apply to every Claude interaction across every interface.

## What's here

- **`GLOBAL.md`** — the canonical rules. Edit this file when adding/changing a rule.
- **`sync.sh`** — propagates `GLOBAL.md` into every Claude context file on this machine (global CLAUDE.md, each project's CLAUDE.md, etc.).
- **`chat-and-cowork.md`** — the same rules formatted as a paste-ready block for Claude.ai chat (Personalization) and Cowork (memory). Update by re-pasting the contents whenever `GLOBAL.md` changes.

## How the sync works

The Claude Code interfaces (CLI, Desktop, web at claude.ai/code, mobile) read context from `CLAUDE.md` files — either `~/.claude/CLAUDE.md` (global) or each project's `CLAUDE.md` (per-repo).

`sync.sh` embeds the contents of `GLOBAL.md` into each of those files, wrapped in marker comments:

```
<!-- BEGIN PERSONAL GLOBAL RULES (synced from personal-rules/GLOBAL.md) -->
... contents of GLOBAL.md ...
<!-- END PERSONAL GLOBAL RULES -->
```

The script is idempotent: re-running it after editing `GLOBAL.md` updates every embedded copy in place.

For Claude.ai chat and Cowork, paste a **fetch-first instruction** (see `chat-and-cowork.md`) into their settings/memory UI. Those interfaces should then fetch the canonical raw URL each conversation, picking up changes automatically without needing a re-paste. This is the bet — if a particular interface doesn't honor "fetch X first" instructions, that's something for the product team to fix; the rules still apply via the inline fallback in the pasted instruction.

The canonical raw URL Claude.ai and Cowork should fetch:

```
https://raw.githubusercontent.com/smallcraftstudio/personal-rules/main/GLOBAL.md
```

## Workflow when adding/changing a rule

1. Edit `GLOBAL.md`.
2. Run `./sync.sh` (updates the global CLAUDE.md and every project CLAUDE.md on this machine).
3. Commit and push this repo and any project repos that got updated.
4. Done. Claude.ai chat and Cowork will pick up the change on the next conversation via the fetch instruction — no re-paste needed.
