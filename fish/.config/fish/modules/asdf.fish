# Define o diretório do asdf (caso não exista)
if test -z "$ASDF_DATA_DIR"
    set -gx ASDF_DATA_DIR $HOME/.asdf
end

# Adiciona os shims ao PATH (na frente)
if not contains "$ASDF_DATA_DIR/shims" $PATH
    set -gx PATH "$ASDF_DATA_DIR/shims" $PATH
end

