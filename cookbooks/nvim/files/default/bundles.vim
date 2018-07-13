call plug#begin('~/.vim/plugged')

" organize this shit
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'dyng/ctrlsf.vim'
Plug 'tjennings/git-grep-vim'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'robertmeta/nofrils'

" appearance
Plug 'icymind/NeoSolarized'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby'
Plug 'slashmili/alchemist.vim' " completion sources for elixir

""""" languages
" ruby / rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" elixir / phoenix
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-projectionist'
Plug 'andyl/vim-projectionist-elixir'

" other languages
Plug 'leafgarland/typescript-vim'
Plug 'kchmck/vim-coffee-script'

" test running
Plug 'janko-m/vim-test'

""""" another header
" ctags and tagbar
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" misc

" i forget what these are
" Plug 'w0rp/ale'
" Plug 'easymotion/vim-easymotion'

call plug#end()

