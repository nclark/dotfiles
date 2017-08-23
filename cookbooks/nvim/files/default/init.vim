if &compatible
  set nocompatible
endif

source ~/.config/nvim/bundles.vim

let mapleader=";"
filetype plugin indent on
syntax on
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
  autocmd BufWritePost ~/.config/nvim/bundles.vim source ~/.config/nvim/bundles.vim
  autocmd BufWritePost ~/.config/nvim/keymap.vim source ~/.config/nvim/keymap.vim
  autocmd BufWritePost ~/.config/nvim/plugin-config.vim source ~/.config/nvim/plugin-config.vim
augroup END

source ~/.config/nvim/plugin-config.vim
source ~/.config/nvim/keymap.vim
