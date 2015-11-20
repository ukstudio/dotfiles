all:
	stow -t ~/ -v X git ruby tmux vim xmonad zsh

clean:
	stow -D -t ~/ -v -D X git ruby tmux vim xmonad zsh
