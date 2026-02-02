#!/bin/bash

# Sapling SCM installation script for macOS
set -euo pipefail

echo "Installing Sapling SCM..."

# Install via Homebrew
if command -v brew >/dev/null 2>&1; then
    brew install sapling
else
    echo "Error: Homebrew not found. Install Homebrew first."
    exit 1
fi

# Configure Sapling identity (matches existing Git config)
GIT_NAME=$(git config --global user.name 2>/dev/null || echo "")
GIT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")

if [[ -n "$GIT_NAME" && -n "$GIT_EMAIL" ]]; then
    echo "Configuring Sapling with Git identity: $GIT_NAME <$GIT_EMAIL>"
    sl config --user ui.username "$GIT_NAME <$GIT_EMAIL>"
else
    echo "Warning: No Git identity found. Configure manually with:"
    echo "sl config --user ui.username 'Your Name <email@example.com>'"
fi

echo "Sapling installation complete!"
echo "Usage:"
echo "  sl clone <repo>     # Clone repository"
echo "  sl commit -m 'msg'  # Create commit"
echo "  sl web              # Launch web UI"
echo "  sl ssl              # Show smartlog with PR status"
