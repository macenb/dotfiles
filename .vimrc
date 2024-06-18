" Disable vi compatibility
set nocompatible

" Enable filetype detection
filetype on

" Turn syntax highlighting on
syntax on

" Add line numbers
set number

" Set a good tab indent
set expandtab shiftwidth=4 softtabstop=4

" Good search settings
set incsearch
set ignorecase
set smartcase
set showmatch

" Get good settings for bottom bar
set showcmd
set showmode

" Set up wildmenu, which is like auto fill
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

command Run !python3 %
command Rungdb !python3 % GDB

