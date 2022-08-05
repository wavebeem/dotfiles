Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

Set-PSReadLineOption -Colors @{
  Command = 'Magenta'
  Number = 'DarkGray'
  Member = 'DarkGray'
  Operator = 'DarkGray'
  Type = 'DarkGray'
  Variable = 'DarkGreen'
  Parameter = 'DarkGreen'
  ContinuationPrompt = 'DarkGray'
  Default = 'DarkGray'
}

$Host.PrivateData.ErrorForegroundColor = "Red"
$Host.PrivateData.ErrorBackgroundColor = "White"
$Host.PrivateData.WarningForegroundColor = "Yellow"
$Host.PrivateData.WarningBackgroundColor = "White"
$Host.PrivateData.DebugForegroundColor = "Yellow"
$Host.PrivateData.DebugBackgroundColor = "White"
$Host.PrivateData.VerboseForegroundColor = "Yellow"
$Host.PrivateData.VerboseBackgroundColor = "White"
$Host.PrivateData.ProgressForegroundColor = "DarkGray"
$Host.PrivateData.ProgressBackgroundColor = "White"

Set-Alias l ls
Set-Alias ll ls
Set-Alias g "git status"

$esc = [char]27
$bold = "$esc[1m"

function prompt {
  Write-Host ""
  Write-Host -NoNewline -ForegroundColor Cyan "${bold}pwsh:"
  return " "
}

function .. {
  Set-Location ..
}
