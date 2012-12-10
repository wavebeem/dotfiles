" Vim color file
" Author: Brian Mock <mock.brian@gmail.com>
" Note: Based on Oblivion color scheme for gedit (gtk-source-view)
"
" Cool help screens
" :help group-name
" :help highlight-groups
" :help cterm-colors

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists('syntax_on')
    syntax reset
    endif
endif
let g:colors_name='lethean'

hi Normal ctermfg=none ctermbg=none

hi CursorLine   ctermbg=black cterm=none
hi CursorColumn ctermbg=black cterm=none

hi DiffAdd      ctermfg=lightgreen   ctermbg=black       cterm=none
hi DiffChange   ctermfg=lightred     ctermbg=black       cterm=none
hi DiffText     ctermfg=lightred     ctermbg=black       cterm=none
hi DiffDelete   ctermfg=darkgray     ctermbg=black       cterm=none

hi Number       ctermfg=darkyellow

hi Folded       ctermbg=black       ctermfg=darkgray
hi vimFold      ctermbg=black       ctermfg=darkgray
hi FoldColumn   ctermbg=black       ctermfg=darkgray
hi LineNr       ctermbg=black       ctermfg=darkgray
hi VertSplit    ctermbg=darkgray    ctermfg=darkgray    cterm=none
hi StatusLine   ctermbg=lightgray   ctermfg=black       cterm=none
hi StatusLineNC ctermbg=black       ctermfg=lightgray   cterm=none
hi NonText      ctermbg=black       ctermfg=darkgray    cterm=none

hi ModeMsg      ctermbg=darkblue    ctermfg=none
hi MoreMsg      ctermbg=darkblue    ctermfg=none

hi Visual       ctermbg=lightgray   ctermfg=black cterm=none

hi IncSearch    ctermbg=darkyellow  ctermfg=black cterm=none
hi Search       ctermbg=darkmagenta ctermfg=white cterm=none

hi SpecialKey   ctermfg=lightgreen

hi Title        ctermfg=lightred
hi WarningMsg   ctermfg=lightred
hi Number       ctermfg=darkyellow

hi MatchParen   ctermfg=white ctermbg=lightmagenta
hi Comment      ctermfg=darkgray
hi Constant     ctermfg=lightred
hi String       ctermfg=yellow
hi Identifier   ctermfg=lightblue
hi Statement    ctermfg=white
hi PreProc      ctermfg=white
hi Type         ctermfg=lightgreen
hi Special      ctermfg=darkyellow
hi Underlined   ctermfg=lightmagenta cterm=underline
hi Directory    ctermfg=lightblue
hi Ignore       ctermfg=darkgray
hi Todo         ctermfg=white ctermbg=darkred
hi Function     ctermfg=lightmagenta

hi WildMenu     ctermfg=black ctermbg=lightgray cterm=none

hi Pmenu        ctermbg=black     ctermfg=lightgray
hi PmenuSel     ctermbg=darkblue  ctermfg=white
hi PmenuSbar    ctermbg=darkgray  ctermfg=darkgray
hi PmenuThumb   ctermbg=lightgray ctermfg=lightgray

hi cppSTLType   ctermfg=lightblue

hi spellBad     guifg=black guibg=darkyellow    gui=none
hi spellCap     guifg=black guibg=darkmagenta   gui=none
hi spellRare    guifg=black guibg=darkcyan      gui=none
hi spellLocal   guifg=black guibg=darkblue      gui=none

hi link cppSTL          Function
hi link Error           Todo
hi link Character       Number
hi link rubySymbol      Number
hi link htmlTag         htmlEndTag
" hi link htmlTagName     htmlTag
hi link htmlLink        Underlined
hi link pythonFunction  Identifier
hi link Question        Type
hi link CursorIM        Cursor
hi link VisualNOS       Visual
hi link xmlTag          Identifier
hi link xmlTagName      Identifier
hi link shDeref         Identifier
hi link shVariable      Function
hi link rubySharpBang   Special
hi link perlSharpBang   Special
hi link schemeFunc      Statement
hi link hsOperator      Special
" hi link shSpecialVariables Constant
" hi link bashSpecialVariables Constant

hi Semicolon ctermfg=lightgray
hi Braces    ctermfg=lightgray
hi Parens    ctermfg=lightgray
hi Comma     ctermfg=lightgray
hi Dot       ctermfg=lightgray

hi TabLine      ctermfg=lightgray ctermbg=black     cterm=none
hi TabLineFill  ctermfg=lightgray ctermbg=black     cterm=none
hi TabLineSel   ctermfg=black     ctermbg=lightgray cterm=none
