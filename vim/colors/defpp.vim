" Maintainer: Brian Mock <brian@mockbrian.com>

hi clear Normal
set bg&

hi clear

if exists("syntax_on")
  syntax reset
endif

hi Statement        ctermfg=darkyellow  cterm=bold
hi LineNr           ctermbg=white       ctermfg=black       cterm=bold
hi VertSplit        ctermbg=darkred     ctermfg=darkred
hi StatusLine       ctermbg=darkred     ctermfg=white       cterm=bold
hi StatusLineNC     ctermbg=white       ctermfg=black       cterm=NONE
hi TabLine          ctermbg=white       ctermfg=black       cterm=bold
hi TabLineFill      ctermbg=white       ctermfg=black       cterm=bold
hi TabLineSel       ctermbg=darkred     ctermfg=white       cterm=bold
hi Punctuation      ctermfg=white       cterm=bold
hi Comment          ctermfg=darkgreen   cterm=bold
hi Number           ctermfg=magenta
hi NonText          ctermfg=white
hi Identifier       ctermfg=cyan        cterm=bold
hi Type             ctermfg=black       cterm=bold
hi PreProc          ctermfg=magenta     cterm=bold

let colors_name = "defpp"
