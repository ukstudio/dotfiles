"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "javascript,ruby,html"
let g:vim_bootstrap_editor = "vim"        " nvim or vim

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  " Run shell script if exist on custom select language

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
" Plug 'nixprime/cpsm'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'bronson/vim-trailing-whitespace'
Plug 'christoomey/vim-tmux-runner'
Plug 'fatih/vim-go'
Plug 'google/vim-jsonnet'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'jparise/vim-graphql'
Plug 'junegunn/vim-easy-align'
Plug 'rking/ag.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dmerejkowsky/vim-ale'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" Color
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'

Plug 'ap/vim-css-color'

"" Custom bundles
"" Javascript Bundle
Plug 'Quramy/tsuquyomi'
Plug 'ianks/vim-tsx'
Plug 'jelera/vim-javascript-syntax'
Plug 'jparise/vim-graphql'
Plug 'leafgarland/typescript-vim'
Plug 'kchmck/vim-coffee-script'

"" Rails
Plug 'danchoi/ruby_bashrockets.vim'
Plug 'gabebw/vim-spec-runner'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'

"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-haml'
Plug 'vim-scripts/HTML-AutoCloseTag'

"" Git
Plug 'gregsexton/gitv'
Plug 'rhysd/committia.vim'
Plug 'tpope/vim-fugitive'

Plug 'chr4/nginx.vim'

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Encoding
set nobomb
set ttyfast

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

set termguicolors

set lazyredraw
set ttyfast

set updatetime=300

set cursorline
set signcolumn=yes
set cmdheight=2

set regexpengine=1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
  set background=dark
  colorscheme gruvbox
endif

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  " let g:indentLine_faster = 1 vim-slimのシンタックスが死ぬ


  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif

endif

if &term =~ '256color'
  set t_ut=
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

" vim-airline
let g:airline_theme = 'gruvbox'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline_skip_empty_sections = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

if !exists('*s:createMissingDirectory')
  function s:createMissingDirectory()
    let dir = expand("<afile>:p:h:")
    if !isdirectory(dir) && confirm("Create a new directory [".dir."]?", "&Yes\n&No") == 1
      call mkdir(dir, "p")
      file %
    endif
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

augroup vimrc-autoreload
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup vim-trailing-whitespace
  autocmd!
  autocmd BufWritePre * :FixWhitespace
augroup END

augroup vimrc-go
  autocmd!
  autocmd FileType go set tabstop=4|set shiftwidth=4|set noexpandtab
  autocmd BufNewFile,BufRead,BufWritePost *.go :GoFmt
augroup END

augroup create-missing-directory
  autocmd!
  autocmd BufNewFile * call s:createMissingDirectory()
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

noremap <Leader>w :<C-u>write<Cr>
noremap <Leader>q :<C-u>quit<Cr>

noremap j gj
noremap k gk

noremap wh <C-w>h
noremap wj <C-w>j
noremap wk <C-w>k
noremap wl <C-w>l

noremap tn :<C-u>tabnew<Cr>
noremap th :<C-u>tabprev<Cr>
noremap tl :<C-u>tabnext<Cr>
noremap tc :<C-u>tabclose<Cr>

noremap bh :<C-u>bprev<Cr>
noremap bl :<C-u>bnext<Cr>

noremap + 4<C-w>+
noremap - 4<C-w>-
noremap { 4<C-w><
noremap } 4<C-w>>

noremap <Leader>b <C-^>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

nnoremap <Leader>. :<C-u>edit $MYVIMRC<Cr>

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set clipboard=unnamed,unnamedplus

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

"" Custom configs

let g:javascript_enable_domhtmlcss = 1
let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_completion_detail = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
augroup END

augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec,*.jb,Schemafile,*.schema setlocal filetype=ruby
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
augroup END

"" vim-tmux-runner
let g:VtrUseVtrMaps = 0

"" vim-spec-runner
let g:spec_runner_dispatcher = 'VtrSendCommand! {command}'
map <Leader>rs <Plug>RunCurrentSpecFile
map <Leader>rt <Plug>RunFocusedSpec

"" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"" coc.nvim
nnoremap <silent> <C-p> :<C-u>CocList files<cr>
nmap <Leader>rn <Plug>(coc-rename)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> cl <PLug>(coc-codelens-action)

"" ALE
let g:ale_completion_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

let g:ale_linters = {
      \ 'proto': ['protoc-gen-lint'],
      \}

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

autocmd FileType typescript setlocal omnifunc=javascriptcomplete#CompleteJS
