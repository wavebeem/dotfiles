set nocompatible
filetype off

" <Space> is so much easier to type than <Backslash>
let mapleader = ' '

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-markdown'

" I can make my own keybindings, thanks :)
let g:NERDCreateDefaultMappings = 0
Bundle 'ddollar/nerdcommenter'

Bundle 'Colour-Sampler-Pack'

Bundle 'ack.vim'

" This is in my own ~/.vim/ already
" Bundle 'saikobee/vim-javascript-syntax'

Bundle 'ScrollColors'

let g:ctrlp_max_files = 2000
let g:ctrlp_map = '<C-s>'
Bundle 'kien/ctrlp.vim'
nmap <Leader><C-s> :CtrlPMixed<CR>
nmap <Leader>s :CtrlPBuffer<CR>

syntax on

" Allow modelines
set modeline

set bg=dark
set t_Co=16
color roboblu

" Better % bouncing (for languages like Ruby)
runtime 'macros/matchit.vim'

" Nice info in the bottom line area
" (apparently this is off by default...)
set ruler

" This cryptic beast gives me a slightly modified statusbar, without the extra
" weight of vim powerline.
set stl=%1(%)%f%1(%)%(%h%r%m%)%=%<%2(%)%l,%c%7(%)%P%1(%)

" Always display bottom bar (keeps the buffer from scrolling around when you
" open vertical splits).
set laststatus=2

" Allow me to hide buffers with changes
set hidden

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
nmap <C-w>v     :tabnew<CR>:bwipeout<CR>:vsplit<CR>
nmap <C-w><C-v> :tabnew<CR>:bwipeout<CR>:vsplit<CR>

" Cycle through open windows
nmap <Tab> :wincmd w<CR>

" Nice setup for code folding
set foldmethod=indent
set foldlevel=999
set foldcolumn=0

" Set the height of the command window
" and enable the wildmenu
set cmdheight=1
set wildmenu
set wildmode=longest:full,full

" Number of lines to offset when scrolling
" so as to keep more code on screen
set scrolloff=0

" Set visual bell then disable the output of visual bell
set visualbell
set t_vb=

" Enable all mouse settings
set mouse=a

" Enable incremental searching
set incsearch

" Disable highlighting search terms
set nohlsearch

" List of pattersn to ignore in the wildmenu
set wildignore=*.swp,*.swo,*.pyc,*.class,*.o

map <C-q> <Plug>NERDCommenterToggle

" Make it easier to delete lines without cutting them
map <C-d> "_dd
map <Leader>d "_dd

" Opening files should be easier too
nmap <C-p> :previous<CR>
nmap <C-n> :next<CR>

" Toggle some important settings
nmap <F1> :set hlsearch!<CR>:set hlsearch?<CR>
nmap <F2> :set number!<CR>:set number?<CR>
nmap <F3> :set spell!<CR>:set spell?<CR>

" Save all and build on F5
nmap <F5> :wa<CR>:make<CR><CR>
nmap <F6> :cw<CR>

" Double tap leader to save file
nmap <Leader><Leader> :w<CR>

" Leader then q to save and quit
nmap <Leader>q :wq<CR>

set pastetoggle=<F1>

nmap <silent><F9>  :PREVCOLOR<CR>
nmap <silent><F10> :NEXTCOLOR<CR>

filetype plugin on

" Nice Ruby stuff
let ruby_operators = 1
let ruby_fold = 1

au filetype java iabbrev <buffer> sop System.out.println

au filetype html iabbrev <buffer> viewport meta name="viewport" content="width=device-width, initial-scale=1"

au filetype javascript iabbrev <buffer> ctn document.createTextNode
au filetype javascript iabbrev <buffer> dce document.createElement
au filetype javascript iabbrev <buffer> gid document.getElementById

" I hate how often I typo this one
au filetype javascript iabbrev <buffer> fucntion function

au filetype plaintex  setl textwidth=72 spell
au filetype tex       setl textwidth=72 spell

au BufNewFile,BufRead *.json setl ft=javascript

au BufNewFile,BufRead *.txt  setl ft=text
au BufNewFile,BufRead todo   setl ft=text
au BufNewFile,BufRead TODO   setl ft=text
au filetype text setl textwidth=78
au filetype text setl tabstop=2 softtabstop=2 shiftwidth=2

" Enable syntax highlighting for GLSL files
au BufNewFile,BufRead *.frag,*.vert,*.vsh,*.fsh,*.fp,*.vp,*.glsl setf glsl

" Highlight _*.erb files as JavaScript instead of erb
au BufNewFile,BufRead _*.erb set ft=javascript
au BufNewFile,BufRead _*.erb set fdm=indent

" F5 to reload .vimrc when editing it
au BufNewFile,BufRead .vimrc nmap <buffer> <silent> <F5> :w<CR>:so %<CR>:echo 'Reloaded .vimrc'<CR>
if expand("%") == $MYVIMRC
    nmap <buffer> <silent> <F5> :w<CR>:so %<CR>:echo 'Reloaded .vimrc'<CR>
endif

" Highlight space at the end of the line as an error,
" but don't highlight while in insert mode
au InsertEnter * match Error //
au InsertLeave * match Error /\v\s+$/

" Bounce between matching ()[]{} while typing
set showmatch

" Disable matchparen plugin
let loaded_matchparen = 1

" Stick stupid .netrwhist elsewhere
let g:netrw_home = '/tmp'
