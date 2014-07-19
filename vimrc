" .vimrc

" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

" don't highlight matched parens
let loaded_matchparen=1

set showmode            " show mode in status bar
set showcmd             " display incomplete commands
set ruler               " show the cursor position all the time
set laststatus=2        " use 2 lines for the status bar
set wildmenu            " completion with menu
set bs=indent,eol,start " allow backspacing over everything in insert mode

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4

" Suffixes that get lower priority when doing tab completion for filenames.
set suffixes=.bak,~,.swp,.o,.obj,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out.toc,.class

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" the GUI version gets more coloured options then the CLI version
if has("gui_running")
    set background=light
else
    set background=dark
endif

" Change leader to a comma because the backslash is too far away
" " That means all \x commands turn into ,x
" " The mapleader has to be set before vundle starts loading all
" " the plugins.
let mapleader=","

filetype plugin on
filetype indent on

if has("vms")
	set nobackup " do not keep a backup file, use versions instead
else
	set backup   " keep a backup file
    " don't clutter the work directories with ~backup files
    set backupdir=~/.vim/backups
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
	let myvar = strftime("%y-%m-%d_%Hh~")
	let myvar = "set backupext=_". myvar
	execute myvar
endif

" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  set undodir=~/.vim/backups
  set undofile
endif

" This loads all the plugins specified in ~/.vim/vundle.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/plugins.vim"))
	source ~/.vim/plugins.vim
endif

if filereadable(expand("~/.vim/settings.vim"))
	source ~/.vim/settings.vim
endif
