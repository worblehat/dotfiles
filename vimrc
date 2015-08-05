set nocompatible

" Set up pathogen plugin
filetype off
execute pathogen#infect()
execute pathogen#helptags()

" Syntax highlighting
syntax on

" Remap leader key (used for custom mappings in normal mode)
let mapleader=","
let maplocalleader="\\"

" Convert tabs to 2 spaces
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

" Use filetype specific plugins and indentation rules if available
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" Show white space characters
set list

" Toggle displaying of white space characters
noremap <leader><space> :set list!<CR>

" on "set list", show tabs (as an arrow followed by proper whitespaces) and
" trailing whitespaces
set listchars=tab:▸\ ,trail:˽

" tab width in python
autocmd FileType py setlocal shiftwidth=4 tabstop=4

" TODO see ":h fo-table"
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Navigation on jklö (for german qwertz keyboard layout!)
noremap ö l
noremap l k
noremap k j
noremap j h

" Adapt the customized navigation to window navigation, too 
noremap <c-w>ö <c-w>l
noremap <c-w>l <c-w>k
noremap <c-w>k <c-w>j
noremap <c-w>j <c-w>h

" Disable arrow keys in normal and insert mode (to avoid temptation to use them)
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Map <c-space> to trigger omnicompletion. Some terminals interpret <c-space> as
" <c-@> (which is a build in vim mapping), so we need to map it as well.
inoremap <c-space> <c-x><c-o>
inoremap <c-@> <c-x><c-o>

" Save with ctrl+s in normal and insert mode
nnoremap <c-s>	:w<CR> 
inoremap <c-s>  <ESC>:w<CR>a
" ...or with leader key mapping in normal mode (because <c-s> is not always
" usable in terminal emulators)
nnoremap <leader>w :w<CR>

" Easier buffer switching
nnoremap <leader>b  :buffers<CR>:buffer<Space>

" Quickly jump to alternate file by double leader
nnoremap <leader><leader> <c-^>

" Quit current window using the leader key
nnoremap <leader>q :q<CR>

" Quit all windows using the leader key
nnoremap <leader>qa :qa<CR>

" Help shortcut (in addition to F1)
nnoremap <leader>1 :help<CR>

" Fast scrolling with ctrl and navigation keys
nnoremap <c-k>  <c-f>
nnoremap <c-l>  <c-b>

" Toggle line numbers and fold column for easy copying:
nmap <leader>7 :set nonumber!<CR>:set foldcolumn=0<CR>

" Shortcut to run make
nmap <leader>6 :make<CR>

" The default shortcut to follow links in vim help does not work on german
" keyboards
nnoremap <leader>h <C-]>

" Disable folding at startup
set nofoldenable

" Enable use of 256 colors in terminal
set t_Co=256

" Color scheme
colorscheme molokai
"colorscheme github

" Use UTF-8
set encoding=utf-8

" Hide Buffers instead of closing them
" => when opening a new buffer the old one can have unsafed changes
" (has to be forced with ! otherwise)
set hidden

" Don't make any noise
set noerrorbells

" Alway show file/buffer name in status bar
set laststatus=2

" Show line numbers
set number

" Show wrap line
set colorcolumn=80
highlight ColorColumn ctermbg=234

" Automatic reload .vimrc when it's altered in vim
autocmd! bufwritepost .vimrc source %

" Time (ms) after an edit the swap file ist written.
" Used by Tagbar and showmarks to update highlights/marks
set updatetime=500

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

" Hightlight white space errors in Python
" (See the default python syntax file for details)
let python_space_error_highlight = 1

" Windows specific setup
if has("gui_running")
  if has("gui_win32")
    set guifont=Consolas
  endif
endif

" ======================
" Plugins Configurations
" ======================

" === TagBar ===
" Toggle tagbar
nmap <silent> <leader>2 :TagbarToggle<CR>

" === TaskList ===
" Show Task list 
nmap <silent> <leader>4 :TaskList<CR>
" TODO toggle TaskList

" === showmarks ===
" Show marks in all buffers
autocmd VimEnter * DoShowMarks!

" === Syntastic ===
" Chose syntax checker for python 
let g:syntastic_python_checkers=['pyflakes']
" Chose syntax checker for C
let g:syntastic_c_compiler='clang'
let g:syntastic_c_checkers=['gcc'] "TODO
" Include directory for syntastic
let g:syntastic_c_include_dirs = ['/home/tobias/usr/include']
" Run syntax cheks when buffers are first loaded
let g:syntastic_check_on_open=1
" Shortcut for showing the list of errors
nnoremap <silent> <leader>5 :Errors<CR>
" Shortcut for running syntax checks manually
nnoremap <leader>s :SyntasticCheck<CR>
" Customized error symbols
let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol='S✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_warning_symbol='S⚠'

" === jedi-vim ===
let g:jedi#force_py_version = 3
" don't automatically open completion menu
let g:jedi#popup_on_dot = 0
" don't open new tab, when jumping to definition
let g:jedi#use_tabs_not_buffers = 0
" list all usages of a name
let g:jedi#usages_command = "<leader>u"
" Show docstring in separate window
let g:jedi#documentation_command = "<leader>k"
let g:jedi#show_call_signatures = "<leader>c"

" === clang_complete ===
" Open menu only on demand
"let g:clang_complete_auto = 0
let g:clang_complete_auto = 1
" Close the preview window after selection of entry
let g:clang_close_preview = 1
" Use libclang (instead of clang)
let g:clang_use_library = 1
" Additional include directory for clang's auto-completion
 let g:clang_user_options = '-I/home/tobias/usr/include'

" === startify ===
let g:startify_bookmarks = [ '~/.vimrc' ]
let g:startify_change_to_dir = 0

" === SimpylFold  ===
let g:SimpylFold_docstring_preview = 1

" === pandoc-syntax ===
autocmd BufNewFile,BufRead *.md,*.pd,*.pdc set filetype=pandoc
"autocmd FileType md,pd,pdc set filetype=pandoc
let g:pandoc_use_conceal = 0

"=========================
" Look for .vimrc in the current directory, but disable :autocmd, shell and
" write commands for security reasons.
set exrc
set secure
