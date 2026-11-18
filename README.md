# dev-control

Bootstrap a fresh Ubuntu VPS over SSH and choose which development tools to install.

## Layout

```text
dev-control/
├── configs/tools.conf
├── scripts/
│   ├── dev-init
│   ├── bootstrap.sh
│   ├── install-tools.sh
│   └── installers/
│       ├── node.sh
│       ├── codex.sh
│       ├── opencode.sh
│       ├── dotnet.sh
│       ├── github.sh
│       └── docker.sh
└── compose/
```

## Usage

Edit `configs/tools.conf` and set each `INSTALL_*` value to `true` or `false`. The default installs Node.js 22, Codex CLI, OpenCode, .NET 8 SDK, GitHub CLI, and Docker.

Run from the machine that can SSH into the target VPS:

```bash
./scripts/dev-init root@YOUR_VPS_IP SSH_PORT
```

The script copies `configs/` and `scripts/` to `/root/dev-bootstrap` on the target and runs `bootstrap.sh`. SSH authentication happens once per run. The target needs Ubuntu with `apt`, root SSH access, and an Internet connection. Subsequent runs reuse installed tools where supported; Codex and OpenCode are updated to their latest npm releases.

To run locally on a target after copying the project:

```bash
sudo bash scripts/bootstrap.sh
```

`compose/` is reserved for future deployment files.
