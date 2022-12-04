autocmd FileType elixir imap <Leader>d require IEx ; IEx.pry
autocmd FileType elixir nmap <Leader>d irequire IEx ; IEx.pry<Esc>
autocmd FileType ruby imap <Leader>d binding.pry
autocmd FileType ruby nmap <Leader>d ibinding.pry<Esc>
autocmd FileType terraform nnoremap <Leader>f :TerraformFmt<CR>
