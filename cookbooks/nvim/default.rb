package 'neovim'

dotfile '.config/nvim'

execute 'Install vim-plug' do
  command "sh -c 'curl -fLo \"${XDG_DATA_HOME:-$HOME/.local/share}\"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
  not_if 'test -d "${XDG_DATA_HOME:/.local/share}"/nvim/site/autoload/plug.vim'
end
