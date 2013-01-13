set nocompatible
filetype off

" <Space> is so much easier to type than <Backslash>
let mapleader = ' '

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-markdown'
Bundle 'ddollar/nerdcommenter'

" Bundle 'saikobee/vim-javascript-syntax'
" Bundle 'pangloss/vim-javascript-syntax'
" Bundle 'Enhanced-Javascript-syntax'
" Bundle 'drslump/vim-syntax-js'
" Bundle 'jelera/vim-javascript-syntax'
" Bundle 'JavaScript-syntax'
" Bundle 'othree/javascript-syntax.vim'

Bundle 'ScrollColors'

Bundle 'godlygeek/tabular'

" Dependency for FuzzyFinder
Bundle 'L9'
Bundle 'FuzzyFinder'

syntax on

set bg=dark

set t_Co=16
if match(hostname(), 'mockbook') >= 0
    color roboblu
else
    color lethean
endif

" Better % bouncing (for languages like Ruby)
runtime 'macros/matchit.vim'

" Nice info in the bottom line area
" (apparently this is off by default...)
set ruler

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

" I Would think the first map would work here, but somehow that
" removes the original binding for NERD Commenter toggle.
"
" Make comment toggling easier
" map <C-q> <Plug>NERDCommenterToggle
"
map <C-q> <Leader>c<Space>

" Opening files should be easier too
map <C-s> :FufCoverageFile<CR>
map <Leader>s :FufBuffer<CR>
map <Leader><C-s> :FufFile<CR>

map <C-p> :previous<CR>
map <C-n> :next<CR>

map <F1> :set spell!<CR>:set spell?<CR>
map <F2> :set number!<CR>:set number?<CR>
map <F3> :set paste!<CR>:set paste?<CR>

map <silent><F9>  :PREVCOLOR<CR>
map <silent><F10> :NEXTCOLOR<CR>

nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

" Stop bringing up help when I hit F1 instead of Esc in insert mode
imap <F1> <Nop>

filetype plugin on

" Nice Ruby stuff
let ruby_operators = 1
let ruby_fold = 1

au filetype java abbr sop System.out.println

au filetype html abbr viewport meta name="viewport" content="width=device-width, initial-scale=1"

au filetype javascript abbr ctn document.createTextNode
au filetype javascript abbr dce document.createElement
au filetype javascript abbr gid document.getElementById

" I hate how often I typo this one
au filetype javascript abbr fucntion function

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
