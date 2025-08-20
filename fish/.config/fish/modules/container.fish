if test -n "$CONTAINER_ID" -a -f "$module_dir/container.fish"
    if test -f $HOME/.asdf/asdf.fish
        source $HOME/.asdf/asdf.fish
    end

    if test -z "$ASDF_DATA_DIR"
        set _asdf_shims "$HOME/.asdf/shims"
    else
        set _asdf_shims "$ASDF_DATA_DIR/shims"
    end

    if not contains $_asdf_shims $PATH
        set -gx --prepend PATH $_asdf_shims
    end
    set --erase _asdf_shims
end
