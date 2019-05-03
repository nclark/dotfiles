if &compatible
  set nocompatible
endif

set encoding=utf8

source ~/.config/nvim/plugins.vim

let mapleader=";"
filetype on
filetype indent on
filetype plugin on
syntax on

set termguicolors
colorscheme NeoSolarized

set showcmd
set ruler
set textwidth=100
set formatoptions-=t " turn off autowarp. !!fmt for life
set number
set noeb vb t_vb= "die in a fire, visual bell
set background=light
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline

" folding - http://www.linode.com/wiki/index.php/Vim_Tutorial
set foldenable
set foldmethod=indent
set foldlevel=100
set foldopen-=undo

" autosave
autocmd BufLeave,FocusLost * silent! wall

" source neovim config when it changes
augroup AutoCommands
  autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
  autocmd BufWritePost ~/.config/nvim/plugins.vim source ~/.config/nvim/plugins.vim
  autocmd BufWritePost ~/.config/nvim/keymap.vim source ~/.config/nvim/keymap.vim
  autocmd BufWritePost ~/.config/nvim/elixirtmp.vim source ~/.config/nvim/elixirtmp.vim
  autocmd BufWritePost ~/.config/nvim/vimwiki.vim source ~/.config/nvim/vimwiki.vim
augroup END

" WIP - autowrap markdow files
" au BufRead, BufNewFile *.md setlocal tw=72 fo=cqt wm=0

source ~/.config/nvim/keymap.vim
source ~/.config/nvim/elixirtmp.vim
