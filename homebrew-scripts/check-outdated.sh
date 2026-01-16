#!/bin/bash

# Safe Homebrew check script
# Lists outdated packages

set -euo pipefail

echo "Checking for outdated Homebrew packages..."
brew outdated

echo "Check completed. Run update-brew.sh to upgrade."
