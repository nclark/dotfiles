set runtimepath+=/Users/nclark/.dein/repos/github.com/Shougo/dein.vim
if dein#load_state('/Users/nclark/.config/nvim/bundle')
  call dein#begin('/Users/nclark/.config/nvim/bundle')
  call dein#add('/Users/nclark/.dein/repos/github.com/Shougo/dein.vim')

  call dein#add('icymind/NeoSolarized')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('tpope/vim-rails')
  call dein#add('w0rp/ale')
  call dein#add('dyng/ctrlsf.vim')
  call dein#add('tjennings/git-grep-vim')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('tpope/vim-surround')

  " Unite and plugins
  call dein#add('Shougo/unite.vim')
  " call dein#add('lambdalisue/unite-grep-vcs')
  " call dein#add('Shougo/vimproc.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
