call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

set clipboard=unnamed,unnamedplus " Copy into system (*, +) register
set cursorline                    " Highlight the line where the cursor is in
set number
set relativenumber                " Show relative numbers based on the line the cursor is in
set scrolloff=6                   " Show at least <n> lines above and below the cursor, except the beginning or the end of a file
set showmatch                     " Highlight matching parenthesis, bracket, or brace
set signcolumn=yes                " Always show sign column
set updatetime=100                " Default updatetime 4000ms is not good for async update
set nowrapscan                    " Do not go back to the top when searching
set ignorecase                    " Do case-insensitive search
set smartcase                     " When the search text contains uppercase characters, do case-sensitive search
set expandtab                     " Use soft tabs
set shiftwidth=4                  " Number of spaces to use for autoindent
set tabstop=4                     " Number of spaces a tab is counted for

colorscheme dracula               " Change the color scheme

autocmd BufWritePre * %s/\s\+$//e
