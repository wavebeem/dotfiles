" Let's keep it short and fairly simple. I only use this for writing commit
" messages or editing configuration files.
set nocompatible
filetype plugin on
syntax on
colorscheme default
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
set number
" So I can have vim autocomplete JIRA-xyz for me in commit messages
set iskeyword+=-
set visualbell
set t_vb=
