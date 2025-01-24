# 🌟 Meus Dotfiles  

Este repositório contém meus arquivos de configuração para ferramentas que utilizo no dia a dia, como Neovim, Fish, Tmux, entre outras. Ele facilita a configuração do meu ambiente de trabalho de forma rápida e eficiente.  

---

## 📦 Download e Configuração

### 1. Instalar as primeiras ferramentas
- **Debian/Ubuntu**:  
  ```bash  
  sudo apt upgrade && sudo apt update -y
  sudo apt install git curl wget build-essential zip unzip
  ```

### 2. Instalar o [Fish Shell](https://github.com/fish-shell/fish-shell) 
- **Debian/Ubuntu**:  
  ```bash  
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo apt update && sudo apt install fish
  ```

### 4. Definir o Fish como terminal padrao
- **Debian/Ubuntu**:  
  ```bash  
  chsh -s /usr/bin/fish
  ```

### 5. Reiniciar o pc

### 6. Instalar o [Startship theme](https://starship.rs) 
- **Debian/Ubuntu**:  
  ```bash  
  curl -sS https://starship.rs/install.sh | sh
  fish
  ```

### 7. Instalar o [Oh-My-Fish](https://github.com/oh-my-fish/oh-my-fish) 
- **Debian/Ubuntu**:  
  ```bash  
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
  ```

### 8. Instalar o [asdf](https://asdf-vm.com/)
- **Debian/Ubuntu**:  
  ```bash  
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0
  mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
  ```

### 9. Instalar o [GNU Stow](https://www.gnu.org/software/stow/) 
- **Debian/Ubuntu**:  
  ```bash  
  sudo apt update && sudo apt install stow  
  ```

### 10. Instalar o [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md) 
- **Debian/Ubuntu**:  
  ```bash  
  cd /tmp && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  sudo rm -rf /opt/nvim && sudo tar -C /opt -xzf nvim-linux64.tar.gz
  ```

### 11. Instalar o [Tmux](https://github.com/tmux/tmux/releases)  
- **Debian/Ubuntu**:  
  - **Instale as dependências necessárias:**  
     ```bash  
     sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config  
     ```  
  - Acesse a pasta `Downloads` e faça o download do Tmux:
     ```bash  
     cd /tmp && curl -LO https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz
     tar -zxf tmux-*.tar.gz
     cd tmux-*/ && ./configure
     make && sudo make install
     ```  
  - Instalar o gerenciador de plugins TPM 
     ```bash  
     git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
     ```  
     ```bash  
     # type this in terminal if tmux is already running
     tmux source ~/.tmux.conf
     ```  
     - Apos isso, com o tmux rodando, apertar ```prefix``` + ```I```


### 12. Instalar a [Fonte](https://www.nerdfonts.com/font-downloads)
- **Debian/Ubuntu**:  
     ```bash  
     cd /tmp && curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip
     unzip CascadiaCode.zip -d CascadiaCode
     cd ./CascadiaCode
     mkdir -p ~/.local/share/fonts
     mv ./CaskaydiaCoveNerdFontMono-Regular.ttf ~/.local/share/fonts/
     ```  

### 13. Instalar o [Kitty terminal](https://sw.kovidgoyal.net/kitty/)
- **Debian/Ubuntu**:  
     ```bash  
     sudo apt install kitty
     ```  

### 14. Clonar o repository e fazer a configuração de [Dotfiles](https://github.com/PedroNeto05/dotfiles) 
- **Debian/Ubuntu**:  
     ```bash  
     mkdir ~/.dotfiles && git clone https://github.com/PedroNeto05/.dotfiles.git ~/.dotfiles
     cd ~/.dotfiles && make
     ```  

### 15. Instalar o [Github CLI](https://cli.github.com/)
- **Debian/Ubuntu**:  
     ```bash  
     chmod -x ./install_gh.sh && bash ./install_gh.sh
     ```  
### 16. Instalar o [FzF](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
- **Debian/Ubuntu**:  
     ```bash  
     git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
     ~/.fzf/install
     ```  
### 17. Instalar o [LazyGit](https://github.com/jesseduffield/lazygit)
- **Debian/Ubuntu**:  
     ```bash  
     asdf plugin-add golang
     asdf install golang {goland version}
     asdf reshim
     asdf global golang {golang version}
     go install github.com/jesseduffield/lazygit@latest
     asdf reshim
     ```  
