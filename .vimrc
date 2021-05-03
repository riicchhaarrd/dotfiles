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

"autocmd FileType php set omnifunc=phpcomplete#CompletePHP

filetype plugin on
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS

" status line thanks to https://shapeshed.com/vim-statuslines/
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

" Use YouCompleteMe plugin

"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"filetype on

" easy resize shortcuts for splits

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
