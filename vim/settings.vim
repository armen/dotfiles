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

let g:php_cs_fixer_path = "php-cs-fixer"       " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "all"               " which level ?
let g:php_cs_fixer_config = "default"          " configuration
let g:php_cs_fixer_php_path = "php"            " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 0  " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                 " Call command with dry-run option
let g:php_cs_fixer_verbose = 1                 " Return the output of command if 1, else an inline information.
let g:php_cs_fixer_fixers_list = "-lowercase_constants,-concat_without_spaces,-operators_spaces,-empty_return,-no_empty_lines_after_phpdocs,ordered_use,short_array_syntax"
autocmd FileType php command! Fmt silent! undojoin | silent! call PhpCsFixerFixFile() | edit!

" JSON Pretty Printer
autocmd BufRead,BufNewFile *.json,*.json.dist,*.enb command! Fmtjson execute "%!python -m json.tool"
autocmd BufRead,BufNewFile *.json,*.json.dist,*.enb command! Fmt execute "%!php -r 'echo json_encode(json_decode(file_get_contents(\"php://stdin\")),JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES);'"

" If you want golang integration comment out following line
let g:go_disable_autoinstall = 1
let g:go_fmt_command = "goimports"
let g:go_version_warning = 0

let g:pymode_python = 'python3'

" PDV settings
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

" VDebug options
let g:vdebug_features = {'extended_properties': 1} " https://github.com/vim-vdebug/vdebug/issues/369
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
"

let g:php_manual_online_search_shortcut = '<C-g>'

" Filetype specific settings
autocmd BufRead,BufNewFile *.php,*.xml set expandtab
autocmd BufRead,BufNewFile *.pt   set syntax=php filetype=php
autocmd BufRead,BufNewFile *.less set syntax=less filetype=less
autocmd BufRead,BufNewFile *.rl   set syntax=ragel filetype=ragel
autocmd BufRead,BufNewFile *.twig set syntax=htmljinja
autocmd BufRead,BufNewFile *.gsl  set filetype=gsl
autocmd BufRead,BufNewFile *.md   set filetype=markdown
autocmd BufRead,BufNewFile *.json.dist set filetype=json
autocmd BufRead,BufNewFile *.enb set filetype=json

" There is a bug that UltiSnips throws an error dispite the fact that python 3
" is available and installed (e.g. `:echo has("python3")` = 1)
" au VimEnter * au! UltiSnips_AutoTrigger
