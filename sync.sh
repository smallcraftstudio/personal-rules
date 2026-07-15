#!/bin/bash
# Sync personal-rules/GLOBAL.md into every Claude context file on this machine.
# Idempotent — safe to re-run after editing GLOBAL.md.
#
# After running, commit and push any repos whose CLAUDE.md changed so that
# web/mobile Claude (claude.ai/code) sees the update.

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_FILE="$REPO_DIR/GLOBAL.md"
GITHUB_DIR="/c/Users/jrandall/Documents/GitHub"
CLAUDE_DIR="/c/Users/jrandall/.claude"

if [ ! -f "$GLOBAL_FILE" ]; then
  echo "ERROR: $GLOBAL_FILE not found"
  exit 1
fi

BEGIN="<!-- BEGIN PERSONAL GLOBAL RULES (synced from personal-rules/GLOBAL.md) -->"
END="<!-- END PERSONAL GLOBAL RULES -->"

# All known target CLAUDE.md files. Add new ones here as needed.
TARGETS=(
  "$CLAUDE_DIR/CLAUDE.md"
  "$GITHUB_DIR/project-template/CLAUDE.md"
  "$GITHUB_DIR/j-testing/CLAUDE.md"
  "$GITHUB_DIR/j-rpi-pico-experiments/CLAUDE.md"
  "$GITHUB_DIR/jared solidworks experiments/CLAUDE.md"
  "$GITHUB_DIR/j-halo/CLAUDE.md"
)

# Use Python for the multi-line marker-aware replacement (more reliable than sed)
# On Windows, prefer `python` over `python3` because `python3` is often a
# Microsoft Store stub that just opens the Store. `python` and `py` are real.
PYTHON=""
for cand in python py python3; do
  if command -v "$cand" >/dev/null 2>&1; then
    if "$cand" --version >/dev/null 2>&1; then
      PYTHON="$cand"
      break
    fi
  fi
done
if [ -z "$PYTHON" ]; then
  echo "ERROR: no working Python interpreter found"
  exit 1
fi
"$PYTHON" - "$GLOBAL_FILE" "$BEGIN" "$END" "${TARGETS[@]}" <<'PYEOF'
import re, sys, os

global_file = sys.argv[1]
begin = sys.argv[2]
end = sys.argv[3]
targets = sys.argv[4:]

with open(global_file, 'r', encoding='utf-8') as f:
    global_content = f.read().rstrip() + "\n"

block = f"{begin}\n{global_content}{end}"

for target in targets:
    if not os.path.isfile(target):
        print(f"  SKIP (not found): {target}")
        continue

    with open(target, 'r', encoding='utf-8') as f:
        content = f.read()

    if begin in content and end in content:
        # Replace existing block
        pattern = re.escape(begin) + r'.*?' + re.escape(end)
        new_content = re.sub(pattern, lambda m: block, content, count=1, flags=re.DOTALL)
        action = "UPDATED"
    else:
        # Append fresh block at end
        if not content.endswith("\n"):
            content += "\n"
        new_content = content + "\n---\n\n" + block + "\n"
        action = "ADDED  "

    if new_content != content:
        with open(target, 'w', encoding='utf-8', newline='\n') as f:
            f.write(new_content)
        print(f"  {action}: {target}")
    else:
        print(f"  no-op : {target}")

print()
print("Done. Don't forget to commit + push the affected repos so web/mobile Claude sees it.")
PYEOF
