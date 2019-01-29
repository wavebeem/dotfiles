$c1 = "Yellow"

Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

Set-PSReadLineOption -Colors @{
  ContinuationPrompt = $c1
  Emphasis = $c1
  Error = $c1
  Selection = $c1
  Default = $c1
  Comment = $c1
  Keyword = $c1
  String = $c1
  Operator = $c1
  Variable = $c1
  Command = $c1
  Parameter = $c1
  Type = $c1
  Number = $c1
  Member = $c1
}

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

function rmrf {
  Remove-Item -Recurse -Force $args
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
