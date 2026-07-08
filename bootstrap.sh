#!/usr/bin/env bash
set -euo pipefail

# Top-level bootstrap dispatcher
# - Quiet by default; pass --verbose or -v to see actions
# - Exits silently on non-Darwin hosts
ARGS=()

for arg in "$@"; do
  case "$arg" in
    -v|--verbose) ARGS+=("$arg") ;;
    -q|--quiet) ARGS+=("$arg") ;;
    -h|--help) ARGS+=("$arg") ;;
    *) ARGS+=("$arg") ;;
  esac
done

OS="$(uname -s)"
if [[ "$OS" != "Darwin" ]]; then
  # Silent exit on non-macOS
  exit 0
fi

# Call the Darwin profile installer (keeps quiet-by-default behavior)
exec bash profile/darwin/install.sh "${ARGS[@]}"
