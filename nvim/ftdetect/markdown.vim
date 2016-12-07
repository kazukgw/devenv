autocmd BufNewFile,BufRead *.md setlocal filetype=markdown softtabstop=2
autocmd BufNewFile,BufRead todo.md setlocal filetype=markdown foldmethod=marker
autocmd BufNewFile,BufRead log.md setlocal filetype=markdown foldmethod=marker foldlevel=0
autocmd BufNewFile,BufRead log.*.md setlocal filetype=markdown foldmethod=marker foldlevel=0
autocmd Filetype markdown setlocal softtabstop=2
