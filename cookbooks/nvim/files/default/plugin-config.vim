source ~/.config/nvim/vimwiki.vim

let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1 
let g:airline#extensions#tabline#enabled = 1
" imap <expr><TAB>
" 	 \ neosnippet#expandable_or_jumpable() ?
" 	 \    "\<Plug>(neosnippet_expand_or_jump)" :
"        \     pumvisible() ? "\<C-n>" : "\<TAB>"
" 
" vim-airline tab bar config
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':p:.'

"" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCommentEmptyLines = 1


