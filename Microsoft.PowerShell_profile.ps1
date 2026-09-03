function _command.exists {
  param([string]$cmd)
  [bool](Get-Command $cmd -ErrorAction SilentlyContinue)
}

Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineOption -ContinuationPrompt "? "
# Inline gray suggestions from history, like zsh-autosuggestions
# (PredictionSource/InlinePrediction require PSReadLine 2.1+, not present
# in the PSReadLine that ships with Windows PowerShell 5.1)
$__supportsPrediction = (Get-Command Set-PSReadLineOption).Parameters.ContainsKey('PredictionSource')
if ($__supportsPrediction) {
  Set-PSReadlineOption -PredictionSource History
}

function _theme.set-light() {
  $colors = @{
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
  if ($__supportsPrediction) {
    $colors.InlinePrediction = "#008888"
  }
  Set-PSReadLineOption -Colors $colors

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

function _theme.set-dark() {
  $colors = @{
      ContinuationPrompt = "#928374"
      Emphasis = "#fe8019"
      Error = "#fb4934"
      Selection = "#665c54"
      Default = "#ebdbb2"
      Comment = "#928374"
      Keyword = "#fb4934"
      String = "#b8bb26"
      Operator = "#ebdbb2"
      Variable = "#83a598"
      Command = "#fabd2f"
      Parameter = "#d3869b"
      Type = "#8ec07c"
      Number = "#d3869b"
      Member = "#ebdbb2"
  }
  if ($__supportsPrediction) {
    $colors.InlinePrediction = "#8ec07c"
  }
  Set-PSReadLineOption -Colors $colors

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

function g {
  param([Parameter(ValueFromRemainingArguments)][string[]]$Args)
  git status $args
}

function gl {
  param([Parameter(ValueFromRemainingArguments)][string[]]$Args)
  git log $args
}

function d() {
  (Get-Location).Path
}

function v() {
  [string]$PSVersionTable.PSVersion
}

# Easy open files
function o {
  param([Parameter(ValueFromRemainingArguments)][string[]]$Args)
  if ($args) {
    Invoke-Item @args
  } else {
    Invoke-Item .
  }
}

$esc = [char]27
function ansi {
  param([Parameter(ValueFromRemainingArguments)][string[]]$Args)
  "$esc[$($args -join ';')m"
}
$bold = ansi 1

function _install.eza {
  winget install eza-community.eza
}

if (_command.exists eza) {
  function ls {
    param([Parameter(ValueFromRemainingArguments)][string[]]$Args)
    eza --group-directories-first $args
  }

  function l {
    param([Parameter(ValueFromRemainingArguments)][string[]]$Args)
    ls $args
  }

  function ll {
    param([Parameter(ValueFromRemainingArguments)][string[]]$Args)
    ls -l $args
  }

  function la {
    param([Parameter(ValueFromRemainingArguments)][string[]]$Args)
    ls -la $args
  }
} else {
  Set-Alias l ls
  Set-Alias ll ls
}

# Python virtualenv assumes you want your shell prompt mangled without this
$env:VIRTUAL_ENV_DISABLE_PROMPT = "true"

# Still easier to use vim for quick edits even though I prefer VS Code
if (_command.exists nvim) {
  $env:EDITOR = "nvim"
  Set-Alias vim nvim
} else {
  $env:EDITOR = "vim"
}
$env:GIT_EDITOR = $env:EDITOR
$env:VISUAL = $env:EDITOR

# Abbreviate a leading $HOME to ~ (only when it's a real prefix, not a substring)
function _path.tilde {
  param([string]$path)
  $sep = [IO.Path]::DirectorySeparatorChar
  $alt = [IO.Path]::AltDirectorySeparatorChar
  $path = $path.Replace($alt, $sep)
  $hdir = $HOME.Replace($alt, $sep).TrimEnd($sep)
  if ($path -eq $hdir) {
    return "~"
  }
  if ($path.StartsWith($hdir + $sep, [StringComparison]::OrdinalIgnoreCase)) {
    return "~" + $path.Substring($hdir.Length)
  }
  return $path
}

function prompt {
  $rawCwd = (Get-Location).Path
  $cwd = _path.tilde $rawCwd

  $edge = ansi 90
  $leaf = ansi 32
  $reset = ansi 0
  $sep = [IO.Path]::DirectorySeparatorChar
  # Gray path, green leaf
  $parts = $cwd.Split($sep)
  $parts[-1] = "${leaf}$($parts[-1])"
  $cwdColored = "${edge}" + ($parts -join $sep)
  Write-Host ""
  Write-Host "${bold}${cwdColored}${reset}"
  Write-Host -NoNewline "${bold}${edge}>${reset}"
  return " "
}

function .. {
  Set-Location ..
}

function s {
  Set-Location ..
  Write-Output (Get-Location).Path
}

function _git.fix () {
  git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
}

function _convert.apng-to-webp {
  param(
    [Parameter(Mandatory)][string]$Source,
    [string]$OutFile
  )
  if (-not $OutFile) {
    $OutFile = [System.IO.Path]::GetFileNameWithoutExtension($Source) + ".webp"
  }
  ffmpeg -y -i $Source -lossless 1 -loop 0 $OutFile
}

_theme.set-dark

# Windows default powershell doesn't have `cd` hooks. Got it, thanks.
$env:MISE_PWSH_CHPWD_WARNING = "0"
# When `cd` hooks are missing, mise wraps your `prompt` function. So keep this
# after `prompt` is defined.
if (_command.exists mise) {
  mise activate pwsh | Out-String | Invoke-Expression
}
