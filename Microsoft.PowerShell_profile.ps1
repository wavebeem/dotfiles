Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

function ThemeLight() {
  Set-PSReadLineOption -Colors @{
      ContinuationPrompt = "#666666"
      Emphasis = "#666666"
      Error = "#cc0000"
      Selection = "#666666"
      Default = "#666666"
      Comment = "#666666"
      Keyword = "#666666"
      String = "#008888"
      Operator = "#666666"
      Variable = "#008800"
      Command = "#880088"
      Parameter = "#666666"
      Type = "#666666"
      Number = "#666666"
      Member = "#666666"
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
}

function ThemeDark() {
  Set-PSReadLineOption -Colors @{
      ContinuationPrompt = "#cccccc"
      Emphasis = "#cccccc"
      Error = "#cccccc"
      Selection = "#cccccc"
      Default = "#cccccc"
      Comment = "#cccccc"
      Keyword = "#cccccc"
      String = "#cccccc"
      Operator = "#cccccc"
      Variable = "#cccccc"
      Command = "#cccccc"
      Parameter = "#cccccc"
      Type = "#cccccc"
      Number = "#cccccc"
      Member = "#cccccc"
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
}

function g() {
  git status $args
}

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

function FixGitOnWindows() {
  git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
}

ThemeLight
