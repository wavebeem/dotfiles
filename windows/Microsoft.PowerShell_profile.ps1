$color = "Green"

Set-PSReadlineOption -ForegroundColor $color -TokenKind None
Set-PSReadlineOption -ForegroundColor $color -TokenKind Comment
Set-PSReadlineOption -ForegroundColor $color -TokenKind Keyword
Set-PSReadlineOption -ForegroundColor $color -TokenKind String
Set-PSReadlineOption -ForegroundColor $color -TokenKind Operator
Set-PSReadlineOption -ForegroundColor $color -TokenKind Variable
Set-PSReadlineOption -ForegroundColor $color -TokenKind Command
Set-PSReadlineOption -ForegroundColor $color -TokenKind Parameter
Set-PSReadlineOption -ForegroundColor $color -TokenKind Type
Set-PSReadlineOption -ForegroundColor $color -TokenKind Number
Set-PSReadlineOption -ForegroundColor $color -TokenKind Member

Set-Alias l ls
Set-Alias ll ls

function prompt {
  Write-Host ""
  Write-Host -NoNewline -ForegroundColor Blue (hostname)
  Write-Host -NoNewline -ForegroundColor Gray " :::"
  return " "
}

function dim {
  $size = $host.UI.RawUI.WindowSize
  Write-Host $size.Width "by" $size.Height
}

function .. {
  Set-Location ..
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
