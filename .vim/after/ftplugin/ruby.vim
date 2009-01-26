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

autocmd! BufWritePost *.rb :!ruby -c %
autocmd! BufNewFile,BufRead *.rb nnoremap ,r :<C-u>!ruby %<CR>
autocmd BufNewFile,BufRead *_spec.rb nnoremap ,sp :<C-u>!spec %<CR>
