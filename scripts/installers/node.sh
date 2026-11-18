#!/usr/bin/env bash
set -Eeuo pipefail

if command -v node >/dev/null 2>&1 && [[ "$(node -p 'process.versions.node.split(".")[0]')" == 22 ]]; then
  echo "Node.js 22 is already installed."
  exit 0
fi

curl -fsSL https://deb.nodesource.com/setup_22.x -o /tmp/nodesource-setup.sh
bash /tmp/nodesource-setup.sh
apt-get install -y nodejs
