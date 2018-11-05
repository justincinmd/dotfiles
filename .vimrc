" Command T
let g:CommandTMaxFiles=50000


" Vundle load
filetype on " Fixes a non-zero exit status if filetype is already off
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Other plugins
Plugin 'klen/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'gcmt/taboo.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'vim-ruby/vim-ruby'
Plugin 'rking/ag.vim'
Plugin 'fatih/vim-go'
Plugin 'Shougo/neocomplete.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'rust-lang/rust.vim'

call vundle#end()

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
if isdirectory(glob("~/.vim/bundle/vim-colors-solarized"))
    colorscheme solarized
endif

" Pymode
" Comma-delimited list
let g:pymode_lint_ignore='E501'

" Pymode
" Disable rope - see https://github.com/klen/python-mode/issues/465
let g:pymode_rope=0
let g:pymode_folding=0

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
function! YelpSettings()
    setlocal expandtab      " don't turn them into space
    setlocal shiftwidth=4   " auto-indent width
    setlocal tabstop=4      " display width of a physical tab character
    setlocal softtabstop=0  " disable part-tab-part-space tabbing
endfunction
autocmd BufNewFile,BufRead ~/pg/* call YelpSettings()

" Alternative Tabs
autocmd BufNewFile,BufRead Makefile setlocal noexpandtab
autocmd FileType make setlocal noexpandtab

" Go Tabs
function! GoTabSettings()
    setlocal noexpandtab
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal softtabstop=2
endfunction
autocmd BufNewFile,BufRead *.go call GoTabSettings()

" CPP Tabs
function! CPPTabSettings()
    setlocal expandtab
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal softtabstop=2
endfunction
autocmd BufNewFile,BufRead *.cpp call CPPTabSettings()
autocmd BufNewFile,BufRead *.h call CPPTabSettings()


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
:nnoremap <leader>t :CtrlP<CR>
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|target)$'

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

" Turn On Spellcheck
" setlocal spell

" Disable some command-t files
set wildignore+=*.pyc
set wildignore+=virtualenv_run

" Go setup
let g:go_fmt_command = "goimports"
autocmd BufWritePost *.go :GoMetaLinter
au FileType go nmap <leader>g <Plug>(go-test)

" Rust Setup
let g:rustfmt_autosave = 1

" Show line numbers by default
:set number

" Start neocomplete
let g:neocomplete#enable_at_startup = 1
