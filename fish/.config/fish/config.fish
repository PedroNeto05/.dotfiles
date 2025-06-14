# Configurações globais
# NVIM
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
alias v='nvim'
# NVIM END

# Cargo (Rust)
set -x PATH $HOME/.cargo/bin $PATH

# Golang
set -x PATH $PATH /usr/local/go/bin
set -x GOPATH $HOME/go
set -x PATH $PATH $GOROOT/bin $GOPATH/bin

# Android SDK
set -x ANDROID_HOME $HOME/Android/Sdk
set -x PATH $PATH $ANDROID_HOME/emulator
set -x PATH $PATH $ANDROID_HOME/platform-tools

 # ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# PNPM
set -gx PNPM_HOME "/home/pedro-neto/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

if status is-interactive
    # Configurações para sessões interativas

    uv generate-shell-completion fish | source

    # Configuração do prompt
    set -g fish_greeting

    # FZF - Ferramenta para fuzzy finding
    fzf --fish | source

    # Configuração de preview de arquivos com o bat
    export FZF_CTRL_T_OPTS="
      --walker-skip .git,node_modules,target,venv,.venv,__pycache__,.mypy_cache,
      --preview 'bat -n --color=always {}'
      --border
      --bind 'ctrl-/:change-preview-window(down|hidden|)'"
    
    # Configuração para copiar para o clipboard com CTRL-Y
    export FZF_CTRL_R_OPTS="
      --color header:italic
      --border
      "

    # Exibir estrutura de diretórios com tree
    export FZF_ALT_C_OPTS="
      --walker-skip .git,node_modules,target,venv,.venv,__pycache__,.mypy_cache,
      --border
      --preview 'tree -C {}'"

    # Inicializar Starship para prompt moderno
    starship init fish | source
end
