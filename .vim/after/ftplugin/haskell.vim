autocmd BufNewFile,BufRead *.hs nnoremap ,r :<C-u>!runghc %<CR>
autocmd BufnewFile,BufRead *.hs inoremap <expr> - smartchr#one_of('->', '-')
autocmd BufnewFile,BufRead *.hs inoremap <expr> $ smartchr#one_of(' $ ', '$')
