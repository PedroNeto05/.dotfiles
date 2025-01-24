DIRECTORIES := $(wildcard */)

initial:
	sudo apt upgrade && sudo apt update -y
	sudo apt install git curl wget build-essential zip unzip stow

fish:
	sudo apt-add-repository ppa:fish-shell/release-3
	sudo apt update && sudo apt install fish-shell

shell_theme:
	curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
	curl -sS https://starship.rs/install.sh | sh
	fish

asdf:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0
	mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions

neovim:
	cd /tmp && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /opt/nvim && sudo tar -C /opt -xzf nvim-linux64.tar.gz

tmux:
	sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config
	cd /tmp && curl -LO https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz
	tar -zxf tmux-*.tar.gz
	cd tmux-*/ && ./configure
	make && sudo make install
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

fonte:
	cd /tmp && curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip
	unzip CascadiaCode.zip -d CascadiaCode
	cd ./CascadiaCode
	mkdir -p ~/.local/share/fonts
	mv ./CaskaydiaCoveNerdFontMono-Regular.ttf ~/.local/share/fonts/

kitty:
	sudo apt install kitty

warp:
	cd /tmp && curl -L -o warp.deb "https://app.warp.dev/download?package=deb"
	sudo dpkg -i warp.deb
	mkdir -p ~/.config/warp-terminal/

fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

gh:
	chmod -x ./install_gh.sh && bash ./install_gh.sh

uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh

stow:
	@for dir in $(DIRECTORIES); do \
		echo "Stow in $$dir"; \
		stow --adopt $$dir; \
	done
	git restore .

all: initial fish asdf neovim tmux fonte warp fzf gh uv
