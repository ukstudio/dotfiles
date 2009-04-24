"Basic " {{{1
set foldmethod=marker

set background=dark"
colorscheme xoria256

set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on

set nu
set cursorline
set ruler

set wildmenu    "補完候補の一覧を表示
set smartindent
set hlsearch
set laststatus=2 

set noswapfile

set ambiwidth=double
"オートインデントの空白文字を<BS>で削除
"前の行の改行文字を<BS>で削除し連結
"最初からある文字(Ctrl+uやCtrl+wで入力した文字以外)を削除
set backspace=indent,eol,start

"カレント行の文字数
function! CurrentLineLength()
	let len = strlen(getline("."))
	return len
endfunction


let &statusline = '%f%m%=%y%{"[".(&fenc!=""?&fenc:&enc).",".&ff."]"}%{"[".neocomplcache#keyword_complete#caching_percent("")."%]"} %3l,%3c %3p%%' 

"Syntax " {{{1
autocmd! BufRead,BufNewFile .vimperatorrc setfiletype vimperator

"Key Mapping " {{{1

" write/quit
nnoremap <Space>w :<C-u>write<CR>
nnoremap <Space>q :<C-u>quit<CR>

"行移動
nnoremap j gjzz
nnoremap k gkzz

"window操作
nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l

"Tab操作
nnoremap tn :<C-u>tabnew<Cr>
nnoremap th :<C-u>tabprev<Cr>
nnoremap tl :<C-u>tabnext<Cr>
nnoremap tc :<C-u>tabclose<Cr>

"Windowサイズ
nnoremap + 4<C-w>+
nnoremap - 4<C-w>-
nnoremap { 4<C-w><
nnoremap } 4<C-w>>

"set FileType
"phpとhtmlのsyntax color切り替え用
nnoremap <Space>ftp :<C-u>set filetype=php<Cr>
nnoremap <Space>ftr :<C-u>set filetype=ruby<Cr>
nnoremap <Space>fth :<C-u>set filetype=html<Cr>

"行頭からの補完
inoremap <C-l> <C-x><C-l>

" autocmd "{{{1
augroup MyAutoCmd
  autocmd!
augroup end

autocmd MyAutoCmd FileType * call s:set_short_indent()
autocmd MyAutoCmd FileType vim nnoremap ,s :<C-u>source %<Cr>
autocmd MyAutoCmd FileType ruby call s:set_filetype_ruby()
autocmd MyAutoCmd FileType php  call s:set_filetype_php()
autocmd MyAutoCmd FileType changelog call s:set_filetype_changelog()
autocmd MyAutoCmd Filetype eruby set nowrap
autocmd MyAutoCmd BufNewFile,BufRead *.txt set filetype=text

autocmd BufNewFile,BufRead *.changelog set filetype=changelog

function! s:set_short_indent()
  setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
endfunction

function! s:set_filetype_ruby()
  " rails.vim
  let g:rails_level=4
  let g:rails_default_file="app/controllers/application.rb"

  " rubycomplete.vim
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_rails = 1
  let g:rubycomplete_classes_in_global = 1

  " smartchr.vim
  inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
  inoremap <expr> + smartchr#one_of(' + ', ' += ', '+')
  inoremap <expr> - smartchr#one_of(' - ', ' -= ', '-')
  inoremap <expr> ! smartchr#one_of('!',   ' != ')

  "autocmd MyAutoCmd BufWritePost *.rb :!ruby -c %
  nmap ,r :<C-u>!ruby %<CR>
  nmap ,t :<C-u>!spec %<CR>
endfunction

function! s:set_filetype_php()
  nmap ,r :<C-u>!php %<CR>
endfunction

function! s:set_filetype_changelog()
  let g:changelog_timeformat = "%Y-%m-%d"
  let g:changelog_username = "Yuki Akamatsu(id:ukstudio) <yuki.0w0@gmail.com>"
endfunction

"Plugin " {{{1

" fuzzyfinder.vim
nmap fb :FuzzyFinderBuffer<CR>
nmap ff :FuzzyFinderFile<CR>
nmap fm :FuzzyFinderMruFile<CR>

" neocomplcache.vim
" Use neocomplcache.
let g:NeoComplCache_EnableAtStartup = 1
" Use smartcase.
let g:NeoComplCache_SmartCase = 1
" Use mfu.
let g:NeoComplCache_EnableMFU = 1
" Use previous keyword completion.
let g:NeoComplCache_PreviousKeywordCompletion = 1
" Use similar match.
let g:NeoComplCache_SimilarMatch = 1
" Try keyword completion.
let g:NeoComplCache_TryKeywordCompletion = 1
" Use preview window.
let g:NeoComplCache_EnableInfo = 1
" Delete keyword when rank is 0.
let g:NeoComplCache_DeleteRank0 = 0

let g:NeoComplCache_KeywordCompletionStartLength = 4 
let g:NeoComplCache_EnableCamelCaseCompletion = 1 

" <TAB> completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" C-jでオムニ補完
inoremap <expr> <C-j>  &filetype == 'vim' ? "\<C-x>\<C-v>\<C-p>" : "\<C-x>\<C-o>\<C-p>"
" C-kを押すと行末まで削除
inoremap <C-k>  <C-o>D
" C-hで補完を続行しない
inoremap <expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
" C-nでneocomplcache補完
inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p>  pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"

" template
autocmd! BufNewFile *.user.js 0r $HOME/.vim/template/greasemonkey.txt
autocmd! BufNewFile *.html    0r $HOME/.vim/template/html.txt

"editing .vimrc " {{{1
"
nmap <Space>. :<C-u>edit $MYVIMRC<CR>
nmap <Space>s. :<C-u>source $MYVIMRC<CR>
