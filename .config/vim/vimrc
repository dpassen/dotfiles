""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PREREQUISITES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype indent plugin on
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set bg=light
set hidden
set wildmenu
set showcmd
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set t_vb=
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set number
set noscb
set splitright
map Y y$
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
autocmd VimResized * :wincmd =
autocmd BufWritePre * :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FEARLESS LEADER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUZZY FINDING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=**
set wildmenu
nnoremap <silent> <leader><leader> :find<space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :vsp %%
map <leader>s :sp %%
map <leader>h :sp %%
