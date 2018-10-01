$c1 = "Yellow"

Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

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

$host.PrivateData.ErrorForegroundColor = "Red"
$host.PrivateData.ErrorBackgroundColor = $host.ui.RawUI.BackgroundColor

Set-Alias l ls
Set-Alias ll ls

function WC($bg, $fg, $str) {
  Write-Host -NoNewline -BackgroundColor $bg -ForegroundColor $fg $str
}

function prompt {
  Write-Host ""
  Write-Host ""
  WC Cyan White "  $env:UserName  "
  Write-Host -NoNewline " "
  WC Green White "  @$(hostname)  "
  Write-Host -NoNewline " "
  WC Cyan White "  $(Get-Location)  "
  Write-Host ""
  Write-Host -NoNewline -ForeGroundColor Blue ">"
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
