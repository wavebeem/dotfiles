$c1 = "Yellow"

Set-PSReadlineOption -ForegroundColor $c1 -TokenKind None
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind Comment
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind Keyword
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind String
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind Operator
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind Variable
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind Command
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind Parameter
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind Type
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind Number
Set-PSReadlineOption -ForegroundColor $c1 -TokenKind Member

Set-Alias l ls
Set-Alias ll ls

function prompt {
  Write-Host ""
  Write-Host ""
  Write-Host -NoNewline -ForegroundColor Cyan $env:UserName
  Write-Host -NoNewline -ForegroundColor Cyan " :: "
  Write-Host -NoNewline -ForegroundColor Green (hostname)
  Write-Host -NoNewline -ForegroundColor Cyan " :: "
  Write-Host -NoNewline -ForegroundColor Cyan (Get-Location)
  Write-Host ""
  Write-Host -NoNewline -ForeGroundColor Cyan ">>-"
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
