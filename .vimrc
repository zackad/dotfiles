syntax on

set nocompatible
set number
set shiftwidth=4
set expandtab ts=4 ai
set smartindent
set showcmd

set encoding=utf-8 nobomb

set rtp+=~/.vim/bundle/Vundle.vim

"-----------PLUGINS START--------------
call vundle#begin()

Plugin 'nginx.vim'
Plugin 'nerdtree'

call vundle#end()
" ----------PLUGINS END----------------

" ----------AUTO COMMAND---------------
autocmd VimEnter * NERDTree

