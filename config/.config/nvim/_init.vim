if $compatible
  set nocompatible
endif

call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-lsp-icons'
Plug 'hrsh7th/vim-vsnip'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
Plug 'vim-airline/vim-airline'
Plug 'APZelos/blamer.nvim'
Plug 'jparise/vim-graphql'
Plug 'github/copilot.vim'
Plug 'google/vim-jsonnet'
call plug#end()

filetype plugin indent on
syntax enable

colorscheme gruvbox

set number
set backspace=indent,eol,start

set nobomb
set ttyfast
set lazyredraw

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

set clipboard=unnamed,unnamedplus

set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

set noswapfile
set nobackup

set hlsearch
set incsearch
set ignorecase
set smartcase

set ruler
set cursorline
set signcolumn=yes
set cmdheight=2

let mapleader=' '

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_document_highlight_enabled = 0
let g:asyncomplete_auto_popup = 1
let g:lsp_settings_filetype_ruby = ['solargraph']
"let g:lsp_settings_filetype_ruby = ['steep']
"let g:lsp_settings_filetype_ruby = ['ruby-lsp']

let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nnoremap <Leader>l :source ~/.config/nvim/init.vim<Cr>

noremap <Leader>w :<C-u>write<Cr>
noremap <Leader>q :<C-u>quit<Cr>
noremap <Leader>b <C-^>

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>

noremap tn :<C-u>tabnew<Cr>
noremap th :<C-u>tabprev<Cr>
noremap tl :<C-u>tabnext<Cr>
noremap tc :<C-u>tabclose<Cr>

noremap wh <C-w>h
noremap wj <C-w>j
noremap wk <C-w>k
noremap wl <C-w>l

noremap + 4<C-w>+
noremap - 4<C-w>-
noremap { 4<C-w><
noremap } 4<C-w>>

" xmap ga <Plug>(EasyAlign)
" nmap ga <Plug>(EasyAlign)

"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" copilot
inoremap <C-j> <Plug>(copilot-next)
inoremap <C-k> <Plug>(copilot-prev)

let g:copilot_filetypes = {
    \ 'gitcommit': v:true,
    \ }

map <Leader>s :call RunNearestSpec()<Cr>

augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" ファイル保存時にディレクトリがなかったら作成するか問う
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

let g:rspec_command = "Dispatch bundle exec rspec {spec}"
