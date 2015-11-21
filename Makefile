all:
	stow -t ~/ -v X git ruby tmux vim
	stow -t ~/.config/fish -v fish
	mkdir -p ~/.config/omf
	stow -t ~/.config/omf -v omf

clean:
	stow -D -t ~/ -v -D X git ruby tmux vim
	stow -D -t ~/.config/fish -v -D fish
	stow -D -t ~/.config/omf -v -D omf
