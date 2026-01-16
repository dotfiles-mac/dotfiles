#!/bin/bash

# Safe Homebrew check script
# Lists outdated packages

set -e

echo "Checking for outdated Homebrew packages..."
brew outdated

echo "Check completed. Run update-brew.sh to upgrade."
