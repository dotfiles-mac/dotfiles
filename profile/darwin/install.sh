#!/usr/bin/env bash
set -euo pipefail

# profile/darwin/install.sh
# Lightweight macOS (Darwin) bootstrap script.
# - Exits silently on non-Darwin platforms
# - Quiet by default; pass --verbose to see actions

QUIET=true

usage(){
  cat <<EOF
Usage: $0 [--quiet|--verbose|--help]

By default this script is quiet (no output) and exits on non-macOS hosts.
Use --verbose to show progress and actions.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -v|--verbose) QUIET=false; shift ;;
    -q|--quiet) QUIET=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 2 ;;
  esac
done

# Only run on macOS
OS="$(uname -s)"
if [[ "$OS" != "Darwin" ]]; then
  # silent exit on non-Darwin hosts
  exit 0
fi

log(){
  if [[ "$QUIET" == false ]]; then
    printf "%s\n" "$*"
  fi
}

log "Starting Darwin bootstrap..."

# Example: ensure Homebrew is installed (kept quiet unless --verbose)
if ! command -v brew >/dev/null 2>&1; then
  log "Homebrew not found. Installing..."
  if [[ "$QUIET" == true ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null 2>&1 || true
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || true
  fi
else
  log "Homebrew already installed"
fi

# If a Brewfile exists next to profile, try to bundle-install it
BREWFILE_PATH="$(dirname "${BASH_SOURCE[0]}")/../Brewfile"
if [[ -f "$BREWFILE_PATH" ]]; then
  log "Installing Brewfile: $BREWFILE_PATH"
  if [[ "$QUIET" == true ]]; then
    brew bundle --file="$BREWFILE_PATH" >/dev/null 2>&1 || true
  else
    brew bundle --file="$BREWFILE_PATH" || true
  fi
else
  log "No Brewfile found at $BREWFILE_PATH"
fi

log "Darwin bootstrap finished."
