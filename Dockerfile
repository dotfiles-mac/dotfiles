FROM ubuntu:latest

# SPDX-License-Identifier: MIT

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip \
    pipx \
    nodejs \
    npm \
    ruby \
    shellcheck \
    && rm -rf /var/lib/apt/lists/*

# Install pre-commit
RUN pipx install pre-commit

# Copy dotfiles
COPY . /dotfiles

# Set up hooks (example)
RUN mkdir -p /root/.git/hooks && cp /dotfiles/git-hooks/pre-push /root/.git/hooks/

# Default command
CMD ["/bin/bash"]
