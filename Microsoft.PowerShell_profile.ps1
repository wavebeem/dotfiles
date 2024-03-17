Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

Set-PSReadLineOption -Colors @{
  Command = "Yellow"
  Number = "Gray"
  Member = "Gray"
  Operator = "Gray"
  Type = "Gray"
  Variable = "Magenta"
  Parameter = "Magenta"
  ContinuationPrompt = "Gray"
  Default = "Gray"
}

$x = $Host.PrivateData
$x.ErrorForegroundColor = "Red"
$x.ErrorBackgroundColor = "Black"
$x.WarningForegroundColor = "Yellow"
$x.WarningBackgroundColor = "Black"
$x.DebugForegroundColor = "Yellow"
$x.DebugBackgroundColor = "Black"
$x.VerboseForegroundColor = "Yellow"
$x.VerboseBackgroundColor = "Black"
$x.ProgressForegroundColor = "DarkGray"
$x.ProgressBackgroundColor = "Black"

Set-Alias g "git status"

$esc = [char]27
$bold = "$esc[1m"

function __install.eza {
  winget install eza-community.eza
}

if (Get-Command eza -ErrorAction SilentlyContinue) {
  Set-Alias ls eza -Option AllScope

  function ll() {
    eza -l $args
  }
} else {
  Set-Alias l ls
  Set-Alias ll ls
}

function prompt {
  Write-Host ""
  Write-Host -NoNewline -ForegroundColor Green "${bold}pwsh:"
  return " "
}

function .. {
  Set-Location ..
}

function s {
  Set-Location ..
  Write-Output (Get-Location).Path
}
