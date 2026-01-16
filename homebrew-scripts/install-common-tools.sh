#!/bin/bash

# Safe Homebrew install script for common development tools
# Installs frequently used packages for development

set -euo pipefail

echo "Installing common development tools via Homebrew..."

# Version control, languages, runtimes, and tools
brew install \
    git \
    python@3.12 \
    node \
    rust \
    go \
    yarn \
    jq \
    tree \
    wget

echo "Common development tools installed successfully."
echo "Note: Python is installed as python@3.12. Use 'python3' to run it."
