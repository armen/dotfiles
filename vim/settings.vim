" Colors
set t_Co=16
set t_Sb=^[[4%dm
set t_Sf=^[[3%dm

set textwidth=120
set formatoptions-=t
set formatoptions+=q
set formatoptions+=c " Auto wrap comments

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
autocmd FileType javascript,typescript command! Fmt silent! execute "%!prettier --stdin-filepath %"

" JSON Pretty Printer
autocmd BufRead,BufNewFile *.json,*.json.dist,*.enb command! Fmtjson execute "%!python -m json.tool"
autocmd BufRead,BufNewFile *.json,*.json.dist,*.enb command! Fmt execute "%!php -r 'echo json_encode(json_decode(file_get_contents(\"php://stdin\")),JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES);' 2>/dev/null"

" If you want golang integration comment out following line
let g:go_disable_autoinstall = 1
let g:go_fmt_command = "goimports"
let g:go_version_warning = 0

let g:pymode_python = 'python3'

" PDV settings
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_sidebar_width = 100

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
autocmd BufRead,BufNewFile *.js,*.ts set tabstop=2 shiftwidth=2 expandtab

" Autoformat js, ts, ...
"let g:prettier#autoformat_config_present = 1
"let g:prettier#autoformat_require_pragma = 0

" There is a bug that UltiSnips throws an error dispite the fact that python 3
" is available and installed (e.g. `:echo has("python3")` = 1)
" au VimEnter * au! UltiSnips_AutoTrigger
"

" Set the filename as the title
" BufEnter: The title will be updated as soon as the buffer is changed
"           (e.g. moving to a new split)
" Other alternatives: BufReadPost,FileReadPost,BufNewFile
" see https://vim.fandom.com/wiki/Get_the_name_of_the_current_file
" Additionally show the number of splits
autocmd BufEnter * call system("tmux rename-window -t $(tmux display-message -p -t \"\${TMUX_PANE}\" \"\#{window_index}\") '" . expand("%:t") . ( tabpagewinnr(v:lnum, '$') > 1 ? " (" . tabpagewinnr(v:lnum, '$') . ")" : "") . "'")
"
" Old version which had a bug when renaming the window title of active window instead if the window which executing the
" command
"
"autocmd BufEnter * call system("tmux rename-window '" . expand("%:t") . ( tabpagewinnr(v:lnum, '$') > 1 ? " (" . tabpagewinnr(v:lnum, '$') . ")" : "") . "'")

" Set the directory and filename as the title
"autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:r") . "." . expand("%:e"))

set mouse=nvi


" After updating https://github.com/christoomey/vim-tmux-navigator to a40cc7a commit
" the navigation stopped working, perhaps my tmux is old? The following is to revert
" the change they made
let g:tmux_navigator_no_mappings = 1
noremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>
noremap <silent> <c-\> :<C-U>TmuxNavigatePrevious<cr>

" Tab switch
nnoremap <silent> <c-x> :<C-U>tabclose<cr>
