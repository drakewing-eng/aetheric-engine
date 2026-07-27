#!/bin/zsh
# Launch Aetheric Engine (use this if the path with a space fails)
set -euo pipefail
cd "$(dirname "$0")"
exec ./run-game.sh
