"Basic " {{{1
set foldmethod=marker
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
set tw=0

set noswapfile
set nobackup

set ambiwidth=double
"オートインデントの空白文字を<BS>で削除
"前の行の改行文字を<BS>で削除し連結
"最初からある文字(Ctrl+uやCtrl+wで入力した文字以外)を削除
set backspace=indent,eol,start

let &statusline = '%f%m%=%y%{"[".(&fenc!=""?&fenc:&enc).",".&ff."]"}%{"[".neocomplcache#keyword_complete#caching_percent("")."%]"} %3l,%3c %3p%%' 

":TOhtml
let g:use_xhtml = 1
let g:html_use_css = 1

"文字コード
command! -bang -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>

command! -bang -nargs=? Euc
      \ edit<bang> ++enc=euc-jp <args>

command! -bang -nargs=? Sjis
      \ edit<bang> ++enc=Shift-jis <args>

"自動保存
autocmd CursorHold * silent! wall
autocmd CursorHoldI * silent! wall

"helpの言語の優先順位
set helplang=ja,en

set gfn=AnonymousPro:h13

" 戦闘力
function! VimPower()
  echo len(filter(extend(readfile($MYVIMRC), readfile($MYGVIMRC)),'v:val !~ "^\\s*$\\|^\\s*\""'))
endfunction

set autoread
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

"cd
nnoremap <silent> cd :<C-u>cd %:h<Cr>

"ファイルを行ったりきたり
nnoremap <Space>b <C-^>

" 検索結果のハイライトを消す
noremap <silent> <C-l> :nohl<CR><C-l>
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
autocmd MyAutoCmd BufNewFile,BufRead *.changelog set filetype=changelog
autocmd MyAutoCmd BufWritePost *.rb :!ruby -c %
autocmd MyAutoCmd BufNewFile * call s:create_missing_directory()

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

function! s:create_missing_directory()
  let dir = expand("<afile>:p:h")
  if !isdirectory(dir) && confirm("Create a new directory [".dir."]?", "&Yes\n&No") == 1
    call mkdir(dir, "p")
    " Reset fullpath of the buffer in order to avoid problems when using autochdir.
    file %
  endif
endfunction

autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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
" C-hで補完を続行しない
inoremap <expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
" C-nでneocomplcache補完
inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p>  pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"

" template
autocmd! BufNewFile *.user.js 0r $HOME/.vim/template/greasemonkey.txt
autocmd! BufNewFile *.html    0r $HOME/.vim/template/html.txt

" smartchr.vim
inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
inoremap <expr> + smartchr#one_of(' + ', ' += ', '+')
inoremap <expr> - smartchr#one_of(' - ', ' -= ', '-')

" man.vim
runtime ftplugin/man.vim

"editing .vimrc " {{{1
nmap <Space>. :<C-u>edit $MYVIMRC<CR>
nmap <Space>s. :<C-u>source $MYVIMRC<CR>

"MacVim {{{1
if has('gui_macvim')
  set guioptions-=T
  set background=dark
  set transparency=5
endif
