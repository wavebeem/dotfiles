" Maintainer: Brian Mock <brian@mockbrian.com>

hi clear Normal
set bg&

hi clear

if exists("syntax_on")
  syntax reset
endif

hi Statement        ctermfg=darkyellow  cterm=bold
hi LineNr           ctermbg=gray        ctermfg=darkgray    cterm=bold
hi VertSplit        ctermbg=darkgray    ctermfg=darkgray
hi StatusLine       ctermbg=darkblue    ctermfg=white       cterm=bold
hi StatusLineNC     ctermbg=gray        ctermfg=black       cterm=NONE
hi TabLine          ctermbg=gray        ctermfg=black       cterm=bold
hi TabLineFill      ctermbg=gray        ctermfg=black       cterm=bold
hi TabLineSel       ctermbg=darkblue    ctermfg=white       cterm=bold
hi Punctuation      ctermfg=gray        cterm=bold
hi Comment          ctermfg=darkgreen   cterm=bold
hi Number           ctermfg=magenta
hi NonText          ctermfg=gray
hi Identifier       ctermfg=cyan        cterm=bold
hi Type             ctermfg=black       cterm=bold
hi PreProc          ctermfg=magenta     cterm=bold

let colors_name = "defpp"
