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

" copy path to clipboard
nmap <Leader>cp :let @*=expand("%")<CR>

" copy path:current_line to clipboard
nmap <Leader>cpl :let @*=expand("%") . ":" . line(".")<CR>

" split resizing
nnoremap <C-.> <C-w>>
nnoremap <C-,> <C-w><
" config editing
nnoremap <leader>ci :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>cb :e ~/.config/nvim/plugins.vim<CR>
nnoremap <leader>ck :e ~/.config/nvim/keymap.vim<CR>

" copy to system keyboard
vnoremap <C-S-c> "*y<CR>
vnoremap <D-S-c> "*y<CR>

""" Command-Control-Right|Left to navigate jumplist
nnoremap <D-C-Left> <C-O>
nnoremap <D-C-Right> <C-I>

""""" snippets
imap <leader>bb ::Kernel.byebug
nmap <leader>bb i::Kernel.byebug<Esc>

" open ctag in tab/vertical split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <leader><C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

imap <leader>h <Esc>:noh<CR>i
nmap <leader>h :noh<CR>

""" Mix Format
imap <leader>mf <Esc>:w<CR>:MixFormat<CR>
nmap <leader>mf :w<CR>:MixFormat<CR>
