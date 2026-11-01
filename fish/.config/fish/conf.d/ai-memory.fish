# ai-memory: token para Codex (e outros clientes MCP HTTP) acessarem o servidor local
if test -r ~/.local/share/ai-memory/auth-tokens/default
    set -gx AI_MEMORY_AUTH_TOKEN (string trim < ~/.local/share/ai-memory/auth-tokens/default)
end
