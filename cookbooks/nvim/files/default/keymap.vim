imap jj <Esc>            		            " exit insert mode
nmap <Leader>f ggVG=<CR> 		            " format whole file
nmap <Leader>bt :!ctags-bundler<CR><CR> " generate ctags from Gemfile

nmap <D-1> 1gt  
nmap <D-2> 2gt
nmap <D-3> 3gt
nmap <D-4> 4gt
nmap <D-5> 5gt
nmap <D-6> 6gt
nmap <D-7> 7gt
nmap <D-8> 8gt
nmap <D-9> 9gt
nmap <D-LEFT> <Esc>:tabprev<CR>
nmap <D-RIGHT> <Esc>:tabnext<CR>
imap <D-1> <Esc>1gt<CR>
imap <D-2> <Esc>2gt<CR>
imap <D-3> <Esc>3gt<CR>
imap <D-4> <Esc>4gt<CR>
imap <D-5> <Esc>5gt<CR>
imap <D-6> <Esc>6gt<CR>
imap <D-7> <Esc>7gt<CR>
imap <D-8> <Esc>8gt<CR>
imap <D-9> <Esc>9gt<CR>
imap <D-LEFT> <Esc>:tabprev<CR>
imap <D-RIGHT> <Esc>:tabnext<CR>

tnoremap <esc><esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

nnoremap <leader>ci :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>cb :e ~/.config/nvim/bundles.vim<CR>
nnoremap <leader>ck :e ~/.config/nvim/keymap.vim<CR>
nnoremap <leader>cp :e ~/.config/nvim/plugin-config.vim<CR>

"" plugins

""" CtrlP
" Command-E or Ctrl-E for MRU
nmap <S-D-e> :CtrlPMRUFiles<CR>
imap <S-D-e> :CtrlPMRUFiles<CR>
nmap <S-C-e> :CtrlPMRUFiles<CR>
imap <S-C-e> :CtrlPMRUFiles<CR>

" Ctrl-B for buffer nav
nmap <S-C-b> :CtrlPBuffer<CR>
imap <S-C-b> :CtrlPBuffer<CR>


""" GitGrep
" Cmd-F
nmap <D-f> :GitGrep 
imap <D-f> <Esc>:GitGrep 

""" CtrlSF
" Cmd-Shift-F for CtrlSF
nmap <D-S-f> :CtrlSF<CR>
imap <D-S-f> <Esc>:CtrlSF<CR>

""" Ale (linter)
nmap <Leader>l :ALEToggle<CR>

""" vim-fugitive
nmap <C-A> :Gblame<CR>

""" Command-Control-Right|Left to navigate jumplist
nnoremap <D-C-Left> <C-O>
nnoremap <D-C-Right> <C-I>
