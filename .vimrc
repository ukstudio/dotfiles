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

set wildmenu    "補完候補の一覧を表示
set smartindent
set hlsearch
set laststatus=2 

set noswapfile

"オートインデントの空白文字を<BS>で削除
"前の行の改行文字を<BS>で削除し連結
"最初からある文字(Ctrl+uやCtrl+wで入力した文字以外)を削除
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
inoremap <c-o> <c-r>=InsertTabWrapper()<cr>

"カレント行の文字数
function CurrentLineLength()
	let len = strlen(getline("."))
	return len
endfunction

"changelog
autocmd BufNewFile,BufRead *.changelog set filetype=changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "Yuki Akamatsu(id:ukstudio) <yuki.0w0@gmail.com>"


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


"Plugin " {{{1

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
nmap fb :FuzzyFinderBuffer<CR>
nmap ff :FuzzyFinderFile<CR>
nmap fm :FuzzyFinderMruFile<CR>

" template
autocmd! BufNewFile *.user.js 0r $HOME/.vim/template/greasemonkey.txt
autocmd! BufNewFile *.html    0r $HOME/.vim/template/html.txt

"editing .vimrc " {{{1
nmap <Space>. :<C-u>edit $MYVIMRC<CR>
nmap <Space>s. :<C-u>source $MYVIMRC<CR>
