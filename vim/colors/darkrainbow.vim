" Vim color file
" Author:	Brian Mock <brian.mock@gmail.com>
" 			Note that this theme is based on Hans' theme	
" Thanks:	Hans Fugal <hans@fugal.net>

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="darkrainbow"

hi Normal	guifg=White guibg=#232323

" highlight groups
"hi Cursor	guibg=khaki guifg=black
hi Cursor	gui=none guibg=Khaki guifg=Black
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg

hi Number	guifg=SkyBlue
hi VertSplit	guibg=#c2bfa5 guifg=grey50 gui=none
hi Folded	guibg=grey30 guifg=gold
hi FoldColumn	guibg=grey30 guifg=tan
hi LineNr	guifg=grey50
hi ModeMsg	guifg=goldenrod
hi MoreMsg	guifg=SeaGreen
hi NonText	guifg=SkyBlue
hi Question	guifg=springgreen
hi IncSearch	guibg=White guifg=PaleVioletRed3
hi Search	guibg=PaleVioletRed3 guifg=White
hi SpecialKey	guifg=grey50
hi StatusLine	guibg=Grey90 guifg=Black gui=none
hi StatusLineNC	guibg=Grey60 guifg=Black gui=none
hi Title	guifg=indianred
hi Visual	guifg=White guibg=#5C5C5C gui=none
hi WarningMsg	guifg=salmon

hi MatchParen guibg=PaleVioletRed3 guifg=White
hi Comment	guifg=#c0b0eb
hi Constant	guifg=#ffa0a0
hi Identifier	guifg=palegreen
hi Statement	guifg=khaki
hi PreProc	guifg=salmon
hi Type		guifg=palegreen gui=none
hi Special	guifg=#e9d99e
hi Underlined guifg=SkyBlue
hi htmlLink guifg=SkyBlue gui=none
hi Directory guifg=SkyBlue
hi Ignore	guifg=grey40
hi Error guibg=#cc6060
hi Todo		gui=bold guifg=White guibg=indianred


" tabs (non gui)
hi TabLine guifg=White guibg=#454545 gui=none
hi TabLineFill guibg=#454545 gui=none
hi TabLineSel guifg=palegreen gui=none
"vim: sw=4 ts=4

