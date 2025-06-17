### Instalar o yay
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
### Instalar Programas
    yay -S neovim tmux lazygit unzip fish starship asdf-vm stow kitty github-cli fzf uv
### Terminal 
    chsh -s /usr/bin/fish
### Plugin Tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    
    # type this in terminal if tmux is already running
    tmux source ~/.tmux.conf
### Fonte
    cd /tmp && curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip
    unzip CascadiaCode.zip -d CascadiaCode
    cd ./CascadiaCode
    mkdir -p ~/.local/share/fonts
    mv ./CaskaydiaCoveNerdFontMono-Regular.ttf ~/.local/share/fonts/
