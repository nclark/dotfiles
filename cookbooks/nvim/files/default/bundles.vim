call plug#begin('~/.vim/plugged')

" organize this shit
Plug 'icymind/NeoSolarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'dyng/ctrlsf.vim'
Plug 'tjennings/git-grep-vim'
Plug 'leafgarland/typescript-vim'
Plug 'kchmck/vim-coffee-script'
Plug 'elixir-editors/vim-elixir'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'

" elixir
Plug 'tpope/vim-projectionist'
Plug 'andyl/vim-projectionist-elixir'

" test running
Plug 'janko-m/vim-test'

" ctags and tagbar
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" misc
Plug 'robertmeta/nofrils'

" i forget what these are
" Plug 'w0rp/ale'
" Plug 'easymotion/vim-easymotion'

call plug#end()

