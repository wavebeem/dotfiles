set nocompatible

syntax on

set bg=dark
color robokai

" US English spelling
set spelllang=en_us

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

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
set foldcolumn=2

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

" Toggle spellcheck with F2
map <F2> :set spell!<Enter>

filetype plugin on

"au filetype c       set tags+=/home/brian/stl.tags
"au filetype cpp     set tags+=/home/brian/cstdlib.tags
au filetype java    abbr sop System.out.println

au filetype c       abbr MAIN    int<Return>main(int argc, char **argv) {
au filetype cpp     abbr MAIN    int<Return>main(int argc, char **argv) {

" LaTeX
au filetype plaintex  setl textwidth=78

" Objective-C
au BufNewFile,BufRead *.m  setl ft=objc

au BufNewFile,BufRead *.txt  setl ft=text
au BufNewFile,BufRead todo   setl ft=text
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
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

" Highlight space at the end of the line as an error,
" but don't highlight while in insert mode
au InsertEnter * match Error //
au InsertLeave * match Error /\v\s+$/

" Bounce between matching ()[]{} while typing
set showmatch

" Disable matchparen plugin
let loaded_matchparen = 1

" Stick stupid .netrwhist elsewhere
let g:netrw_home = "/tmp"
