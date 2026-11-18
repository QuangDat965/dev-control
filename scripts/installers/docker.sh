#!/usr/bin/env bash
set -Eeuo pipefail

if command -v docker >/dev/null 2>&1; then
  echo "Docker is already installed."
  exit 0
fi

curl -fsSL https://get.docker.com -o /tmp/install-docker.sh
sh /tmp/install-docker.sh
