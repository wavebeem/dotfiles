" Maintainer: Brian Mock <brian@mockbrian.com>

hi clear Normal
set bg&

hi clear

if exists("syntax_on")
  syntax reset
endif

hi Statement        ctermfg=black                       cterm=bold
hi Comment          ctermfg=darkgreen                   cterm=bold
hi Number           ctermfg=darkmagenta                 cterm=NONE
hi NonText          ctermfg=white                       cterm=NONE
hi Identifier       ctermfg=darkcyan                    cterm=bold
hi Type             ctermfg=black                       cterm=bold
hi PreProc          ctermfg=darkmagenta                 cterm=bold

hi LineNr           ctermfg=white       ctermbg=black   cterm=bold

hi VertSplit        ctermfg=white       ctermbg=white   cterm=bold

hi StatusLine       ctermfg=white       ctermbg=black   cterm=bold
hi StatusLineNC     ctermfg=black       ctermbg=white   cterm=NONE

hi TabLine          ctermfg=black       ctermbg=white   cterm=bold
hi TabLineFill      ctermfg=black       ctermbg=white   cterm=bold
hi TabLineSel       ctermfg=white       ctermbg=black   cterm=bold

" Custom syntax file stuff
hi Punctuation      ctermfg=darkyellow  guifg=#1f5a6c   cterm=NONE

let colors_name = "defpp"
