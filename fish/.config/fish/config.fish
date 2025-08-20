# Configurações globais
# NVIM
set PATH $PATH /opt/nvim-linux-x86_64/bin
alias v nvim
# NVIM END

set -x GOPATH $HOME/go

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

set -l module_dir $HOME/.config/fish/modules

if test -n "$CONTAINER_ID" -a -f "$module_dir/container.fish"
    source $module_dir/container.fish
end
