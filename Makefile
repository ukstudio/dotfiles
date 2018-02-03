all:
	stow -t ~/ -v X git ruby tmux vim
	stow -t ~/.config/fish -v fish
	stow -t ~/.config/alacritty -v alacritty

clean:
	stow -D -t ~/ -v -D X git ruby tmux vim
	stow -D -t ~/.config/fish -v -D fish
	stow -D -t ~/.config/alacritty -v -D alacritty
