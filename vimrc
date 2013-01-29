" Navigation on jklö (on german qwertz keyboard layout!)
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
