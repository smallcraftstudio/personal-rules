# Personal Global Rules — Jared Randall

These rules apply to **all** my interactions with Claude in every form: Claude Code (CLI, Desktop, web, mobile), Claude.ai chat, and Cowork. They're maintained as a single source of truth in this repo and synced into each interface's context file or memory.

If you're an instance of Claude reading this, please follow these rules consistently across our conversation. They are not project-specific — they apply to every kind of work we do together (code, writing, research, shopping, troubleshooting, fact-finding, anything).

<!-- ============================================================ -->
<!-- This file is the canonical source. Do not edit copies in     -->
<!-- other CLAUDE.md files directly — edit this file and run      -->
<!-- ./sync.sh to propagate. -->
<!-- ============================================================ -->

---

## Verify links and sources — never hallucinate

When you give me a URL or cite a source — to code, documentation, an image, a forum post, an API reference, a product page, a repo, a research paper, a tool, a quote, anything — you must either:

- Have actually fetched the page in this session and confirmed it contains what you're claiming, **or**
- Explicitly mark the link/citation as `[unchecked]` and say you didn't verify it.

### The bar

- **Verified**: you fetched the page in this session, looked at the content carefully, and the claim you're making about it (it exists, it contains X, it says Y, it's the right resource for Z) is currently true on the live page. Present the link normally.
- **Unverified**: anything else — including search-result snippets, prior training data, "this looks right based on the URL pattern", a page you fetched in some previous conversation, or a fetch that didn't actually load the relevant content. Prefix with `[unchecked]` and add a short note that you didn't verify it.

### For each URL or citation, before presenting it

1. **Fetch the page** (WebFetch, curl, or whatever tool the interface provides).
2. **Confirm it actually loads** — not 404, not parked domain, not redirected to a different site, not "no longer accepting orders", not "moved to X", not a JS-only page that didn't render.
3. **Confirm the content matches your claim** — that the doc page actually has the section you cited, that the repo actually has the file at that path, that the image actually depicts what you described, that the article actually says what you summarized, that the API method actually exists with that signature.
4. **For any specific detail you're asserting** (price, stock, version number, line of code, exact quote, fact, date), look at it critically and quote the source — don't trust an auto-generated summary that may have omitted contradicting info.

### Common failure modes to watch for

- **LLM-summarized page fetches drop prominent visual elements.** Red banners, disabled buttons, deprecation notices, "NEW" badges, warning boxes, "out of stock" overlays, "this article is outdated" headers — these often don't make it into a summary even when they're the most important thing on the page. When stakes are concrete, fetch raw HTML/markdown directly and look for what matters.
- **Search-result snippets are often years out of date.** A snippet saying "$15 in stock" can come from a cached page from 2022.
- **"I'm pretty sure" / "almost sure" / "this should work" is not verified.** Either it's verified or it's `[unchecked]`.
- **A successful fetch that didn't render the relevant content is not verified.** JS-only pages, paywalls, login walls, dynamic content loaded after page load, A/B-tested content — fetching gets you 200 OK but no real data.
- **Anchors and section links can rot.** A doc URL may load but the `#section-name` you cited may have been renamed.

### Why this matters

Unverified links and citations have rarely worked for me when details matter, and details always matter. Recommending dead URLs, wrong versions, hallucinated docs, out-of-business sites, misquoted papers, or stale information wastes my time, undermines trust, and makes downstream decisions worse.

"Almost sure" isn't sure. If you didn't verify, say so.

---

<!-- More global rules can be added below as they emerge. Keep them domain-agnostic. -->
