# Homebrew Scripts

Opinionated but safe Homebrew automation scripts for macOS.

These scripts wrap common Homebrew operations into repeatable,
readable shell commands.

## Included scripts

| Script | Purpose |
|------|--------|
| update-brew.sh | Update Homebrew and upgrade all packages |
| check-outdated.sh | Show outdated formulae |
| cleanup-brew.sh | Remove old versions and unused deps |
| install-common-tools.sh | Install common dev tools |
| install-languages.sh | Install additional languages |
| install-utilities.sh | Install CLI utilities |
| minimal-install.sh | Minimal example (Git only) |

## Running

```bash
chmod +x *.sh
./update-brew.sh
```

Homebrew must be installed beforehand.
