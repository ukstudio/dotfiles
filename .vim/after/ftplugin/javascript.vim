let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/javascript.dict'

" smartchr.vim
inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
inoremap <expr> + smartchr#one_of(' + ', ' += ', '+')
inoremap <expr> - smartchr#one_of(' - ', ' -= ', '-')
inoremap <expr> ! smartchr#one_of('!',   ' != ')
