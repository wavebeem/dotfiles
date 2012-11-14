set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
"Bundle 'godlygeek/csapprox'
set t_Co=16

syntax on

set bg=dark
color roboblu

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
set foldmethod=syntax
set foldlevel=999
set foldcolumn=0

" Set the height of the command window
" and enable the wildmenu
set cmdheight=1
set wildmenu

" Number of lines to offset when scrolling
" so as to keep more code on screen
set scrolloff=0

" Set visual bell then disable the output of visual bell
set visualbell
set t_vb=

" Set 256 colors mode
"set t_Co=256

" Enable all mouse settings
set mouse=a

" Enable incremental searching
set incsearch

" Disable highlighting search terms
set nohlsearch

" List of pattersn to ignore in the wildmenu
set wildignore=*.swp,*.swo,*.pyc,*.class,*.o

" Toggle spellcheck with F3
map <F3> :set spell!<Return>

" Toggle line numbers with F4
map <F4> :set number!<Return>

" Disable mouse support with F5
map <F5> :set mouse=<Return>

" Enable mouse support with F5
map <F6> :set mouse=a<Return>

" Toggle paste support
map <F7> :set paste!<Return>:set paste?<Return>

filetype plugin on

" Nice Ruby stuff
let ruby_operators = 1
let ruby_fold = 1

"au filetype c       set tags+=/home/brian/stl.tags
"au filetype cpp     set tags+=/home/brian/cstdlib.tags
au filetype java    abbr sop System.out.println
au filetype javascript abbr ctn document.createTextNode
au filetype javascript abbr dce document.createElement
au filetype javascript abbr gid document.getElementById

au filetype c       abbr MAIN    int<Return>main(int argc, char **argv) {
au filetype cpp     abbr MAIN    int<Return>main(int argc, char **argv) {

" LaTeX
au filetype plaintex  setl textwidth=72 spell
au filetype tex       setl textwidth=72 spell

au BufNewFile,BufRead *.json setl ft=javascript

au BufNewFile,BufRead *.txt  setl ft=text
au BufNewFile,BufRead todo   setl ft=text
au BufNewFile,BufRead TODO   setl ft=text
au filetype text setl textwidth=78
au filetype text setl tabstop=2 softtabstop=2 shiftwidth=2

au filetype python      setl foldmethod=indent
au filetype haskell     setl foldmethod=indent
au filetype bash        setl foldmethod=indent
au filetype st          setl foldmethod=indent
au filetype vim         setl foldmethod=indent
au filetype javascript  setl foldmethod=indent
au filetype perl        setl foldmethod=indent
au filetype conf        setl foldmethod=indent

" Enable syntax highlighting for GLSL files
au BufNewFile,BufRead *.frag,*.vert,*.vsh,*.fsh,*.fp,*.vp,*.glsl setf glsl

" Highlight _*.erb files as JavaScript instead of erb.
au BufNewFile,BufRead _*.erb set ft=javascript

" Highlight space at the end of the line as an error,
" but don't highlight while in insert mode
au InsertEnter * match Error //
au InsertLeave * match Error /\v\s+$/

" Bounce between matching ()[]{} while typing
set showmatch

" Disable matchparen plugin
let loaded_matchparen = 1

map <F1> :previous<Return>
map <F2> :next<Return>

" Stick stupid .netrwhist elsewhere
let g:netrw_home = "/tmp"
