"Basic " {{{1

augroup MyAutoCmd
  autocmd!
augroup end

set nocompatible
syntax on
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/Vundle.vim'

Bundle 'Shougo/neocomplete.vim'
Bundle 'chreekat/vim-instant-markdown'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'christoomey/vim-tmux-runner'
Bundle 'croaker/mustang-vim'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'gabebw/vim-spec-runner'
Bundle 'gregsexton/gitv'
Bundle 'haya14busa/incsearch.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'junegunn/vim-easy-align'
Bundle 'justinmk/vim-dirvish'
Bundle 'kana/vim-tabpagecd'
Bundle 'kannokanno/previm'
Bundle 'kchmck/vim-coffee-script'
Bundle 'majutsushi/tagbar'
Bundle 'matchit.zip'
Bundle 'nelstrom/vim-qargs'
Bundle 'rhysd/committia.vim'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'slim-template/vim-slim'
Bundle 'thinca/vim-qfreplace'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tyru/open-browser.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/Colour-Sampler-Pack'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'yuroyoro/vim-scala'

filetype plugin indent on

set foldmethod=marker
set t_Co=256
colorscheme Tomorrow-Night
set background=light

set listchars=tab:>\

set fileencodings=utf-8,euc-jp,cp932,default,latin

set nu
set ruler
set nocursorline

set wildmenu    "補完候補の一覧を表示
set smartindent
set hlsearch
set laststatus=2
set textwidth=0

set noswapfile
set nobackup

set ambiwidth=double
"オートインデントの空白文字を<BS>で削除
"前の行の改行文字を<BS>で削除し連結
"最初からある文字(Ctrl+uやCtrl+wで入力した文字以外)を削除
set backspace=indent,eol,start

let &statusline = '%f%m%=%y%{"[".(&fenc!=""?&fenc:&enc).",".&ff."]"} %3l,%3c %3p%%'
highlight Normal ctermbg=NONE

":TOhtml
let g:use_xhtml = 1
let g:html_use_css = 1

"文字コード
command! -bang -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? Euc edit<bang> ++enc=euc-jp <args>
command! -bang -nargs=? Sjis edit<bang> ++enc=Shift-jis <args>
command! -bang -nargs=? Cp932 edit<bang> ++enc=Cp932<args>

"自動保存
autocmd CursorHold * silent! wall
autocmd CursorHoldI * silent! wall

"helpの言語の優先順位
set helplang=ja,en

set autoread

"http://vim-users.jp/2009/11/hack104/
"visual modeで選択した文字を検索する
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

"changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "AKAMATSU Yuki(id:ukstudio) <y.akamatsu@ukstudio.jp>"

function! s:set_short_indent()
  setlocal expandtab softtabstop=2 shiftwidth=2
endfunction

function! s:set_haskell_indent()
  setlocal expandtab softtabstop=4 shiftwidth=4
endfunction

function! s:set_review_indent()
  setlocal noexpandtab
endfunction

" 末尾のスペースをハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

"Key Mapping " {{{1

let mapleader = " "

" write/quit
nnoremap <Leader>w :<C-u>write<CR>
nnoremap <Leader>q :<C-u>quit<CR>

"行移動
nnoremap j gj
nnoremap k gk

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

"cd
nnoremap <silent> cd :<C-u>cd %:h<Cr>

"ファイルを行ったりきたり
nnoremap <Leader>b <C-^>

" 検索結果のハイライトを消す
noremap <Leader> <C-l> :nohl<CR><C-l>

" for vim-fugitive
nnoremap <Leader>ga :<C-u>Gwrite<Cr>
nnoremap <Leader>gc :<C-u>Gcommit -v<Cr>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" cwindow
nnoremap <S-n> :<C-u>cnext<Cr>
nnoremap <S-p> :<C-u>cprevious<Cr>

" from シングルページWebアプリケーション(オライリー)
vmap <silent> ;h :s?^\(\s*\)+ '\([^']\+\)',*\s*$?\1\2?g<CR>
vmap <silent> ;q :s?^\(\s*\)\(.*\)\s*$? \1 + '\2'?<CR>


" autocmd "{{{1
autocmd MyAutoCmd FileType vim nnoremap ,s :<C-u>source %<Cr>

autocmd MyAutoCmd BufNewFile * call s:create_missing_directory()
function! s:create_missing_directory()
 let dir = expand("<afile>:p:h")
  if !isdirectory(dir) && confirm("Create a new directory [".dir."]?", "&Yes\n&No") == 1
    call mkdir(dir, "p")
    " Reset fullpath of the buffer in order to avoid problems when using autochdir.
    file %
  endif
endfunction

function! s:delete_eol_spaces()
  :%s/\s\+$//e
endfunction
" 末尾のスペース削除
autocmd MyAutoCmd BufWrite * call s:delete_eol_spaces()

" filetype "{{{2
autocmd MyAutoCmd BufNewFile,BufRead *.txt set filetype=text
autocmd MyAutoCmd BufNewFile,BufRead *.changelog set filetype=changelog
autocmd MyAutoCmd BufNewFile,BufRead *.less set filetype=css
autocmd MyAutoCmd BufNewFile,BufRead __EVERVIM_NOTE__ set filetype=html
autocmd MyAutoCmd BufNewFile,BufRead *.watchr set filetype=ruby

autocmd MyAutoCmd FileType haskell call s:set_haskell_indent()
autocmd MyAutoCmd FileType review call s:set_short_indent()
autocmd MyAutoCmd FileType html call s:set_short_indent()
autocmd MyAutoCmd FileType eruby call s:set_short_indent()
autocmd MyAutoCmd FileType text call s:set_short_indent()
autocmd MyAutoCmd FileType scala call s:set_short_indent()
autocmd MyAutoCmd FileType css call s:set_short_indent()
autocmd MyAutoCmd FileType coffee call s:set_short_indent()
autocmd MyAutoCmd FileType sh call s:set_short_indent()
autocmd MyAutoCmd FileType javascript call s:set_short_indent()
autocmd MyAutoCmd FileType rst  call s:set_short_indent()
autocmd MyAutoCmd FileType modula2  call s:set_short_indent()
autocmd MyAutoCmd FileType yaml call s:set_short_indent()
autocmd MyAutoCmd FileType haml call s:set_short_indent()
autocmd MyAutoCmd FileType slim call s:set_short_indent()
autocmd MyAutoCmd FileType scss call s:set_short_indent()
autocmd MyAutoCmd FileType changelog call s:set_short_indent()

" ruby
autocmd MyAutoCmd FileType ruby call s:set_short_indent()
autocmd MyAutoCmd FileType ruby call s:set_filetype_ruby()
autocmd MyAutoCmd Filetype eruby set nowrap
autocmd MyAutoCmd BufWritePost *.rb :!ruby -c %


function! s:set_filetype_ruby()
  nmap ,r :<C-u>!ruby %<CR>
  nmap ,s :<C-u>!spec %<CR>
endfunction


"Plugin " {{{1

" ctrlp. " {{{2
let g:ctrlp_prompt_mappings = {
			\ 'PrtBS()':              ['<bs>'],
			\ 'PrtDelete()':          ['<del>'],
			\ 'PrtDeleteWord()':      ['<c-w>'],
			\ 'PrtClear()':           ['<c-u>'],
			\ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
			\ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
			\ 'PrtHistory(-1)':       [],
			\ 'PrtHistory(1)':        [],
			\ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
			\ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
			\ 'AcceptSelection("t")': ['<c-t>', '<MiddleMouse>'],
			\ 'AcceptSelection("v")': ['<c-v>', '<c-q>', '<RightMouse>'],
			\ 'ToggleFocus()':        ['<tab>'],
			\ 'ToggleRegex()':        ['<c-r>'],
			\ 'ToggleByFname()':      ['<c-d>'],
			\ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
			\ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
			\ 'PrtCurStart()':        ['<c-a>'],
			\ 'PrtCurEnd()':          ['<c-e>'],
			\ 'PrtCurLeft()':         ['<c-h>', '<left>'],
			\ 'PrtCurRight()':        ['<c-l>', '<right>'],
			\ 'PrtClearCache()':      ['<F5>'],
			\ 'PrtDeleteMRU()':       ['<F7>'],
			\ 'CreateNewFile()':      ['<c-y>'],
			\ 'MarkToOpen()':         ['<c-z>'],
			\ 'OpenMulti()':          ['<c-o>'],
			\ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
			\ }
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so
let g:ctrlp_working_path_mode = 'ra'

" neocomplete.vim " {{{2

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : ''
\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType rspec setlocal omnifunc=rubycomplete#Complete
autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete

" man.vim " {{{2
runtime ftplugin/man.vim

" vimclojure " {{{2
let clj_highlight_builtins = 1
let clj_highlight_contrib = 1
let clj_paren_rainbow = 1
let clj_want_gorilla = 1
let vimclojure#NailgunClient = "/Users/akamatsu/.clojure/vimclojure/ng"


" tagbar " {{{2
nnoremap <Leader>l :TagbarToggle<CR>
let g:tagbar_ctags_bin="/usr/local/Cellar/ctags/5.8/bin/ctags"
let g:tagbar_usearrows = 1
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

" align.vim" {{{2
let g:Align_xstrlen = 3

" lightline.vim" {{{2
let g:lightline = { 'colorscheme': 'wombat' }

" syntastic " {{{2
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [] }
let g:syntastic_ruby_checkers = ['rubocop']

" incsearch.vim " {{{2
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" vim-tmux-runner" {{{2
let g:VtrUseVtrMaps = 0
let g:spec_runner_dispatcher = 'VtrSendCommand! {command}'
map <Leader>rs <Plug>RunCurrentSpecFile
"editing .vimrc " {{{1
nmap <Space>. :<C-u>edit $MYVIMRC<CR>
nmap <Space>s. :<C-u>source $MYVIMRC<CR>

"vimrc自動読み込み
if !has('gui_running')
  autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
  autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC |if has('gui_running') | source $MYGVIMRC
  autocmd MyAutoCmd BufWritePost $MYGVIMRC nested source $MYGVIMRC
end
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif

set tags=~/.tags,tags,coffee_tags
