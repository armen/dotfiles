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
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'

" Tool for generating PHP doc blocks
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'    " Required by pdv
Plugin 'SirVer/ultisnips'   " Required by pdv also nice plugin to use snippets in vim
Plugin 'honza/vim-snippets' " Required by pdv
Plugin 'stephpy/vim-php-cs-fixer'

" gsl.vim provides syntax highlighting for GSL templates; more information
" " about GSL can be found on iMatix's site, http://www.imatix.com/products.
Plugin 'gsl.vim'

call vundle#end()         " required
filetype plugin indent on " required
