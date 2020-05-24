" Manage plugins with vim-plug
call plug#begin()

" Language support
Plug 'cespare/vim-toml'
Plug 'dag/vim-fish'

" Utilities
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdcommenter'
Plug 'scrooloose/nerdtree'

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Language Server
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'

call plug#end()

colorscheme dracula                " Change the color scheme
syntax on                          " Enable syntax highlighting
filetype plugin indent on          " Enable file type based indentation

" General text editing
set backspace=indent,eol,start     " Fix backspace behavior on most terminals
set clipboard=unnamed,unnamedplus  " Copy into system (*, +) register
set colorcolumn=80                 " Draw vertical line at the column <n>
set cursorline                     " Highlight the line where the cursor is in
set laststatus=2                   " Always display the status line
set relativenumber                 " Show relative numbers based on the line the cursor is in
set scrolloff=5                    " Show at least <n> lines above and below the cursor, except the beginning or the end of a file
set showcmd                        " Show last command in the status line
set showmatch                      " Highlight matching parenthesis, bracket, or brace
set wildmenu                       " Enable enhanced tab autocomplete
set wildmode=list:longest,full     " Complete till longest string, then open the wildmenu
set signcolumn=yes

" Search and matching
set hlsearch                       " Highlight matchings
set ignorecase                     " Do case-insensitive search
set incsearch                      " Search incrementally
set nowrapscan                     " Do not go back to the top when searching
set smartcase                      " When the search text contains uppercase characters, do case-sensitive search

" Indentation
set autoindent                     " Respect indentation when starting a new line
set expandtab                      " Use soft tabs
set shiftwidth=4                   " Number of spaces to use for autoindent
set tabstop=4                      " Number of spaces a tab is counted for

" Folding
set foldmethod=indent              " Fold code based on indentation
" Keep every fold open when startup
autocmd BufRead * normal zR

" Make some whitespace characters visible
set list
set listchars=tab:\\_,trail:_

" Swap file
set swapfile
if !isdirectory(expand("$HOME/.vim/swap"))
    call mkdir(expand("$HOME/.vim/swap"), "p")
endif
set directory=$HOME/.vim/swap//

" Set up persistent undo across all files
set undofile
if !isdirectory(expand("$HOME/.vim/undo"))
    call mkdir(expand("$HOME/.vim/undo"), "p")
endif
set undodir=$HOME/.vim/undo

" Spell checking
set spell
set spelllang=en_us

" Fast split navigation with <Ctrl> + hjkl
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" Remove trailing whitespace automatically
autocmd BufWritePre * %s/\s\+$//e

let mapleader = ','  " Map the leader key to a comma

" NERD Commenter
let g:NERDSpaceDelims = 1  " Add a space after a comment delimiter

" fzf
set runtimepath+=/usr/local/opt/fzf
noremap <leader>f :Files<cr>

" NERDTree
noremap <leader>n :NERDTreeToggle<cr>

" Undotree
noremap <leader>u :UndotreeToggle<cr>

" vim-lsp
noremap <leader>b :LspDefinition<cr>

" vim-gitgutter
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
