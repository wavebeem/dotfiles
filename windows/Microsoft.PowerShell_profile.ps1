$color = "Cyan"
Set-PSReadlineOption -TokenKind None -ForegroundColor $color
Set-PSReadlineOption -TokenKind Comment -ForegroundColor $color
Set-PSReadlineOption -TokenKind Keyword -ForegroundColor $color
Set-PSReadlineOption -TokenKind String -ForegroundColor $color
Set-PSReadlineOption -TokenKind Operator -ForegroundColor $color
Set-PSReadlineOption -TokenKind Variable -ForegroundColor $color
Set-PSReadlineOption -TokenKind Command -ForegroundColor $color
Set-PSReadlineOption -TokenKind Parameter -ForegroundColor $color
Set-PSReadlineOption -TokenKind Type -ForegroundColor $color
Set-PSReadlineOption -TokenKind Number -ForegroundColor $color
Set-PSReadlineOption -TokenKind Member -ForegroundColor $color

Set-Alias l ls

function prompt {
  Write-Host ""
  Write-Host "=>" -NoNewline -ForegroundColor $color
  return " "
}

function g {
  git status
}

function gco {
  git checkout $args
}

function gaa {
  git add -A $args
}

function gg {
  git commit $args
}

function gd {
  git diff $args
}

function gdd {
  git diff --cached $args
}
