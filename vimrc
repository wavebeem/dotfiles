" Who cares about vi compatibility?
set nocompatible

" Set up Vundle for managing plugins
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Snippets
let g:UltiSnipsDontReverseSearchPath = 1
Bundle 'SirVer/ultisnips'
" set rtp+=/home/brian/ultisnips/
" set rtp^=/home/brian/ultisnips/

" Make :JsBeautify command to reformat JSON
Bundle 'maksimr/vim-jsbeautify'
command! JsBeautify call JsBeautify()

" <C-d> to toggle comments
let g:NERDCreateDefaultMappings = 0
Bundle 'ddollar/nerdcommenter'
map <C-d> <Plug>NERDCommenterToggle
map <Leader>c <Plug>NERDCommenterToggle

" Various color schemes
Bundle 'vim-scripts/mimicpak'
Bundle 'altercation/vim-colors-solarized'

" Syntax highlighting
Bundle 'briancollins/vim-jst'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-markdown'
let g:vim_json_syntax_conceal = 0
Bundle 'elzr/vim-json'

" Integrate ack into vim via :Ack command
Bundle 'ack.vim'
command! Wack exec 'Ack "' . expand('<cword>') . '"'

" This is in my own ~/.vim/ already
" Bundle 'saikobee/vim-javascript-syntax'

" Commands to cycle colors
Bundle 'ScrollColors'
nmap <silent><F9>  :PREVCOLOR<CR>
nmap <silent><F10> :NEXTCOLOR<CR>

" Fuzzy file searching
let g:ctrlp_max_files = 2000
let g:ctrlp_map = '<C-s>'
Bundle 'kien/ctrlp.vim'

" <Space> is so much easier to type than <Backslash>
let mapleader = ' '

" Syntax highlighting is a must
syntax on

" Allow modelines
set modeline

" color roboblu

set bg=dark
set t_Co=16
let g:solarized_termtrans = 1
color solarized

hi Punctuation ctermfg=darkgray guifg=#1f5a6c
hi Visual ctermbg=10 ctermfg=black cterm=none
hi Folded ctermfg=10 cterm=none

hi VarId ctermfg=none
hi hsDelimiter ctermfg=darkgray

hi TabLine      cterm=none      guibg=#586e75 guifg=#93a1a1 gui=none
hi TabLineFill  cterm=none      guibg=#586e75 guifg=#93a1a1 gui=none
hi TabLineSel   cterm=reverse   guibg=#073642 guifg=#fdf6e3 gui=none

hi link rubyStringDelimiter String

" Nice info in the bottom line area
" (apparently this is off by default...)
set ruler

" Smart case-sensitive searching
set ignorecase
set smartcase

" This cryptic beast gives me a slightly modified statusbar, without the extra
" weight of vim powerline.
set stl=%1(%)%f%1(%)%(%h%r%m%)%=%<%2(%)%l,%c%7(%)%P%1(%)

" Always display bottom bar (keeps the buffer from scrolling around when you
" open vertical splits).
set laststatus=2

" Don't allow me to hide buffers with changes
set nohidden

" US English spelling
set spelllang=en_us

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Stop making stupid swap files
set noswapfile

" 4 spaces, soft tabs
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" Indentation
set autoindent

" Enable line numbers
set number

" Enable terminal titles (default?)
set title

" Make splits better
set splitright

" Cycle through open windows
nmap <silent> <Tab> :wincmd w<CR>

" Nice setup for code folding
set foldmethod=indent
set foldlevel=999
set foldcolumn=0

" Show a nice character when line-wrapping text
set showbreak=↪

" Set the height of the command window
" and enable the wildmenu
set cmdheight=1
set wildmenu
set wildmode=longest:full,full

" Set visual bell then disable the output of visual bell
set visualbell
set t_vb=

" Enable all mouse settings
set mouse=a

" Enable incremental searching
set incsearch

" Disable highlighting search terms
set nohlsearch

" List of patterns to ignore in the wildmenu
set wildignore=*.swp,*.swo,*.pyc,*.class,*.o,node_modules,docs,build,instrument,testbed

" Accidentally going into ex mode is a bummer, let's just use it to reflow text
nmap Q gqq
vmap Q gq

" Opening files should be easier too
nmap <C-p> :previous<CR>
nmap <C-n> :next<CR>

" Toggle some important settings
nmap <F1> :set hlsearch!<CR>:set hlsearch?<CR>
nmap <F2> :set number!<CR>:set number?<CR>
nmap <F3> :set spell!<CR>:set spell?<CR>

" Various shortcuts
nmap <Leader><Leader> :w<CR>
nmap <Leader>q :x<CR>
nmap <Leader>t :tabedit<CR>
nmap <Leader>v :vsplit<CR>

" I rarely want to open man pages for the word under the cursor
nmap K <Nop>

" Easier tab switching
nmap <C-j> gt
nmap <C-k> gT

" Easily allow sane pasting into terminal Vim
set pastetoggle=<F1>

filetype plugin on

" Nice Ruby stuff
let ruby_operators = 1
let ruby_fold = 1

au BufNewFile,BufRead *.txt,todo,TODO setl ft=text
au BufNewFile,BufRead *.js.erb setf javascript.eruby
au BufNewFile,BufRead * set fdm=indent

" Automatically reload vimrc when saving it
augroup vimrc
au!
au BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Highlight space at the end of the line as an error,
" but don't highlight while in insert mode
hi TrailingWhitespace ctermbg=darkred cterm=none guibg=#cc0000
au InsertEnter * match TrailingWhitespace //
au InsertLeave * match TrailingWhitespace /\v\s+$/

" Bounce between matching ()[]{} while typing
set showmatch

" Disable matchparen plugin
let loaded_matchparen = 1

" Stick stupid .netrwhist elsewhere
let g:netrw_home = '/tmp'
