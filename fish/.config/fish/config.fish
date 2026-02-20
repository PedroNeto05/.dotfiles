# Configurações globais
# NVIM
alias v nvim
# NVIM END

set -l module_dir $HOME/.config/fish/modules
for mod in $module_dir/*.fish
    if test -f $mod
        source $mod
    end
end
