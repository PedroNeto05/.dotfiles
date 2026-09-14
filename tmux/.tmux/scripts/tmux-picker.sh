#!/usr/bin/env bash
# Seletores fzf de janelas e sessões do tmux, com ações integradas.
# Sessões podem ser salvas em disco (janelas, painéis, layout e diretórios) e restauradas
# depois de reiniciar o PC.
# Uso: tmux-picker.sh windows | sessions
# Pensado para rodar dentro de um `display-popup`.

set -uo pipefail

SAVE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/sessions"
EXT=".session"
SEP=$'\t'

mkdir -p "$SAVE_DIR"

list_windows() {
  tmux list-windows -F "#{window_id}${SEP}#I: #W"
}

# Saída: <nome>\t<texto exibido>. Abertas primeiro, depois as salvas que estão fechadas.
list_sessions() {
  local s f
  local -A open=()
  while read -r s; do
    open[$s]=1
    if [[ -e "$SAVE_DIR/$s$EXT" ]]; then
      echo "$s${SEP}$s  [salva]"
    else
      echo "$s${SEP}$s"
    fi
  done < <(tmux list-sessions -F '#S' 2>/dev/null)

  for f in "$SAVE_DIR"/*"$EXT"; do
    [[ -e "$f" ]] || continue
    s=$(basename "$f" "$EXT")
    [[ -n "${open[$s]:-}" ]] || echo "$s${SEP}$s  [fechada]"
  done
}

# Formato do arquivo (separado por TAB):
#   W <idx_janela> <ativa> <layout> <nome>
#   P <idx_janela> <ativo> <diretório>
save_session() {
  local session="$1"
  if ! tmux has-session -t "=$session" 2>/dev/null; then
    tmux display-message "Sessão '$session' não está aberta"
    return
  fi

  local tmp
  tmp=$(mktemp)
  tmux list-windows -t "=$session" \
    -F "W${SEP}#{window_index}${SEP}#{window_active}${SEP}#{window_layout}${SEP}#{window_name}" >>"$tmp"
  tmux list-panes -s -t "=$session" \
    -F "P${SEP}#{window_index}${SEP}#{pane_active}${SEP}#{pane_current_path}" >>"$tmp"
  mv "$tmp" "$SAVE_DIR/$session$EXT"
  tmux display-message "Sessão '$session' salva"
}

delete_session() {
  local session="$1"
  rm -f "$SAVE_DIR/$session$EXT"
  tmux kill-session -t "=$session" 2>/dev/null
}

restore_session() {
  local session="$1"
  local file="$SAVE_DIR/$session$EXT"

  local -A win_id=()
  local active_win="" first=1
  local type idx active layout name dir

  # Cria as janelas (o primeiro painel de cada uma nasce no diretório do primeiro painel salvo)
  while IFS="$SEP" read -r type idx active layout name; do
    [[ "$type" == W ]] || continue
    dir=$(awk -F"$SEP" -v i="$idx" '$1 == "P" && $2 == i { print $4; exit }' "$file")
    [[ -d "$dir" ]] || dir="$HOME"

    if ((first)); then
      win_id[$idx]=$(tmux new-session -d -s "$session" -n "$name" -c "$dir" -P -F '#{window_id}')
      first=0
    else
      win_id[$idx]=$(tmux new-window -d -t "=$session:" -n "$name" -c "$dir" -P -F '#{window_id}')
    fi
    tmux set-option -w -t "${win_id[$idx]}" automatic-rename off
    [[ "$active" == 1 ]] && active_win="${win_id[$idx]}"
  done <"$file"

  # Cria os painéis restantes de cada janela
  local -A seen=() active_pane=()
  local count
  while IFS="$SEP" read -r type idx active dir; do
    [[ "$type" == P ]] || continue
    [[ -d "$dir" ]] || dir="$HOME"
    if [[ -n "${seen[$idx]:-}" ]]; then
      # Divide sempre o último painel para manter a ordem; `tiled` evita "no space for new pane"
      tmux select-layout -t "${win_id[$idx]}" tiled
      tmux split-window -d -t "$(tmux list-panes -t "${win_id[$idx]}" -F '#{pane_id}' | tail -n1)" -c "$dir"
    fi
    seen[$idx]=1
    count=$(tmux display-message -p -t "${win_id[$idx]}" '#{window_panes}')
    [[ "$active" == 1 ]] && active_pane[$idx]=$((count - 1))
  done <"$file"

  # Aplica layouts e seleciona painel/janela ativos
  local wid pane
  while IFS="$SEP" read -r type idx active layout name; do
    [[ "$type" == W ]] || continue
    wid="${win_id[$idx]}"
    tmux select-layout -t "$wid" "$layout" 2>/dev/null
    if [[ -n "${active_pane[$idx]:-}" ]]; then
      pane=$(tmux list-panes -t "$wid" -F '#{pane_id}' | sed -n "$((active_pane[$idx] + 1))p")
      [[ -n "$pane" ]] && tmux select-pane -t "$pane"
    fi
  done <"$file"

  [[ -n "$active_win" ]] && tmux select-window -t "$active_win"
  tmux display-message "Sessão '$session' restaurada"
}

open_session() {
  local session="$1"
  if ! tmux has-session -t "=$session" 2>/dev/null; then
    [[ -e "$SAVE_DIR/$session$EXT" ]] || return
    restore_session "$session"
  fi
  tmux switch-client -t "=$session"
}

case "${1:-}" in
windows)
  choice=$(list_windows |
    fzf --reverse --prompt 'Select tab: ' --delimiter "$SEP" --with-nth 2 \
      --header 'enter: trocar | ctrl-d: fechar aba' \
      --bind "ctrl-d:execute-silent(tmux kill-window -t {1})+reload($0 --list-windows)") || exit 0
  [[ -n "$choice" ]] && tmux select-window -t "${choice%%"$SEP"*}"
  ;;
sessions)
  choice=$(list_sessions |
    fzf --reverse --prompt 'Select session: ' --delimiter "$SEP" --with-nth 2 \
      --header 'enter: abrir | ctrl-s: salvar | ctrl-d: apagar (sessão e save)' \
      --bind "ctrl-s:execute-silent($0 --save {1})+reload($0 --list-sessions)" \
      --bind "ctrl-d:execute-silent($0 --delete {1})+reload($0 --list-sessions)") || exit 0
  [[ -n "$choice" ]] && open_session "${choice%%"$SEP"*}"
  ;;
--list-windows) list_windows ;;
--list-sessions) list_sessions ;;
--save) save_session "$2" ;;
--delete) delete_session "$2" ;;
*)
  echo "Uso: $0 windows | sessions" >&2
  exit 1
  ;;
esac
