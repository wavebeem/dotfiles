" Vim color file
" Name:     roboblu
" Author:   Brian Mock

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "roboblu"

"hi Title        ctermbg=lightred

hi Visual       ctermbg=blue   ctermfg=white    cterm=bold
hi WarningMsg   ctermbg=red    ctermfg=white

hi Folded       ctermbg=none        ctermfg=black           cterm=bold
hi FoldColumn   ctermbg=none        ctermfg=white           cterm=none

hi DiffAdd      ctermbg=darkgreen   ctermfg=white           cterm=bold
hi DiffChange   ctermbg=darkred     ctermfg=white           cterm=bold
hi DiffDelete   ctermbg=none        ctermfg=lightgray       cterm=none
hi DiffText     ctermbg=darkmagenta ctermfg=white           cterm=bold

hi Cursor       ctermbg=green
hi CursorIM     ctermbg=red


" Note: This needs to be done twice... why?
hi Normal           ctermbg=none ctermfg=gray cterm=none
hi Normal           ctermbg=none ctermfg=gray cterm=none

hi Comment          ctermfg=darkgray
hi Constant         ctermfg=lightred
  hi String         ctermfg=lightcyan
  hi Character      ctermfg=lightcyan
  hi Number         ctermfg=lightred
  hi Boolean        ctermfg=lightred
  hi Float          ctermfg=lightred
hi Identifier       ctermfg=lightmagenta
  hi Function       ctermfg=yellow
  hi Statement      ctermfg=white
  hi Conditional    ctermfg=white
  hi Repeat         ctermfg=white
  hi Label          ctermfg=lightmagenta
  hi Operator       ctermfg=white
  hi hsOperator     ctermfg=white
  hi Keyword        ctermfg=white
  hi Exception      ctermfg=white
hi PreProc          ctermfg=white
  hi include        ctermfg=white
  hi Define         ctermfg=white
  hi Macro          ctermfg=lightmagenta
  hi PreCondit      ctermfg=lightgreen
hi Type             ctermfg=yellow
  hi StorageClass   ctermfg=lightcyan
  hi Structure      ctermfg=lightcyan
  hi Typedef        ctermfg=lightcyan
hi Special          ctermfg=lightcyan
  hi Specialchar    ctermfg=lightgreen
  hi Tag            ctermfg=lightgreen
  hi Delimiter      ctermfg=lightgray
  hi Debug          ctermfg=lightgray
hi Underlined       ctermfg=lightgray
hi Ignore           ctermfg=lightgray
hi Error            ctermfg=yellow      ctermbg=red
hi ErrorMsg         ctermfg=yellow      ctermbg=red
hi Todo             ctermfg=lightgray   ctermbg=none

hi SpecialKey   ctermfg=gray
hi NonText      ctermfg=darkgray
hi Directory    ctermfg=lightgreen
hi IncSearch    ctermbg=yellow      ctermfg=black cterm=none
hi Search       ctermbg=yellow      ctermfg=black cterm=none
hi MoreMsg      ctermfg=yellow
hi ModeMsg      ctermfg=yellow
hi Question     ctermbg=blue        ctermfg=white

hi MatchParen   ctermbg=brown ctermfg=black

hi TabLineSel   ctermfg=black     ctermbg=white   cterm=none
hi TabLine      ctermfg=gray      ctermbg=none    cterm=bold,underline
hi TabLineFill  ctermfg=black     ctermbg=none    cterm=underline,bold

hi LineNr       ctermfg=black cterm=bold

hi VertSplit    cterm=none        ctermbg=none     ctermfg=darkgray
hi StatusLine   cterm=underline   ctermbg=none     ctermfg=white
hi StatusLineNC cterm=underline   ctermbg=none     ctermfg=darkgray

hi WildMenu     ctermbg=none ctermfg=none cterm=reverse,underline

hi spellBad     ctermbg=red ctermfg=yellow
hi spellCap     ctermbg=red ctermfg=yellow
hi spellRare    ctermbg=red ctermfg=yellow
hi spellLocal   ctermbg=red ctermfg=yellow

hi Pmenu        ctermbg=blue    ctermfg=white   cterm=bold
hi PmenuSel     ctermbg=red     ctermfg=white   cterm=bold
hi PmenuSbar    ctermbg=blue    ctermfg=blue
hi PmenuThumb   ctermbg=white   ctermfg=white

" Java
hi javaCommentTitle     ctermfg=gray
hi javaDocParam         ctermfg=gray
hi javaDocTag           ctermfg=gray
hi javaDocTags          ctermfg=gray

" Perl
hi perlOperator             ctermfg=gray
hi perlStatementList        ctermfg=lightcyan
hi perlStatementScalar      ctermfg=lightcyan
hi perlStatementVector      ctermfg=lightcyan
hi perlMisc                 ctermfg=lightcyan
hi perlStatementIOfunc      ctermfg=lightcyan
hi perlStatementHash        ctermfg=lightcyan
hi perlStatementRegexp      ctermfg=lightgray

" Haskell
hi hsDelimiter      ctermfg=gray

" Python
hi pythonFunction   ctermfg=lightcyan cterm=bold
