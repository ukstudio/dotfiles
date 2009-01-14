"autocmd! BufWritePost *.php :!php -l %
autocmd BufnewFile,BufRead *.php nnoremap ,r :<C-u>!php %<CR>
