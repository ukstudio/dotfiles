nnoremap ,r :<C-u>!runghc %<CR>
inoremap <expr> - smartchr#one_of(' - ', '-', ' -> ', ' <- ')
inoremap <expr> + smartchr#one_of(' + ', '+')
inoremap <expr> # smartchr#one_of('#','--')
inoremap <expr> $ smartchr#one_of(' $ ', '$')
inoremap <expr> = smartchr#one_of(' = ', ' == ', ' /= ', '=')
