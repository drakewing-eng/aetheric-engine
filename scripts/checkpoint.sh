#!/bin/zsh
# Save current work to GitHub (private backup).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
MSG="${1:-checkpoint: $(date +%Y-%m-%d %H:%M)}"
git add -A
if git diff --cached --quiet; then
  echo "Nothing new to commit."
else
  git commit -m "$MSG"
fi
git push -u origin HEAD
echo "Pushed to: $(git remote get-url origin)"
git log -1 --oneline
