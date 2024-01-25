package 'zsh'
dotfile '.zshrc'

execute 'Install zinit' do
  command 'bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"'
  not_if 'test -d ~/.local/share/zinit'
end
