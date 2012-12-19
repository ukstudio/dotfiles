"Basic " {{{1

augroup MyAutoCmd
  autocmd!
augroup end

set nocompatible
syntax on
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'neocomplcache'
Bundle 'tpope/vim-rails'
Bundle 'ujihisa/neco-look'
Bundle 'kchmck/vim-coffee-script'
Bundle 'ukstudio/vim-review'
Bundle 'thinca/vim-ref'
Bundle 'tpope/vim-fugitive'
Bundle 'mattn/zencoding-vim'
Bundle 'thinca/vim-qfreplace'
Bundle 'ukstudio/vim-ukstudio256'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'yuroyoro/vim-scala'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tslime.vim'
Bundle 'jgdavey/vim-turbux'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'matchit.zip'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kana/vim-tabpagecd'
Bundle 'croaker/mustang-vim'
Bundle 'tomasr/molokai'
Bundle 'tsaleh/vim-align'
Bundle 'vim-scripts/CSApprox'
Bundle 'vim-scripts/Colour-Sampler-Pack'

filetype plugin indent on

set foldmethod=marker
set t_Co=256
let g:solarized_termcolors=16
colorscheme jellybeans
set background=light

set listchars=tab:>\

set fileencodings=utf-8,euc-jp,cp932,default,latin

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
let g:changelog_username = "Yuki Akamatsu(id:ukstudio) <yuki.0w0@gmail.com>"

function! s:set_short_indent()
  setlocal expandtab softtabstop=2 shiftwidth=2
endfunction

function! s:set_haskell_indent()
  setlocal expandtab softtabstop=4 shiftwidth=4
endfunction

function! s:set_review_indent()
  setlocal noexpandtab
endfunction

" template
autocmd! BufNewFile *.user.js 0r $HOME/.vim/template/greasemonkey.txt
autocmd! BufNewFile *.html    0r $HOME/.vim/template/html.txt

" 末尾のスペースをハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

"Syntax " {{{1
autocmd! BufRead,BufNewFile .vimperatorrc setfiletype vimperator

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

" ruby
autocmd MyAutoCmd FileType ruby call s:set_short_indent()
autocmd MyAutoCmd FileType ruby call s:set_filetype_ruby()
autocmd MyAutoCmd Filetype eruby set nowrap
autocmd MyAutoCmd BufWritePost *.rb :!ruby -c %

" rails.vim
let g:rails_level=4
let g:rails_default_file="app/controllers/application_controller.rb"

" rubycomplete.vim
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 0
let g:rubycomplete_classes_in_global = 1

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

" neocomplcache. " {{{2
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_snippets_dir  = '~/.vim/snippets'

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
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
command! -nargs=* Nes NeoComplCacheEditSnippets

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


" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '\h\w*'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" man.vim " {{{2
runtime ftplugin/man.vim

" vimclojure " {{{2
let clj_highlight_builtins = 1
let clj_highlight_contrib = 1
let clj_paren_rainbow = 1
let clj_want_gorilla = 1
let vimclojure#NailgunClient = "/Users/akamatsu/.clojure/vimclojure/ng"


" tagbar " {{{2
let g:tagbar_usearrows = 1
nnoremap <Leader>l :TagbarToggle<CR>

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

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
