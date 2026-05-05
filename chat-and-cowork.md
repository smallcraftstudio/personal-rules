# Paste-ready text for Claude.ai chat and Cowork

The contents of `GLOBAL.md` work as-is for Claude.ai chat (Personalization) and Cowork (memory). Just open `GLOBAL.md`, copy everything from the first heading down, and paste into the relevant settings UI.

## Where to paste

### Claude.ai chat
Settings → Personalization → "What personal preferences should Claude consider in responses?"
Paste the `GLOBAL.md` contents.

### Cowork
Open Cowork's memory / preferences UI (varies by version) and add a new memory entry with the `GLOBAL.md` contents.

## When to update

Whenever `GLOBAL.md` changes:
1. Run `./sync.sh` to update Claude Code interfaces.
2. Re-paste `GLOBAL.md` contents into Claude.ai Personalization.
3. Re-paste `GLOBAL.md` contents into Cowork memory.

(Yes, this is manual for chat and Cowork. Those interfaces can't fetch from GitHub on their own, so a one-time paste per update is unavoidable until they support that.)
