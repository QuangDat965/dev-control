#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLERS_DIR="$SCRIPT_DIR/installers"

if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root" >&2
  exit 1
fi

echo "=== Installing shared prerequisites ==="
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y ca-certificates curl git gnupg jq unzip openssh-client

if (($# == 0)); then
  echo "No tools enabled in configs/tools.conf."
  exit 0
fi

for tool in "$@"; do
  case "$tool" in
    node|codex|opencode|dotnet|github|docker) ;;
    *) echo "Unknown tool: $tool" >&2; exit 1 ;;
  esac

  installer="$INSTALLERS_DIR/$tool.sh"
  if [[ ! -x "$installer" ]]; then
    echo "Missing or non-executable installer: $installer" >&2
    exit 1
  fi

  echo "=== Installing $tool ==="
  "$installer"
done

echo "=== Verifying installed tools ==="
for tool in "$@"; do
  case "$tool" in
    node) node --version; npm --version ;;
    codex) codex --version ;;
    opencode) opencode --version ;;
    dotnet) dotnet --version ;;
    github) gh --version | head -1 ;;
    docker) docker --version; docker compose version ;;
  esac
done

echo "=== Installation completed ==="
