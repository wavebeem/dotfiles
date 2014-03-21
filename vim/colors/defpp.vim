" Maintainer: Brian Mock <brian@mockbrian.com>

hi clear Normal
set bg&

hi clear

if exists("syntax_on")
  syntax reset
endif

hi Statement        ctermfg=darkyellow  cterm=bold
hi LineNr           ctermbg=black       ctermfg=white       cterm=bold
hi VertSplit        ctermbg=white       ctermfg=white       cterm=bold
hi StatusLine       ctermbg=black       ctermfg=white       cterm=bold
hi StatusLineNC     ctermbg=white       ctermfg=black       cterm=NONE
hi TabLine          ctermbg=white       ctermfg=black       cterm=bold
hi TabLineFill      ctermbg=white       ctermfg=black       cterm=bold
hi TabLineSel       ctermbg=black       ctermfg=white       cterm=bold
hi Punctuation      ctermfg=white       cterm=bold
hi Comment          ctermfg=darkgreen   cterm=bold
hi Number           ctermfg=magenta
hi NonText          ctermfg=white
hi Identifier       ctermfg=darkcyan    cterm=bold
hi Type             ctermfg=black       cterm=bold
hi PreProc          ctermfg=magenta     cterm=bold

let colors_name = "defpp"
