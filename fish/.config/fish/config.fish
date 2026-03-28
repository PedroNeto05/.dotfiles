# Configurações globais
# NVIM
alias v nvim
function open
    nautilus $argv & disown
end
# NVIM END

set -l module_dir $HOME/.config/fish/modules
for mod in $module_dir/*.fish
    if test -f $mod
        source $mod
    end
end
