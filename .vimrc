syntax on

set nocompatible
set number
set showcmd
set termguicolors

set encoding=utf-8 nobomb

set rtp+=~/.vim/bundle/Vundle.vim

"-----------PLUGINS START--------------
call vundle#begin()

Plugin 'editorconfig/editorconfig-vim'
Plugin 'nginx.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'crusoexia/vim-monokai'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'Yggdroot/indentLine'
" Syntax and color scheme
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
" ----------PLUGINS END----------------

" ----------AUTO COMMAND---------------
autocmd VimEnter * NERDTree

" ----------CONFIGURATION--------------
colorscheme gruvbox
set background=dark
let g:indentLine_char = '┊'
" let g:indentLine_leadingSpaceEnabled = 1

" ----------REMAP KEY------------------
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l

" ----------------NERDTree Related Configuration------------------------
nnoremap <F6> :NERDTreeToggle<CR>
set guifont=Dejavu\ Sans\ Mono\ Nerd\ Font\ Complete\ 8
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" Highlight fullname (not only icons)
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
