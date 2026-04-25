alias v nvim
function open
    if test (count $argv) -eq 0
        set argv .
    end
    xdg-open $argv >/dev/null 2>&1 & disown
end

set -l module_dir $HOME/.config/fish/modules
for mod in $module_dir/*.fish
    if test -f $mod
        source $mod
    end
end

set -U fish_user_paths ~/.local/bin $fish_user_paths
