autocmd BufnewFile,BufRead *.scm nnoremap ,r :<C-u>!gosh -i < %<CR>
autocmd BufnewFile,BufRead *.scm inoremap <buffer> = =
autocmd BufnewFile,BufRead *.scm inoremap <buffer> + +
autocmd BufnewFile,BufRead *.scm inoremap <buffer> - -

autocmd FileType scheme :let is_gauche=1
