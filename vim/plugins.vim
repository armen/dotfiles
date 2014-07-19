filetype off " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'joonty/vdebug.git'
Plugin 'ervandew/supertab'
Plugin 'dimasg/vim-mark'
Plugin 'Conque-GDB'
Plugin 'bogado/file-line'
Plugin 'altercation/vim-colors-solarized'

" Golang completion and syntax
Plugin 'undx/vim-gocode'
Plugin 'jnwhiteh/vim-golang'

" Tool for generating PHP doc blocks
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'    " Required by pdv
Plugin 'SirVer/ultisnips'   " Required by pdv also nice plugin to use snippets in vim
Plugin 'honza/vim-snippets' " Required by pdv

call vundle#end()         " required
filetype plugin indent on " required
