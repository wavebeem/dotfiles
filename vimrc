" Let's keep it short and fairly simple. I only use this for writing commit
" messages or editing configuration files.
set nocompatible
filetype plugin on
syntax on
" I would just leave the default color scheme, but it seems that visual
" selection colors are not working correctly in it, which totally screws up me
" using vim.
colorscheme peachpuff
set wildmenu
set nomodeline
set ruler
set ignorecase
set smartcase
set laststatus=2
set virtualedit=block
set nohidden
set nobackup
set backspace=indent,eol,start
set noswapfile
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set nonumber
" So I can have vim autocomplete JIRA-xyz for me in commit messages
set iskeyword+=-
set visualbell
set t_vb=
