Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

Set-PSReadLineOption -Colors @{
  Command = 'Yellow'
  Number = 'Gray'
  Member = 'Gray'
  Operator = 'Gray'
  Type = 'Gray'
  Variable = 'Green'
  Parameter = 'Green'
  ContinuationPrompt = 'Gray'
  Default = 'Gray'
}

$Host.PrivateData.ErrorForegroundColor = "Red"
$Host.PrivateData.ErrorBackgroundColor = "Black"
$Host.PrivateData.WarningForegroundColor = "Yellow"
$Host.PrivateData.WarningBackgroundColor = "Black"
$Host.PrivateData.DebugForegroundColor = "Yellow"
$Host.PrivateData.DebugBackgroundColor = "Black"
$Host.PrivateData.VerboseForegroundColor = "Yellow"
$Host.PrivateData.VerboseBackgroundColor = "Black"
$Host.PrivateData.ProgressForegroundColor = "DarkGray"
$Host.PrivateData.ProgressBackgroundColor = "Black"

Set-Alias l ls
Set-Alias ll ls
Set-Alias g "git status"

$esc = [char]27
$bold = "$esc[1m"

function prompt {
  Write-Host ""
  Write-Host -NoNewline -ForegroundColor Magenta "${bold}pwsh:"
  return " "
}

function .. {
  Set-Location ..
}
