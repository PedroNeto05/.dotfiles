PACKAGES=(fish kitty starship tmux)

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "→ Linkando: $pkg"
        stow -R "$pkg" -t "$HOME"
    fi
done
