all:
	stow -t ~/ -v X git ruby tmux vim
	stow -t ~/.config/fish -v fish

clean:
	stow -D -t ~/ -v -D X git ruby tmux vim
	stow -D -t ~/.config/fish -v -D fish
