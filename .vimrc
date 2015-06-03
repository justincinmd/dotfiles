" Command T
let g:CommandTMaxFiles=50000


" Pathogen load
filetype on " Fixes a non-zero exit status if filetype is already off
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

" Search highlight
set hlsearch
:noremap <F4> :set hlsearch! hlsearch?<CR>

" Make backspace work
set backspace=indent,eol,start

" Python Syntax
let g:syntastic_python_checkers = ['pep8']
let g:syntastic_python_pep8_args='--ignore=E501,W191'


function! GetCurrentGitBranch()
    return system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
endfunction

" GitSessions (Switched to Vim-Sessions)
" TODO: Add loading and saving of current branch
" nnoremap <leader>ss :SaveSession <C-R>=GetCurrentGitBranch()<cr>
" nnoremap <leader>ls :GitSessionLoad<cr>
" nnoremap <leader>ds :GitSessionDelete<cr>

" Redundant Space Highligting
highlight RedundantSpaces ctermbg=red
match RedundantSpaces /\s\+$/
autocmd ColorScheme * highlight RedundantSpaces ctermbg=red
autocmd SessionLoadPost * highlight RedundantSpaces ctermbg=red

" Color Scheme
set term=screen-256color

syntax enable
set background=dark
colorscheme solarized

" Pymode
" Comma-delimited list
let g:pymode_lint_ignore='E501'

" Taboo
let g:taboo_tab_format=' %w %f%m '
let g:taboo_renamed_tab_format=' %w [%f]%m '
set sessionoptions+=tabpages,globals " Save the tab names

" Default Tabs
set expandtab
set shiftwidth=2
set tabstop=4
set softtabstop=0

" Yelp
function YelpSettings()
    setlocal expandtab      " don't turn them into space
    setlocal shiftwidth=4   " auto-indent width
    setlocal tabstop=4      " display width of a physical tab character
    setlocal softtabstop=0  " disable part-tab-part-space tabbing
endfunction
autocmd BufNewFile,BufRead ~/pg/* call YelpSettings()

" Alternative Tabs
autocmd BufNewFile,BufRead Makefile setlocal noexpandtab
autocmd FileType make setlocal noexpandtab


" Importly
function! Importly()
    w
    silent !~/pg/yelp-main/tools/importly %
    edit
    redraw!
endfunction
command! Importly call Importly()


" Status Line
" Switched off - using vim-airline
" set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set guifont=Inconsolata\ for\ Powerline:h12
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Gutter
set colorcolumn=80

" Session autosave
let g:session_autosave = 0
let g:session_autoload = 0

" Set CommandT Flush
:nnoremap <leader>f :CommandTFlush<CR>

" Delete trailing white space
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,yaml autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre Vagrantfile :call <SID>StripTrailingWhitespaces()
:nnoremap <leader>s :call <SID>StripTrailingWhitespaces()<CR>
