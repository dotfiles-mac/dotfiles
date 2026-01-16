#!/bin/bash

# Safe Homebrew install script for programming languages
# Installs additional programming languages and runtimes

set -e

echo "Installing additional programming languages via Homebrew..."

brew install ruby
brew install php
brew install lua
brew install perl

echo "Additional programming languages installed successfully."
