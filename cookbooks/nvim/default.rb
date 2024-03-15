package 'neovim'

dotfile '.config/nvim'

execute 'Install copilot.vim' do
  command "git clone https://github.com/github/copilot.vim ~/.config/nvim/pack/github/start/copilot.vim"
  not_if 'test -e ~/.config/nvim/pack/github/start/copilot.vim'
end
