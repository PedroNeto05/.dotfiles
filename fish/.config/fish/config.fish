# Configurações globais
# NVIM
set PATH $PATH /opt/nvim-linux-x86_64/bin
alias v nvim
# NVIM END
alias bat batcat

set -l module_dir $HOME/.config/fish/modules
for mod in $module_dir/*.fish
    if test -f $mod
        source $mod
    end
end
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
