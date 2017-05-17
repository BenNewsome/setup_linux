set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ascenator/L9', {'name': 'newL9'}
" Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'alfredodeza/pytest.vim'
"Plugin 'wookiehangover/jshint.vim'
" Plugin 'tell-k/vim-autopep8'
"Plugin 'vim-syntastic/syntastic'
" Asyncronous linting
Plugin 'w0rp/ale'


call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Speed up jedi autocomplete
let g:pymode_rope = 0

set tabstop=4
set expandtab
set foldmethod=indent
set backspace=indent,eol,start
set shiftwidth=4
set foldlevelstart=3
set spelllang=en_gb
set background=dark

filetype on
filetype plugin on


autocmd Filetype fortran let &colorcolumn=join(range(79,85),",")
autocmd Filetype python let &colorcolumn=join(range(79,80),",")
set number
let g:tex_fold_enabled=1
autocmd Filetype fortran setlocal expandtab tabstop=3 shiftwidth=3 ignorecase
autocmd Filetype python setlocal nofoldenable
autocmd Filetype tex setlocal foldmethod=syntax spell
autocmd Filetype bib setlocal foldmethod=syntax
syntax on

" Match IF and ENDIF in fortran
runtime macros/matchit.vim

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Run command for python files.
"nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType python nmap <F9> :!ipython %<cr>
autocmd FileType python nmap <F10> :!py.test %<cr>
autocmd FileType latex nmap <F9> :!make<cr>
autocmd FileType tex nmap <F9> :!make<cr>
" Show the filename in the terminal top info:
let &titlestring = $USER . "@" . hostname() . " " . expand("%:p")
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
  if &term == "screen" || &term == "xterm"
    set title
endif

let fortran_gree_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%*
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']



let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Python linter settings for python 3 forward compatability.
let g:ale_python_pylint_options = '--py3k --enable=all'

