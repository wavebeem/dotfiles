Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

Set-PSReadLineOption -Colors @{
  ContinuationPrompt = "Yellow"
  Emphasis = "Yellow"
  Error = "Yellow"
  Selection = "Yellow"
  Default = "Yellow"
  Comment = "Yellow"
  Keyword = "Yellow"
  String = "Green"
  Operator = "Yellow"
  Variable = "Yellow"
  Command = "Magenta"
  Parameter = "Yellow"
  Type = "Yellow"
  Number = "Yellow"
  Member = "Yellow"
}

$host.PrivateData.ErrorForegroundColor = "Red"
$host.PrivateData.ErrorBackgroundColor = $host.ui.RawUI.BackgroundColor

Set-Alias l ls
Set-Alias ll ls
Set-Alias g "git status"

function prompt {
  Write-Host ""
  Write-Host -NoNewline -ForegroundColor Cyan "pwsh:"
  return " "
}

function .. {
  Set-Location ..
}
