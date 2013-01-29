" Navigation on jklö (on german qwertz keyboard layout!)
noremap ö l
noremap l k
noremap k j
noremap j h

" Use UTF-8
set encoding=utf-8

" Syntax highlighting
syntax on

" Show line numbers
set number

" Show wrap line
set colorcolumn=110
highlight ColorColumn ctermbg=DarkGreen

" Automatic reload .vimrc when it's altered in vim
autocmd! bufwritepost .vimrc source %

" Convert tabs to 4 spaces
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Ignore case when searchings
set ignorecase
