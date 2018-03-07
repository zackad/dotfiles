syntax on

set nocompatible
set number
set shiftwidth=4
set expandtab ts=4 ai
set smartindent
set showcmd
set t_Co=256

set encoding=utf-8 nobomb

set rtp+=~/.vim/bundle/Vundle.vim

"-----------PLUGINS START--------------
call vundle#begin()

Plugin 'editorconfig/editorconfig-vim'
Plugin 'nginx.vim'
Plugin 'nerdtree'
Plugin 'crusoexia/vim-monokai'

call vundle#end()
" ----------PLUGINS END----------------

" ----------AUTO COMMAND---------------
autocmd VimEnter * NERDTree

" ----------CONFIGURATION--------------
colorscheme monokai
