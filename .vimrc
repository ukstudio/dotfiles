"Basic " {{{1
set foldmethod=marker

set background=dark"
colorscheme xoria256

set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set nu
set cursorline
set ruler

set smartindent
set hlsearch
set laststatus=2 
set backspace=indent,eol,start

"<TAB>でOmni補完
function! InsertTabWrapper()
  if pumvisible()
    return "\<c-n>"
  endif
  let col = col('.') - 1
  if !col || getline('.')[col -1] !~ '\k\|<\|/'
    return "\<tab>"
  elseif exists('&omnifunc') && &omnifunc == ''
    return "\<c-n>"
  else
    return "\<c-x>\<c-o>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"Key Mapping " {{{1
nnoremap <Space>w :<C-u>write<CR>
nnoremap <Space>q :<C-u>quit<CR>

"window操作
nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l

inoremap { {}<LEFT>
inoremap ( ()<LEFT>

"Plugin " {{{1
" rails.vim
let g:rails_level=4
let g:rails_default_file="app/controllers/application.rb"

" rubycomplete.vim
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_classes_in_global = 1

" autocomplpop.vim
let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k'
let g:AutoComplPop_IgnoreCaseOption = 1

let g:AutoComplPop_BehaviorKeywordLength = 6
let g:AutoComplPop_BehaviorFileLength = 1
let g:AutoComplPop_BehaviorRubyOmniMethodLength = 6
let g:AutoComplPop_BehaviorRubyOmniSymbolLength = 6
let g:AutoComplPop_BehaviorPythonOmniLength = 4
let g:AutoComplPop_BehaviorHTMLOmniLength = 1
let g:AutoComplPop_BehaviorCssOmniPropertyLength = 1
let g:AutoComplPop_BehaviorCssOmniValueLength = 1

" fuzzyfinder.vim
nmap bg :FuzzyFinderBuffer<CR>

" smartchr.vim
inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
inoremap <expr> + smartchr#one_of(' + ', ' += ', '+')
inoremap <expr> - smartchr#one_of(' - ', ' -= ', '-')
inoremap <expr> ! smartchr#one_of('!',   ' != ')

" dictionary
autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/javascript.dict'

" template
autocmd BufNewFile *.user.js 0r $HOME/.vim/template/greasemonkey.txt

"Programming {{{1
"Ruby
autocmd BufWritePost *.rb :!ruby -c %
autocmd BufNewFile,BufRead *.rb nnoremap ,r :<C-u>!ruby %<CR>
autocmd BufNewFile,BufRead *_spec.rb nnoremap ,sp :<C-u>!spec %<CR>

"Scheme
autocmd BufnewFile,BufRead *.scm nnoremap ,r :<C-u>!gosh -i < %<CR>
autocmd BufnewFile,BufRead *.scm inoremap <expr> = smartchr#one_of('=')
autocmd BufnewFile,BufRead *.scm inoremap <expr> - smartchr#one_of('-')
autocmd BufnewFile,BufRead *.scm inoremap <expr> + smartchr#one_of('+')

"PHP
autocmd BufWritePost *.php :!php -l %
autocmd BufnewFile,BufRead *.php nnoremap ,r :<C-u>!php %<CR>

"Haskell
autocmd BufNewFile,BufRead *.hs nnoremap ,r :<C-u>!runghc %<CR>
autocmd BufnewFile,BufRead *.hs inoremap <expr> - smartchr#one_of('->', '-')
autocmd BufnewFile,BufRead *.hs inoremap <expr> $ smartchr#one_of(' $ ', '$')
"editing .vimrc " {{{1
nmap <Space>. :<C-u>edit $MYVIMRC<CR>
nmap <Space>s. :<C-u>source $MYVIMRC<CR>