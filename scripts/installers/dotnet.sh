#!/usr/bin/env bash
set -Eeuo pipefail

if command -v dotnet >/dev/null 2>&1 && dotnet --list-sdks 2>/dev/null | grep -q '^8\.'; then
  echo ".NET 8 SDK is already installed."
  exit 0
fi

mkdir -p /usr/share/dotnet
curl -fsSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
bash /tmp/dotnet-install.sh --channel 8.0 --install-dir /usr/share/dotnet
ln -sfn /usr/share/dotnet/dotnet /usr/local/bin/dotnet
