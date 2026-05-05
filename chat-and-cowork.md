# Paste-ready text for Claude.ai chat and Cowork

These interfaces don't auto-fetch from GitHub on session start, but they may
honor a "fetch this URL first" instruction. We bet on that approach so we
don't have to re-paste the whole rules file every time `GLOBAL.md` changes.

## What to paste

Paste the block below into:
- **Claude.ai chat**: click your initials (lower-left corner) → **Settings** → field labeled **"Instructions for Claude"**.
  Verified against [Anthropic's help center](https://support.claude.com/en/articles/10185728-understanding-claude-s-personalization-features).
- **Cowork**: memory entry / preferences UI (exact path not verified — varies by Cowork version).

```
Personal global rules — Jared Randall

At the start of every conversation with me, please fetch and follow
the rules at:

  https://raw.githubusercontent.com/smallcraftstudio/personal-rules/main/GLOBAL.md

That URL is the canonical source of my personal global rules and may
have been updated since this instruction was last pasted. Apply
whatever rules are currently in it.

If you cannot fetch URLs in this interface, default behavior:
never present a URL or citation to me as verified unless you actually
fetched the page in this session and confirmed it contains what
you're claiming. Otherwise, mark it as [unchecked] and say you
didn't verify it.
```

## Why this approach

- The rules in `GLOBAL.md` change occasionally. Pasting the rules themselves means re-pasting on every change. Pasting a "fetch this URL" instruction means the rules update automatically (assuming the model fetches the URL).
- Claude.ai chat with web access **should** be able to fetch the raw GitHub URL on each conversation start. It's a public file, no auth needed.
- Cowork's web-fetch capabilities vary; if it can't fetch, it falls back to the inline rule about marking `[unchecked]`.
- If a model ignores the fetch instruction, that's a product problem — bug report territory rather than a workflow problem.

## When you change the rules

Just edit `GLOBAL.md`, run `./sync.sh`, commit + push. **No re-paste needed for chat/Cowork** — they'll pick up the change next conversation (provided they actually honor the fetch instruction).
