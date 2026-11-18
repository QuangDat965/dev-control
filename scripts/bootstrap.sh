#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$(cd "$SCRIPT_DIR/.." && pwd)/configs/tools.conf"

echo "=== Starting VPS bootstrap ==="

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Missing configuration: $CONFIG_FILE" >&2
  exit 1
fi

# This file is maintained alongside the deployment scripts and uses shell assignments.
# shellcheck disable=SC1090
source "$CONFIG_FILE"

TOOLS=()
add_tool() {
  local key="$1" tool="$2" value
  value="${!key-}"
  case "$value" in
    true) TOOLS+=("$tool") ;;
    false) ;;
    *) echo "$key must be true or false (got: ${value:-unset})" >&2; exit 1 ;;
  esac
}

add_tool INSTALL_NODE node
add_tool INSTALL_CODEX codex
add_tool INSTALL_OPENCODE opencode
add_tool INSTALL_DOTNET dotnet
add_tool INSTALL_GITHUB github
add_tool INSTALL_DOCKER docker

bash "$SCRIPT_DIR/install-tools.sh" "${TOOLS[@]}"

echo "=== Bootstrap completed ==="
