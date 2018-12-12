set fenc=utf-8

" Detect filetype from filename
" Enable indent and plugin for each filetype
" (http://vim-jp.org/vimdoc-ja/filetype.html)
filetype indent plugin on

" Show darkgray line number
set number
highlight LineNr ctermfg=darkgray

" Make no swap files
set noswapfile

" Show cursor's current row and col
set ruler

" Show currently inputting command
set showcmd

" Enable syntax highlight
syntax on

" Show corresponding parenthese(bracket, brace) when closing them
set showmatch

" Use system native clipboard
set clipboard+=unnamed

" Use 2 spaces instead of hard tab
set expandtab
set tabstop=2

" Ignore case on searching if search string consists only of lowercase letters
set smartcase

" Enable auto indent
set autoindent

" Enable smart indent
set smartindent

" Set auto-indent as 2 spaces
set shiftwidth=2

" Go back to the top of the file if get to the bottom when searching
set wrapscan

" Enable incremental search
set incsearch
