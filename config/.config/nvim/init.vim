if $compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
call dein#begin('~/.cache/dein')
call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
call dein#add('morhetz/gruvbox')
call dein#end()

filetype plugin indent on
syntax enable

colorscheme gruvbox

let mapleader=' '

noremap <Leader>w :<C-u>write<Cr>
noremap <Leader>q :<C-u>quit<Cr>
noremap <Leader>b <C-^>
