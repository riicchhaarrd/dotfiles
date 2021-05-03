" to open file explorer type :Lexplore
" this file works for neovim aswell, just copy or make a symlink to it at location ~/.config/nvim/init.vim
" useful small vim stuff
" # sorting files
" :sort u
" # remove duplicates
" :%!uniq
" # remove more than 1 whitespace (c is confirm, g is all)
" %s/  \+/ /gc 
" # disable wrapping of text
" :set nowrap
" # disable vim automatically wrapping long text (long line auto broken)
" :set tw=0
"
set noswapfile

if has("gui_running")
    autocmd VIMEnter * :source ~/Session.vim
    autocmd VIMLeave * :mksession! ~/Session.vim
    set sessionoptions+=resize,winpos
    set guioptions -=m
    set guioptions -=T
    set guifont=Consolas\ for\ Powerline\ 10
    " i think this is already the default so nvm
    "nnoremap <c-q> <c-v>
endif

set clipboard=unnamedplus

"if has("gui_running")
"    set lines=35 columns=150
"    winpos 735 294
"endif

set number
syntax on
set cindent
set number
set linebreak
set showbreak=+++
set textwidth=100
set showmatch
set visualbell

set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4


set ruler

set undolevels=1000
set backspace=indent,eol,start


colorscheme onehalflight

set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"nnoremap <C-Left> :tabprevious<CR>
"nnoremap <C-Right> :tabnext<CR>
"nnoremap <silent> <A-Left> :tabm -1<CR>
"nnoremap <silent> <A-Right> :tabm +1<CR>

vnoremap > >gv
vnoremap < <gv

nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"inoremap <silent> <Up> <ESC><Up>
"inoremap <silent> <Down> <ESC><Down>
inoremap jj <Esc>
inoremap jk <Esc>

nnoremap <CR> :noh<CR><CR>
"set mouse=i
set whichwrap+=<,>,h,l,[,]
set mouse=a
source $VIMRUNTIME/mswin.vim

" reset ctrl + f (forward) and ctrl + b (backwards) scrolling
nnoremap <C-f> <PageUp>
nnoremap <C-b> <PageDown>

inoremap <C-f> <PageUp>
inoremap <C-b> <PageDown>
inoremap <C-t> <C-o>de
" Reset ctrl + i back to jumplist
silent! unmap <C-i>
