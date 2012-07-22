set nocompatible               " be iMproved
filetype off                   " required!

call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Shougo/neocomplcache'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'tomtom/tcomment_vim'
" Bundle 'camelcasemotion'

" Bundle settings
let g:neocomplcache_enable_at_startup = 1

syntax on
filetype plugin indent on     " required!

let mapleader="," " change the mapleader from \ to ,

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set background=dark
set autoread                  " watch for file changes
set hidden
set autochdir
set noautowrite               " don't automagically write on :next
set lazyredraw                " don't redraw when don't have to
set autoindent smartindent    " auto/smart indent
set smarttab                  " tab and backspace are smart
set expandtab
set tabstop=4                 " 6 spaces
set softtabstop=4
set shiftwidth=4
set shiftround
set preserveindent
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set history=200
set backspace=indent,eol,start
set linebreak
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
" set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
" set completeopt=menu,longest,preview
set noerrorbells              " No error bells please
set shell=bash
set fileformats=unix
set ff=unix
set laststatus=2                " Show statusline allways
set encoding=utf-8              " Necessary to show unicode glyphs

"  searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync

" ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.orig,*/cache/*

"  backup
set nobackup
set noswapfile

set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo

" spelling
if v:version >= 700
  " Enable spell check for text files
  autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif

" MAPPINGS
set pastetoggle=<F2>                        " toggle list mode
nmap <Leader>nn :set number! number?<cr>    " toggle numbers
inoremap jj <ESC>                           " escape quickly
" replace : with ;
nore ; :
nore , ;

" Plugins settings and mapping
map <Leader>b :CtrlPBuffer<cr>
map <Leader>o :FufFile<cr>
map <Leader>e :CtrlPMRUFile<cr>
map <Leader>l :CtrlPBufTag<cr>
map <Leader>L :CtrlPBufTagAll<cr>
map <Leader>p :CtrlP<cr>
map <Leader>t :TagbarToggle<cr>

" format a paragraph
vmap Q gq
nmap Q gqap

" save a read only file using sudo tee %
cnoreabbrev <expr> w!!
                \((getcmdtype() == ':' && getcmdline() == 'w!!')
                \?('!sudo tee % >/dev/null'):('w!!'))

" remember last position
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

