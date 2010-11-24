"Basic " {{{1

" pathogen.vim
call pathogen#runtime_append_all_bundles()

set foldmethod=marker
colorscheme xoria256
"set gfn=Inconsolata:h13
"set gfw=TakaoExGothic:h11
set background=light

set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on

set nu
set ruler
set cursorline

autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

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

command! -bang -nargs=? Cp932
      \ edit<bang> ++enc=Cp932<args>

"自動保存
autocmd CursorHold * silent! wall
autocmd CursorHoldI * silent! wall

"helpの言語の優先順位
set helplang=ja,en

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
autocmd MyAutoCmd BufNewFile,BufRead *.less set filetype=css

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
"
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplcache_enable_auto_select = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" template
autocmd! BufNewFile *.user.js 0r $HOME/.vim/template/greasemonkey.txt
autocmd! BufNewFile *.html    0r $HOME/.vim/template/html.txt

" smartchr.vim
inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
inoremap <expr> + smartchr#one_of(' + ', ' += ', '+')
inoremap <expr> - smartchr#one_of(' - ', ' -= ', '-')

" man.vim
runtime ftplugin/man.vim

" vimclojure
let clj_highlight_builtins = 1
let clj_highlight_contrib = 1
let clj_paren_rainbow = 1
let clj_want_gorilla = 1
let vimclojure#NailgunClient = "/Users/akamatsu/.clojure/vimclojure/ng"

" unite.vim
let g:unite_enable_start_insert = 1
nmap <C-k>b :<C-u>Unite buffer<CR>
nmap <C-k>m :<C-u>Unite file_mru<CR>
nmap <C-k>f :<C-u>Unite file<CR>

" quickrun.vimneocomplcache#smart_close_popup() . "\
autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
let g:quickrun_config = {}
let g:quickrun_config['ruby.rspec'] = {'command': "rspec -l {line('.')}"}

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
