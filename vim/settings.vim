" Colors
set t_Co=16
set t_Sb=^[[4%dm
set t_Sf=^[[3%dm

if filereadable(expand('~/.vim/bundle/vim-colors-solarized/README.mkd'))
    let g:solarized_degrade=0
    let g:solarized_bold=1
    let g:solarized_underline=1
    let g:solarized_italic=1
    let g:solarized_termtrans=1
    let g:solarized_termcolors=16

    colorscheme solarized
endif

" Paste Toggle
set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>

" Toggle numbers
nnoremap <F3> :set number!<CR>:set relativenumber!<CR>

" Toggle spell checking
nnoremap <F4> :set spell!<CR>

" Supertab settings
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" complete options (disable preview scratch window for go)
autocmd FileType go,php set completeopt=longest,menuone

" If you want golang integration comment out following line
let g:go_disable_autoinstall = 1
let g:go_fmt_command = "goimports"

" PDV settings
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

" VDebug options
let g:vdebug_options = {
\    "port" : 9000,
\    "server" : '0.0.0.0',
\    "break_on_open" : 1,
\    "ide_key" : 'xdebug',
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\}
" Also path_maps can be added above
"\    "path_maps" : { "remote/path": "local/path" }

" Filetype specific settings
autocmd BufRead,BufNewFile *.php,*.xml set expandtab
autocmd BufRead,BufNewFile *.pt   set syntax=php filetype=php
autocmd BufRead,BufNewFile *.less set syntax=less filetype=less
autocmd BufRead,BufNewFile *.rl   set syntax=ragel filetype=ragel
autocmd BufRead,BufNewFile *.twig set syntax=htmljinja
autocmd BufRead,BufNewFile *.gsl  set filetype=gsl
