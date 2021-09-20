package 'zsh'

dotfile '.zshrc'

execute 'Install zinit' do
  command 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"'
  not_if 'test -d ~/.zinit'
end
