#!/usr/bin/bash

'''
Set up a version of ubuntu that I am used too.
Set up vim with all the addons I like
Set the colour scheme
Install any packages I am used to having.
'''
import os

def main():
    """
    Run all of the main tasks.
    """

    create_bash_general_settings()

    update_bash_file()

    update_vim_file()

    return

def update_bash_file():
    """
    Update the bashrc file with the extra source file
    """

    homedir = os.path.expanduser('~')
    bashrc_location = os.path.join(homedir, ".bashrc")

    # Check if the line already exists and return if true
    with open(bashrc_location, "r+") as bashrc:
        for line in bashrc:
            if line == "source ~/.config/bash/benSettings.rc":
                print "bash file already has the correct command"
                return

    # If the line was not found append the file and return
    with open(bashrc_location, "a") as bashrc:
        bashrc.write("source ~/.config/bash/benSettings.rc")
        print "bashrc updated."

    return

def update_vim_file():
    """
    Download a new version of the .vimrc file with vundle
    """

    _home_dir = os.path.expanduser('~')
    _vim_loc = os.path.join(_home_dir, ".vimrc")
    _vim_content = get_vim_settings()

    with open(_vim_loc, "w") as _vimrc:
        _vimrc.write(_vim_content)

    # Make sure Vundle is installed
    _vundle_loc = os.path.join(_home_dir, ".vim/bundle/Vundle.vim")

    _vim_dir = os.path.join(_home_dir, ".vim")
    _bundle_dir = os.path.join(_vim_dir, "bundle")
    if not os.path.exists(_vim_dir):
        os.mkdir(_vim_dir)
    if not os.path.exists(_bundle_dir):
        os.mkdir(_bundle_dir)

    if not os.path.exists(_vundle_loc):
        print "Please install vundle with the following command"
        print "git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim"



    return

def get_vim_settings():
    """Funciton to store the vim settings"""
    vim_settings = ("""
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
"Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'alfredodeza/pytest.vim'
Plugin 'vim-syntastic/syntastic'


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
autocmd Filetype fortran setlocal expandtab tabstop=3 shiftwidth=3
autocmd Filetype python setlocal nofoldenable
autocmd Filetype tex setlocal foldmethod=syntax spell
autocmd Filetype bib setlocal foldmethod=syntax
syntax on

if has("autocmd")
  au BufReadPost * if line("'\\"") > 1 && line("'\\"") <= line("$") | exe "normal! g'\\"" | endif
endif

" Run command for python files.
"nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType python nmap <F9> :!ipython %<cr>
autocmd FileType latex nmap <F9> :!pdflatex %<cr>
autocmd FileType tex nmap <F9> :!pdflatex %<cr>
" Show the filename in the terminal top info:
let &titlestring = $USER . "@" . hostname() . " " . expand("%:p")
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\\
endif
  if &term == "screen" || &term == "xterm"
    set title
endif

let fortran_gree_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1 
let g:syntastic_auto_loc_list = 1 
let g:syntastic_check_on_open = 1 
let g:syntastic_check_on_wq = 0 



""")

    return vim_settings


def create_bash_general_settings():
    """
    Adds cross machene bashrc commmands to the local bashrc.
    """

    home_dir = os.path.expanduser('~')
    # Make sure the folder and subfolder exists
    config_dir = os.path.join(home_dir, ".config")
    bash_dir = os.path.join(config_dir, "bash")
    if not os.path.exists(config_dir):
        os.mkdir(config_dir)
    if not os.path.exists(bash_dir):
        os.mkdir(bash_dir)

    ben_settings_contents = get_bash_settings()

    settings_file_loc = os.path.join(bash_dir, "benSettings.rc")

    if not os.path.exists(settings_file_loc):
        with open(settings_file_loc, "w") as settings_file:
            settings_file.write(ben_settings_contents)
            print "benSettings.rc written to disk"
    else:
        print "benSettings.rc already exists"
    return


def get_bash_settings():
    '''
    Store for my global ~/.bashrc contents
    '''

    bash_settings = """
    alias ll='ls -alF'
    alias hello="echo HI"
    """
    return bash_settings

if __name__ == '__main__':
    main()
