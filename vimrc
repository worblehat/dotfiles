set nocompatible

" Set up pathogen plugin
filetype off
execute pathogen#infect()
execute pathogen#helptags()

" Syntax highlighting
syntax on

" Use filetype specific plugins and  indentation rules if available
filetype plugin indent on

" Navigation on jklö (for german qwertz keyboard layout!)
noremap ö l
noremap l k
noremap k j
noremap j h

" Disable arrow keys in normal and insert mode (to avoid temptation to use them)
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Save with ctrl+s in normal and insert mode
nmap <c-s>	:w<CR>
imap <c-s>  <ESC>:w<CR>a

" Easier buffer switching
nnoremap <c-b>  :buffers<CR>:buffer<Space>

" Fast scrolling with ctrl and navigation keys
nnoremap <c-k>  <c-f>
nnoremap <c-l>  <c-b>

" Toggle line numbers and fold column for easy copying:
nnoremap <F3> :set nonumber!<CR>:set foldcolumn=0<CR>

" Enable use of 256 colors in terminal
:set t_Co=256

" Color scheme
colorscheme molokai
 
" Use UTF-8
set encoding=utf-8

" Hide Buffers instead of closing them 
" => when opening a new buffer the old one can have unsafed changes (has to be forced with ! otherwise)
set hidden

" Don't make any noise
set noerrorbells

" Alway show file/buffer name in status bar
set laststatus=2

" Show line numbers
set number

" Show wrap line
set colorcolumn=110
highlight ColorColumn ctermbg=234

" Automatic reload .vimrc when it's altered in vim
autocmd! bufwritepost .vimrc source %

" Time (ms) after an edit the swap file ist written. 
" Used by Tagbar and showmarks to update highlights/marks
set updatetime=500

" Convert tabs to 4 spaces
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Ignore case when searchings
set ignorecase

" Highlight occurences when searching 
set hlsearch

" Clear highlight with space
nnoremap <Space> :nohlsearch<CR>

" Already highlight occurences while typing the search term
set incsearch 

" Command line completion (similar to the behaviour in bash)
set wildmode=longest,list

" OmniCompletion menu behaviour (might already be the default)
set completeopt=menuone,longest,preview

" Make choosing an entry from completion menus more pleasant 
" (using navigation keys and enter)
inoremap <expr> k       pumvisible() ? "\<C-n>" : "\k"
inoremap <expr> l       pumvisible() ? "\<C-p>" : "\l" 
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>" 

" Sometimes I just want to use the mouse for scrolling
:set mouse=a
:map <MouseDown> 5<c-y>
:map <MouseUp> 5<c-e>

" ======================
" Plugins Configurations
" ======================

" === TagBar ===
" Toggle tagbar
nmap <F2> :TagbarToggle<CR>

" === TaskList ===
" Show Task list 
nmap <F4> :TaskList<CR>

" === showmarks ===
" Show marks in all buffers
autocmd VimEnter * DoShowMarks!

" === Syntastic ===
" Chose syntax checker for python 
let g:syntastic_python_checkers=['pyflakes']
""let g:syntastic_python_checkers=['flake8']    TODO
" Chose syntax checker for C
""let g:syntastic_c_checkers=['gcc']

" === jedi-vim ===
" don't automatically open completion menu
let g:jedi#popup_on_dot = 0
" don't open new tab, when jumping to definition
let g:jedi#use_tabs_not_buffers = 0

" === clang_complete ===
" Open menu only on demand
let g:clang_complete_auto = 0
" Close the preview window after selection of entry
let g:clang_close_preview = 1
" Completion menu (provided by clang_complete) with ctrl+space for C/C++
autocmd FileType c inoremap <Nul> <c-x><c-u>
autocmd FileType cpp inoremap <Nul> <c-x><c-u>
