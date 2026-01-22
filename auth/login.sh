#!/bin/bash

# Dotfiles authentication system
AUTH_DIR="$HOME/.dotfiles"
TOKEN_FILE="$AUTH_DIR/token"

log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

login() {
  mkdir -p "$AUTH_DIR"
  
  echo "Enter your dotfiles token (or press Enter to login via browser):"
  read -r -s token
  
  if [ -z "$token" ]; then
    echo "Opening browser for authentication..."
    open "https://github.com/bniladridas/github-dotfiles/auth" 2>/dev/null || \
    xdg-open "https://github.com/bniladridas/github-dotfiles/auth" 2>/dev/null || \
    echo "Please visit: https://github.com/bniladridas/github-dotfiles/auth"
    
    echo "Enter token from browser:"
    read -r -s token
  fi
  
  if [ -n "$token" ]; then
    echo "$token" > "$TOKEN_FILE"
    chmod 600 "$TOKEN_FILE"
    log "Successfully logged in!"
  else
    log "ERROR: No token provided"
    exit 1
  fi
}

logout() {
  if [ -f "$TOKEN_FILE" ]; then
    rm "$TOKEN_FILE"
    log "Successfully logged out!"
  else
    log "Not currently logged in"
  fi
}

whoami() {
  if [ -f "$TOKEN_FILE" ]; then
    log "Logged in (token: $(head -c 8 "$TOKEN_FILE")...)"
  else
    log "Not logged in"
    exit 1
  fi
}

case "$1" in
  login)
    login
    ;;
  logout)
    logout
    ;;
  whoami)
    whoami
    ;;
  *)
    echo "Usage: $0 {login|logout|whoami}"
    echo "  login   - Authenticate with dotfiles service"
    echo "  logout  - Remove stored credentials"
    echo "  whoami  - Show current login status"
    exit 1
    ;;
esac
