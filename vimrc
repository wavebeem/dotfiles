" Who cares about vi compatibility?
set nocompatible

" Set up Vundle for managing plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Snippets
" let g:UltiSnipsDontReverseSearchPath = 1
let g:UltiSnipsExpandTrigger         = '<tab>'
let g:UltiSnipsJumpForwardTrigger    = '<tab>'
let g:UltiSnipsJumpBackwardTrigger   = '<s-tab>'
Plugin 'SirVer/ultisnips'

" Make :JsBeautify command to reformat JSON
Plugin 'maksimr/vim-jsbeautify'
function! JsonBeautify()
    set ft=json
    call JsBeautify()
endfunction
command! JsonBeautify call JsonBeautify()
command! JsBeautify call JsBeautify()

" <C-d> to toggle comments
let g:NERDCreateDefaultMappings = 0
Plugin 'ddollar/nerdcommenter'
map <C-d> <Plug>NERDCommenterToggle
map <Leader>c <C-d>

" Various color schemes
Plugin 'mimicpak'
Plugin 'altercation/vim-colors-solarized'
Plugin 'summerfruit.vim'
Plugin 'summerfruit256.vim'
Plugin 'fruity.vim'
Plugin 'pyte'
Plugin 'Wombat'
Plugin 'morhetz/gruvbox'

" Allow per-project editor configuration settings
Plugin 'editorconfig/editorconfig-vim'

" Easy copy/paste for terminal Vim!
Plugin 'ConradIrwin/vim-bracketed-paste'

" Syntax highlighting
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'digitaltoad/vim-jade'
Plugin 'alunny/pegjs-vim'
Plugin 'wizicer/vim-jison'
Plugin 'wting/rust.vim'
Plugin 'groenewege/vim-less'
let g:vim_json_syntax_conceal = 0
Plugin 'elzr/vim-json'
Plugin 'leafgarland/typescript-vim'

" Integrate ack into vim via :Ack command
Plugin 'ack.vim'
command! Wack exec 'Ack "' . expand('<cword>') . '"'

" This is in my own ~/.vim/ already
" Bundle 'saikobee/vim-javascript-syntax'

" Commands to cycle colors
Plugin 'ScrollColors'
nmap <silent><F9>  :PREVCOLOR<CR>
nmap <silent><F10> :NEXTCOLOR<CR>

" Fuzzy file searching
let g:ctrlp_max_files = 2000
let g:ctrlp_mruf_relative = 1
" let g:ctrlp_extension = ['tag', 'mixed']
let g:ctrlp_map = '<C-s>'
Plugin 'kien/ctrlp.vim'
nnoremap <C-s> :CtrlPMixed<CR>
nnoremap <C-n> :CtrlPBuffer<CR>

call vundle#end()
filetype plugin on

" <Space> is so much easier to type than <Backslash>
let mapleader = ' '

" Syntax highlighting is a must
syntax on

" Disallow modelines
set nomodeline

color defpp

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

" Allow block selections to go where there aren't actually characters.
set virtualedit=block

" Don't allow me to hide buffers with changes
set nohidden

" Don't save stinkin' backup files
set nobackup

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

" Disable line numbers
set nonumber

" Enable terminal titles (default?)
set title

" Make splits better
set splitright

" Cycle between two most recent windows
nmap <silent> <Tab> :wincmd p<CR>

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
set wildignore=*.swp
set wildignore+=*.swo
set wildignore+=*.pyc
set wildignore+=*.class
set wildignore+=*.o
set wildignore+=node_modules
set wildignore+=bower_components
set wildignore+=docs
set wildignore+=build
set wildignore+=instrument
set wildignore+=testbed
set wildignore+=reports
set wildignore+=public
set wildignore+=vendor
set wildignore+=coverage
set wildignore+=.sass-cache

" Accidentally going into ex mode is a bummer, let's just use it to reflow text
vmap Q gq

" Opening files should be easier too
" nmap <C-n> :next<CR>

" Toggle some important settings
nmap <F1> :set hlsearch!<CR>:set hlsearch?<CR>
nmap <F2> :set number!<CR>:set number?<CR>
nmap <F3> :set spell!<CR>:set spell?<CR>

" Various shortcuts
nmap <Leader><Leader> :w<CR>:wa<CR>
nmap <Leader>q :confirm bd<CR>
nmap Q :confirm 1,999bd<CR>
nmap <Leader>t :tabedit<CR>
nmap <Leader>v :vsplit<CR>
nmap <Leader>s :split<CR>
nmap <Leader>a :wa<CR>

vnoremap < <gv
vnoremap > >gv

" I rarely want to open man pages for the word under the cursor
nnoremap K :Wack<CR>
vnoremap K <Nop>

" Easier tab switching
nmap <C-j> gt
nmap <C-k> gT

" Easily allow sane pasting into terminal Vim
set pastetoggle=<F1>

" Show characters I hate
set list
set listchars=nbsp:X,tab:>-,extends:>,precedes:<,trail:.

" Nice Ruby stuff
let ruby_operators = 1
let ruby_fold = 1

au BufNewFile,BufRead *.md setl ft=markdown

au BufNewFile,BufRead *.pegjs setl ft=pegjs

au BufNewFile,BufRead *.txt,todo,TODO setl ft=text
au BufNewFile,BufRead *.js.erb setf javascript.eruby
au BufNewFile,BufRead * set fdm=indent

" Automatically reload vimrc when saving it
augroup vimrc
au!
au BufWritePost $MYVIMRC source $MYVIMRC
au BufWritePost $MYGVIMRC source $MYGVIMRC
augroup END

" Highlight space at the end of the line as an error,
" but don't highlight while in insert mode
hi TrailingWhitespace
    \ ctermbg=darkred
    \ ctermfg=white
    \ cterm=none
    \ guibg=#cc0000
    \ guifg=#e62e2e
au InsertEnter * match TrailingWhitespace //
au InsertLeave * match TrailingWhitespace /\v\s+$/

" Bounce between matching ()[]{} while typing
set showmatch

" Disable matchparen plugin
let loaded_matchparen = 1

" Stick stupid .netrwhist elsewhere
let g:netrw_home = '/tmp'

" Make columns past 80 look funny
" let &colorcolumn = join(range(81, 999), ",")
" set colorcolumn=81,82,83,101,102,103,121,122,123
set colorcolumn=
hi ColorColumn ctermbg=none
hi NonText ctermbg=white ctermfg=gray
