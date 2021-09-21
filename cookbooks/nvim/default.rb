package 'neovim'

dotfile '.config/nvim'

execute 'Install dein' do
  command 'curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh; sh ./installer.sh ~/.cache/dein; rm installer.sh'
  not_if 'test -d ~/.cache/dein'
end
