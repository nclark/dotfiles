call plug#begin('~/.vim/plugged')

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

let g:LanguageClient_serverCommands = {
    \ 'terraform': ['terraform-ls', 'serve'],
    \ }

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" let g:deoplete#enable_at_startup = 1
"
" inoremap <silent><expr> <TAB>
" 		\ pumvisible() ? "\<C-n>" :
" 		\ <SID>check_back_space() ? "\<TAB>" :
" 		\ deoplete#mappings#manual_complete()
" 		function! s:check_back_space() abort "{{{
" 		let col = col('.') - 1
" 		return !col || getline('.')[col - 1]  =~ '\s'
" 		endfunction"}}}


"""""""""""""""""
"               "
" Color Schemes "
"               "
"""""""""""""""""
Plug 'icymind/NeoSolarized'
Plug 'dikiaap/minimalist'
Plug 'NLKNguyen/papercolor-theme'

" Plug 'slashmili/alchemist.vim' " completion sources for elixir

" Plug 'powerman/vim-plugin-AnsiEsc'

" Plug 'scrooloose/nerdcommenter'
"   let g:NERDSpaceDelims = 1
"   let g:NERDDefaultAlign = 'left'
"   let g:NERDTrimTrailingWhitespace = 1
"   let g:NERDCommentEmptyLines = 1
" 	let g:NERDTreeHijackNetrw=0
" 
"   map <D-/> <plug>NERDCommenterToggle<CR>
"   imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
nnoremap <D-S-d> :NvimTreeToggle<CR>
inoremap <D-S-d> <Esc>:NvimTreeToggle<CR>

" Plug 'jistr/vim-nerdtree-tabs'

Plug 'tpope/vim-fugitive'
  nmap <C-A> :Git blame<CR>

" Plug 'dyng/ctrlsf.vim'
"   nmap <D-S-f> :CtrlSF<CR>
"   imap <D-S-f> <Esc>:CtrlSF<CR>

Plug 'tjennings/git-grep-vim'
  " Cmd-F
  nmap <D-f> :GitGrep 
  imap <D-f> <Esc>:GitGrep 

" Plug 'tpope/vim-endwise'

" Plug 'tpope/vim-surround'

" Plug 'terryma/vim-multiple-cursors'

" Plug 'robertmeta/nofrils'

Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#fnamemod = ':p:.'

  " show tab number next to name instead of split count
  let g:airline#extensions#tabline#tab_nr_type = 1


Plug 'vim-airline/vim-airline-themes'

Plug 'sheerun/vim-polyglot'

" Plug 'tpope/vim-rails'

" Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'

" Plug 'tpope/vim-projectionist'
" 
" Plug 'andyl/vim-projectionist-elixir'

" Plug 'neomake/neomake'
"   augroup localneomake
"     autocmd! BufWritePost * Neomake
"   augroup END
" 
"   let g:neomake_elixir_enabled_makers = ['credo_output']
"   function NeomakeCredoErrorType(entry)
"       if a:entry.type ==# 'F'      " Refactoring opportunities
"           let type = 'W'
"       elseif a:entry.type ==# 'D'  " Software design suggestions
"           let type = 'I'
"       elseif a:entry.type ==# 'W'  " Warnings
"           let type = 'W'
"       elseif a:entry.type ==# 'R'  " Readability suggestions
"           let type = 'I'
"       elseif a:entry.type ==# 'C'  " Convention violation
"           let type = 'W'
"       else
"           let type = 'M'           " Everything else is a message
"       endif
"       let a:entry.type = type
"   endfunction
"   let g:neomake_elixir_credo_output_maker = {
"         \ 'exe': '/Users/nclark/.asdf/shims/mix',
"         \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
"         \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
"         \ 'postprocess': function('NeomakeCredoErrorType')
"         \ }

  " nmap <Leader>l :Neomake<CR>

" Plug 'janko-m/vim-test'
" if has('nvim')
" " for entering into normal mode from the test runner window (for scrolling)
"   tmap <Esc> <C-\><C-n>
" end
" 
" let test#strategy = "neovim"
" 
" nmap <silent> t<C-n> :TestNearest<CR>
" nmap <silent> t<C-f> :TestFile<CR>
" nmap <silent> t<C-s> :TestSuite<CR>
" nmap <silent> t<C-l> :TestLast<CR>  
" nmap <silent> t<C-g> :TestVisit<CR>

Plug 'majutsushi/tagbar'
nmap <S-D-b> :TagbarToggle<CR>
imap <S-D-b> i:TagbarToggle<CR><Esc>

Plug 'xolox/vim-misc'

" Plug 'liuchengxu/vim-which-key'
" nnoremap <silent> <leader> :WhichKey ';'<CR>
" set timeoutlen=500
" 
" Plug 'rizzatti/dash.vim'
" nnoremap <Leader>k :Dash<CR>
" Plug 'ludovicchabant/vim-gutentags'

Plug 'fladson/vim-kitty'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" FZF Files
nnoremap <silent> <c-p> :Files<cr>
inoremap <silent> <c-p> :Files<cr>

nnoremap <S-D-e> :History<CR>
inoremap <S-D-e> :History<CR>

" FZF Buffer
nnoremap <leader>b :Buffer<cr>

call plug#end()

lua require("nvim-tree").setup()

