#!/usr/bin/env bash
set -Eeuo pipefail

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required; enable INSTALL_NODE in configs/tools.conf." >&2
  exit 1
fi

npm install -g @openai/codex@latest --include=optional
