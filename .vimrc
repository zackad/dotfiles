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
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'crusoexia/vim-monokai'
Plugin 'ryanoasis/vim-devicons'

call vundle#end()
" ----------PLUGINS END----------------

" ----------AUTO COMMAND---------------
autocmd VimEnter * NERDTree

" ----------CONFIGURATION--------------
colorscheme monokai
set guifont=Roboto\ Mono\ Nerd\ Font\ Complete\ 8
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" ----------REMAP KEY------------------
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l

" NERDTree Related Configuration
nnoremap <F6> :NERDTreeToggle<CR>
