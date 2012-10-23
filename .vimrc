set nocompatible               " be iMproved
filetype off                   " required!

call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" General {
    Bundle 'L9'
    Bundle 'FuzzyFinder'
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'scrooloose/syntastic'
    Bundle 'scrooloose/nerdtree'
    Bundle 'majutsushi/tagbar'
    Bundle 'kien/ctrlp.vim'
    Bundle 'tomtom/tcomment_vim'
    Bundle 'Townk/vim-autoclose'
    Bundle 'vim-scripts/sessionman.vim'
    Bundle 'godlygeek/tabular'
    Bundle 'tpope/vim-pastie'
" }

" Specific {
    " PHP
    Bundle 'spf13/PIV' 
    " Python
    " Bundle 'klen/python-mode'
    " Bundle 'python.vim'
    Bundle 'python_match.vim'
    Bundle 'pythoncomplete'
" }


" Configuration heavily inspired by Steve Francia's vim configuration

" General {
    set background=dark         " Assume a dark background
    if !has('gui')
        set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " syntax highlighting
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    " always switch to the current file directory.

    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=options,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    set nospell                     " spell checking on
    set nofoldenable
    set hidden                      " allow buffer switching without saving

    scriptencoding utf-8
    set termencoding=utf-8
    set encoding=utf-8
    
    " Setting up the directories {
        if has('persistent_undo')
            set undofile
            set undodir=~/.vim/.undo,~/tmp,/tmp
            set undolevels=1000         "maximum number of changes that can be undone
            set undoreload=10000        "maximum number lines to save for undo on a buffer reload
        endif
        set nobackup " do not keep backup files, it's 70's style cluttering
        set noswapfile " do not write annoying intermediate swap files,
        " Could use * rather than *.*, but I prefer to leave .files unsaved
        au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
        au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)
    " }
" }

" Vim UI {
    set backspace=indent,eol,start  " backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set laststatus=2                " two lines for status
    set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·  " set some list chars
" }

" Formatting {
    set nowrap                      " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    set pastetoggle=<F2>            " pastetoggle (sane indentation on pastes)
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }

" Key (re)Mappings {
    let mapleader = ','
    
    " Quickly edit/reload the vimrc file
    nmap <silent> <leader>ev :e $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :

    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_
    
    " Save a read only file using sudo tee %
    cnoreabbrev <expr> w!!
                \((getcmdtype() == ':' && getcmdline() == 'w!!')
                \?('!sudo tee % >/dev/null'):('w!!'))

    " Fast replace word under cursor
    nmap <Leader>rr wbve"sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/

    " Highlight word under cursor
    nmap <Leader>cc wbve"sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>//n<CR>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    "clearing highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " File navigation shortcuts
    nnoremap <Leader>bb :CtrlPBuffer<cr>
    nnoremap <Leader>oo :FufFile<cr>
    noremap <Leader>ee :CtrlPMRUFile<cr>
    nnoremap <Leader>ll :CtrlPBufTag<cr>
    nnoremap <Leader>LL :CtrlPBufTagAll<cr>
    nnoremap <Leader>pp :CtrlP<cr>
    nnoremap <silent> <leader>tt :TagbarOpen fj<CR>

    " Editor mappings
    inoremap jj <Esc>               " leave escape mode quickly

" }

" Plugins Settings {

    " Misc {
        let g:NERDShutUp=1
        let b:match_ignorecase = 1
    " }

    " PIV {
        let g:DisableAutoPHPFolding = 1 
    "}

    " OmniComplete {
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " automatically open and close the popup menu / preview window
        set completeopt=menu,preview,longest
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags
    " }

    " NerdTree {
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
    " }

    " Session List {
        set sessionoptions=blank,buffers,curdir,tabpages,winsize
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>
     " }

    " ctrlp {
        let g:ctrlp_working_path_mode = 2
        let g:ctrlp_dotfiles = 0
        let g:ctrlp_root_markers = ['.project']

        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
        " let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
        " let g:ctrlp_user_command = ['.hg', 'hg --cwd %s locate -I .']
        " let g:ctrlp_user_command = ['.hg', '~/.vim/findreposfiles.sh %s']

        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }
     "}

     " PythonMode {
     " Disable if python support not present
        " if !has('python')
        "    let g:pymode = 1
        " endif
     " }

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.orig,*/cache/*

function! InitializeDirectories()
    let separator = "."
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
