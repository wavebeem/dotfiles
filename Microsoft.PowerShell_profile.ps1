$color = "Yellow"

Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

Set-PSReadLineOption -Colors @{
  ContinuationPrompt = $color
  Emphasis = $color
  Error = $color
  Selection = $color
  Default = $color
  Comment = $color
  Keyword = $color
  String = $color
  Operator = $color
  Variable = $color
  Command = $color
  Parameter = $color
  Type = $color
  Number = $color
  Member = $color
}

$host.PrivateData.ErrorForegroundColor = "Red"
$host.PrivateData.ErrorBackgroundColor = $host.ui.RawUI.BackgroundColor

Set-Alias l ls
Set-Alias ll ls

function prompt {
  Write-Host ""
  Write-Host -NoNewline -ForegroundColor Cyan "pwsh:"
  return " "
}

function .. {
  Set-Location ..
}

# TODO: How can I test if the shell is interactive?
# if ((-not $__welcome) -and (Test-Path ~/.welcome)) {
#   Get-Content ~/.welcome
# }
# $__welcome = $true
