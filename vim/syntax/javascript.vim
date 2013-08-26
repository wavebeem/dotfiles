" Vim syntax file
" Language:     JavaScript
" Maintainer:   Brian Mock <mock.brian@gmail.com>
"
" Based on syntax/javascript.vim from Vim 7.3

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("javaScript_fold")
  unlet javaScript_fold
endif

setlocal iskeyword+=$

syn match   javaScriptOps               '+\|++\|-\|--\|\*\|/\|>\|<\|>>\|<<\|>>>\||\|&\|||\|&&\|%\|\~\|!\|=\|?\|:\|+=\|-=\|\*=\|/='
syn match   javaScriptDot               '\.'
syn match   javaScriptComma             ','
syn match   javaScriptSemicolon         ';'

syn keyword javaScriptCommentTodo      TODO FIXME XXX TBD contained
syn match   javaScriptLineComment      "\/\/.*" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  javaScriptComment          start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptSpecial          "\\\d\d\d\|\\."
syn region  javaScriptStringD          start=+"+  skip=+\\\\\|\\"+  end=+"\|$+  contains=javaScriptSpecial,@htmlPreproc
syn region  javaScriptStringS          start=+'+  skip=+\\\\\|\\'+  end=+'\|$+  contains=javaScriptSpecial,@htmlPreproc

syn match   javaScriptSpecialCharacter "'\\.'"
" syn match   javaScriptNumber           '-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>\|NaN'
syn match   javaScriptNumber           '-\=\<\d\+\>\|0[xX][0-9a-fA-F]\+\>'
syn match   javaScriptFloat            '-\=\<\d\+\.\d\+\([eE]\d\+\)\=\>'
syn match   javaScriptFloat            '-\=\<\d\+[eE]\d\+\>'
syn region  javaScriptRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline

syn keyword javaScriptConditional       if else switch
syn keyword javaScriptRepeat            while for do in
syn keyword javaScriptBranch            break continue
syn keyword javaScriptOperator          new delete instanceof typeof
syn keyword javaScriptType              Array Boolean Date Function Number Object String RegExp Math
syn keyword javaScriptStatement         return with var let
syn keyword javaScriptBoolean           true false
syn keyword javaScriptNaN               NaN
syn keyword javaScriptNull              null undefined
syn keyword javaScriptIdentifier        arguments this
syn keyword javaScriptLabel             case default
syn keyword javaScriptException         try catch finally throw
syn keyword javaScriptMessage           alert confirm prompt status
syn keyword javaScriptGlobal            self window top parent
syn keyword javaScriptMember            document event location
syn keyword javaScriptDeprecated        escape unescape
syn keyword javaScriptReserved          abstract boolean byte char class const debugger double enum export extends final float goto implements import int interface long native package private protected public short static super synchronized throws transient volatile

" if exists("javaScript_fold")
"     syn match   javaScriptFunction      "\<function\>"
"     syn region  javaScriptFunctionFold  start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

"     syn sync match javaScriptSync       grouphere javaScriptFunctionFold "\<function\>"
"     syn sync match javaScriptSync       grouphere NONE "^}"

"     setlocal foldmethod=syntax
"     setlocal foldtext=getline(v:foldstart)
" else
"     syn keyword javaScriptFunction      function
"     syn match   javaScriptBraces           "[{}\[\]]"
"     syn match   javaScriptParens           "[()]"
" endif

syn keyword javaScriptFunction      function
syn match   javaScriptBraces           "[{}\[\]]"
syn match   javaScriptParens           "[()]"

syn sync fromstart
syn sync maxlines=100

if main_syntax == "javascript"
  syn sync ccomment javaScriptComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink javaScriptComment              Comment
  HiLink javaScriptLineComment          Comment
  HiLink javaScriptCommentTodo          Todo
  HiLink javaScriptSpecial              Special
  HiLink javaScriptStringS              String
  HiLink javaScriptStringD              String
  HiLink javaScriptCharacter            Character
  HiLink javaScriptSpecialCharacter     javaScriptSpecial
  HiLink javaScriptNumber               Number
  HiLink javaScriptFloat                Float
  HiLink javaScriptConditional          Conditional
  HiLink javaScriptRepeat               Repeat
  HiLink javaScriptBranch               Conditional
  HiLink javaScriptOperator             Operator
  HiLink javaScriptOps                  Operator
  HiLink javaScriptStatement            Statement
  HiLink javaScriptFunction             Function
  HiLink javaScriptError                Error
  HiLink javaScrParenError              javaScriptError
  HiLink javaScriptNull                 Keyword
  HiLink javaScriptBoolean              Boolean
  HiLink javaScriptRegexpString         String

  HiLink javaScriptNaN                  Number

  HiLink javaScriptDot                  Dot
  HiLink javaScriptType                 Type
  HiLink javaScriptBraces               Braces
  HiLink javaScriptParens               Parens
  HiLink javaScriptComma                Comma
  HiLink javaScriptSemicolon            Semicolon

  HiLink Dot                            Punctuation
  HiLink Type                           Punctuation
  HiLink Braces                         Punctuation
  HiLink Parens                         Punctuation
  HiLink Comma                          Punctuation
  HiLink Semicolon                      Punctuation

  HiLink javaScriptIdentifier           Identifier
  HiLink javaScriptLabel                Label
  HiLink javaScriptException            Exception
  HiLink javaScriptMessage              Keyword
  HiLink javaScriptGlobal               Identifier
  HiLink javaScriptMember               Identifier
  HiLink javaScriptDeprecated           Exception
  HiLink javaScriptReserved             Keyword
  HiLink javaScriptDebug                Debug
  HiLink javaScriptConstant             Label

  delcommand HiLink
endif

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
