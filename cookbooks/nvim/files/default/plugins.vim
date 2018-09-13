call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
  " Cmd-shift-e for MRU
  nmap <S-D-e> :CtrlPMRUFiles<CR>
  imap <S-D-e> :CtrlPMRUFiles<CR>
  nmap <S-C-e> :CtrlPMRUFiles<CR>
  imap <S-C-e> :CtrlPMRUFiles<CR>
  
  " Cmd-Shift-b for CtrlPBuffer
  " nmap <S-D-b> :CtrlPBuffer<CR>
  " imap <S-D-b> :CtrlPBuffer<CR>
  " nmap <S-C-b> :CtrlPBuffer<CR>
  " imap <S-C-b> :CtrlPBuffer<CR>
  
  " Ctrl-B for buffer nav
  nmap <S-C-b> :CtrlPBuffer<CR>
  imap <S-C-b> :CtrlPBuffer<CR>

Plug 'scrooloose/nerdcommenter'
  let g:NERDSpaceDelims = 1
  let g:NERDDefaultAlign = 'left'
  let g:NERDTrimTrailingWhitespace = 1
  let g:NERDCommentEmptyLines = 1

  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

Plug 'scrooloose/nerdtree'
  nnoremap <D-S-d> :NERDTreeTabsToggle<CR>
  inoremap <D-S-d> <Esc>:NERDTreeTabsToggle<CR>
  nnoremap <D-S-r> :NERDTreeFind<CR>
  inoremap <D-S-r> <Esc>:NERDTreeFind<CR>

Plug 'jistr/vim-nerdtree-tabs'

Plug 'tpope/vim-fugitive'
  nmap <C-A> :Gblame<CR>

Plug 'dyng/ctrlsf.vim'
  nmap <D-S-f> :CtrlSF<CR>
  imap <D-S-f> <Esc>:CtrlSF<CR>

Plug 'tjennings/git-grep-vim'
  " Cmd-F
  nmap <D-f> :GitGrep 
  imap <D-f> <Esc>:GitGrep 

Plug 'vimwiki/vimwiki'
  " note: `gem install vimwiki_markdown`

  let g:vimwiki_list = [{
            \ 'path': '~/Dropbox/vimwiki/data', 
            \ 'template_path': '~/Dropbox/vimwiki/templates/',
            \ 'template_default': 'default',
            \ 'syntax': 'markdown', 
            \ 'ext': '.md',
            \ 'path_html': '~/Dropbox/vimwiki/site_html/', 
            \ 'custom_wiki2html': 'vimwiki_markdown',
            \ 'template_ext': '.tpl',
            \ 'auto_export': 0}] " experiment with turning this on


Plug 'tpope/vim-endwise'

Plug 'tpope/vim-surround'

Plug 'terryma/vim-multiple-cursors'

Plug 'robertmeta/nofrils'

Plug 'icymind/NeoSolarized'

Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#fnamemod = ':p:.'


Plug 'vim-airline/vim-airline-themes'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#file#enable_buffer_path = 1 
  inoremap <silent><expr> <TAB>
  		\ pumvisible() ? "\<C-n>" :
  		\ <SID>check_back_space() ? "\<TAB>" :
  		\ deoplete#mappings#manual_complete()
  		function! s:check_back_space() abort "{{{
  		let col = col('.') - 1
  		return !col || getline('.')[col - 1]  =~ '\s'
  		endfunction"}}}
    
  "" Simpler version w/o backspace to go up
  " inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

Plug 'fishbullet/deoplete-ruby'

Plug 'slashmili/alchemist.vim' " completion sources for elixir

Plug 'sheerun/vim-polyglot'

" Plug 'vim-ruby/vim-ruby'

Plug 'tpope/vim-rails'

" Plug 'elixir-editors/vim-elixir'

Plug 'tpope/vim-projectionist'

Plug 'andyl/vim-projectionist-elixir'

Plug 'neomake/neomake'
  augroup localneomake
    autocmd! BufWritePost * Neomake
  augroup END

  let g:neomake_elixir_enabled_makers = ['credo_output']
  function NeomakeCredoErrorType(entry)
      if a:entry.type ==# 'F'      " Refactoring opportunities
          let type = 'W'
      elseif a:entry.type ==# 'D'  " Software design suggestions
          let type = 'I'
      elseif a:entry.type ==# 'W'  " Warnings
          let type = 'W'
      elseif a:entry.type ==# 'R'  " Readability suggestions
          let type = 'I'
      elseif a:entry.type ==# 'C'  " Convention violation
          let type = 'W'
      else
          let type = 'M'           " Everything else is a message
      endif
      let a:entry.type = type
  endfunction
  let g:neomake_elixir_credo_output_maker = {
        \ 'exe': 'mix',
        \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
        \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
        \ 'postprocess': function('NeomakeCredoErrorType')
        \ }

  " nmap <Leader>l :Neomake<CR>

" Plug 'leafgarland/typescript-vim'

" Plug 'kchmck/vim-coffee-script'

Plug 'janko-m/vim-test'
if has('nvim')
" for entering into normal mode from the test runner window (for scrolling)
  tmap <Esc> <C-\><C-n>
end

let test#strategy = "neovim"

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>  
nmap <silent> t<C-g> :TestVisit<CR>

Plug 'majutsushi/tagbar'
nmap <S-D-b> :TagbarToggle<CR>
imap <S-D-b> i:TagbarToggle<CR><Esc>

Plug 'xolox/vim-misc'

Plug 'xolox/vim-easytags'

""" i forget what these are
" Plug 'w0rp/ale'
" nmap <Leader>l :ALEToggle<CR>
"
" Plug 'easymotion/vim-easymotion'
"

Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <leader> :WhichKey ';'<CR>
set timeoutlen=500

call plug#end()
