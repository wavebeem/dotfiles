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

" Bundle 'Colour-Sampler-Pack'
Bundle 'vim-scripts/mimicpak'
Bundle 'altercation/vim-colors-solarized'

Bundle 'briancollins/vim-jst'

Bundle 'ack.vim'

" This is in my own ~/.vim/ already
" Bundle 'saikobee/vim-javascript-syntax'

Bundle 'cakebaker/scss-syntax.vim'
Bundle 'groenewege/vim-less'

Bundle 'ScrollColors'

let g:ctrlp_max_files = 2000
let g:ctrlp_map = '<C-s>'
Bundle 'kien/ctrlp.vim'

syntax on

" Allow modelines
set modeline

set bg=dark
set t_Co=16

" color roboblu

let g:solarized_termtrans = 1
color solarized
hi Punctuation ctermfg=darkgray
hi Visual ctermbg=10 ctermfg=black cterm=none
hi Folded ctermfg=10 cterm=none

hi TabLine      cterm=none
hi TabLineFill  cterm=none
hi TabLineSel   cterm=reverse

hi link rubyStringDelimiter String

" Better % bouncing (for languages like Ruby)
" runtime 'macros/matchit.vim'

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

" Cycle through open windows
nmap <silent> <Tab> :wincmd w<CR>

" Nice setup for code folding
set foldmethod=indent
set foldlevel=999
set foldcolumn=0

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
set wildignore=*.swp,*.swo,*.pyc,*.class,*.o,node_modules

map <C-d> <Plug>NERDCommenterToggle
map <Leader>c <Plug>NERDCommenterToggle

" Map C-k to k so I can hold down control and hit j/k to navigate
" and q to comment
nmap <C-k> k

" Accidentally going into ex mode is a bummer, let's just use it to reflow text
nmap Q gq
vmap Q gq

" Make it easier to delete lines without cutting them
" map <C-d> "_dd
" map <Leader>d "_dd

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
nmap <Leader>q :q<CR>

" Leader then t to open a new tab
nmap <Leader>t :tabedit<CR>

" Leader then v to open a vertical split
nmap <Leader>v :vsplit<CR>

nmap K <Nop>

set pastetoggle=<F1>

nmap <silent><F9>  :PREVCOLOR<CR>
nmap <silent><F10> :NEXTCOLOR<CR>

filetype plugin on

" Nice Ruby stuff
let ruby_operators = 1
let ruby_fold = 1

au filetype java iabbrev <buffer> sop System.out.println

au filetype html iabbrev <buffer> viewport meta name="viewport" content="width=device-width, initial-scale=1"
au filetype html iabbrev <buffer> doctype !DOCTYPE html

au filetype javascript iabbrev <buffer> ctn document.createTextNode
au filetype eruby      iabbrev <buffer> ctn document.createTextNode

au filetype javascript iabbrev <buffer> dce document.createElement
au filetype eruby      iabbrev <buffer> dce document.createElement

au filetype javascript iabbrev <buffer> gid document.getElementById
au filetype eruby      iabbrev <buffer> gid document.getElementById

au filetype javascript iabbrev <buffer> koo ko.observable
au filetype javascript iabbrev <buffer> koa ko.observableArray
au filetype javascript iabbrev <buffer> koc ko.computed

" I hate how often I typo this one
au filetype javascript iabbrev <buffer> fucntion function
au filetype javascript iabbrev <buffer> fuynction function

au filetype plaintex  setl textwidth=72 spell
au filetype tex       setl textwidth=72 spell

au BufNewFile,BufRead *.json setl ft=javascript

au BufNewFile,BufRead *.txt  setl ft=text
au BufNewFile,BufRead todo   setl ft=text
au BufNewFile,BufRead TODO   setl ft=text
au filetype text setl textwidth=78
au filetype text setl tabstop=2 softtabstop=2 shiftwidth=2

au filetype scala setl tabstop=2 softtabstop=2 shiftwidth=2

au filetype less set iskeyword-=-

" Enable syntax highlighting for GLSL files
au BufNewFile,BufRead *.frag,*.vert,*.vsh,*.fsh,*.fp,*.vp,*.glsl setf glsl

au BufNewFile,BufRead * set fdm=indent

" F5 to reload .vimrc when editing it
au BufNewFile,BufRead .vimrc nmap <buffer> <silent> <F5> :w<CR>:so %<CR>:echo 'Reloaded .vimrc'<CR>
if expand("%") == $MYVIMRC
    nmap <buffer> <silent> <F5> :w<CR>:so %<CR>:echo 'Reloaded .vimrc'<CR>
endif

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
