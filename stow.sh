#!/bin/bash

STOW_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PACKAGES=(fish kitty starship tmux)

for pkg in "${PACKAGES[@]}"; do
  if [ -d "$STOW_DIR/$pkg" ]; then
    echo "Linkando: $pkg"
    stow -d "$STOW_DIR" -R "$pkg" -t "$HOME"
  fi
done
