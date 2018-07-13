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

" wtf does this do 
" tnoremap <esc><esc> <C-\><C-n>
" tnoremap <C-h> <C-\><C-n><C-w>h
" tnoremap <C-j> <C-\><C-n><C-w>j
" tnoremap <C-k> <C-\><C-n><C-w>k
" tnoremap <C-l> <C-\><C-n><C-w>l

" split resizing
nnoremap <C-.> <C-w>>
nnoremap <C-,> <C-w><

" config editing
nnoremap <leader>ci :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>cb :e ~/.config/nvim/bundles.vim<CR>
nnoremap <leader>ck :e ~/.config/nvim/keymap.vim<CR>
nnoremap <leader>cp :e ~/.config/nvim/plugin-config.vim<CR>

" copy to system keyboard
vnoremap <C-S-c> "*y<CR>
vnoremap <D-S-c> "*y<CR>

"" plugins

""" NERDTree
nnoremap <D-S-d> :NERDTreeTabsToggle<CR>
inoremap <D-S-d> <Esc>:NERDTreeTabsToggle<CR>
nnoremap <D-S-r> :NERDTreeFind<CR>
inoremap <D-S-r> <Esc>:NERDTreeFind<CR>

""" NERDCommenter
map <D-/> <plug>NERDCommenterToggle<CR>
imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

""" CtrlP
" Command-Shift-e for CtrlPMRUFiles
nmap <S-D-e> :CtrlPMRUFiles<CR>
imap <S-D-e> :CtrlPMRUFiles<CR>
nmap <S-C-e> :CtrlPMRUFiles<CR>
imap <S-C-e> :CtrlPMRUFiles<CR>

" Cmd-Shift-b for CtrlPBuffer
nmap <S-D-b> :CtrlPBuffer<CR>
imap <S-D-b> :CtrlPBuffer<CR>
nmap <S-C-b> :CtrlPBuffer<CR>
imap <S-C-b> :CtrlPBuffer<CR>

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

""""" snippets
imap <leader>bb ::Kernel.byebug
nmap <leader>bb i::Kernel.byebug<Esc>

""" tabar
imap <D-B> i:TagbarToggle<CR><Esc>
nmap <D-B> :TagbarToggle<CR>

" open ctag in tab/vertical split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <leader><C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

imap <leader>h <Esc>:noh<CR>i
nmap <leader>h :noh<CR>

""" vim-test
" for entering into normal mode from the test runner window (for scrolling)
if has('nvim')
  tmap <Esc> <C-\><C-n>
end

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>  
nmap <silent> t<C-g> :TestVisit<CR>
