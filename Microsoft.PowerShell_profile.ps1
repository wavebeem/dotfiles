Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineOption -ContinuationPrompt "? "

# Windows PowerShell 5.1 ships PSReadLine 2.0.0, which lacks prediction support
# entirely (added in 2.1.0) and the InlinePrediction color (2.2.0)
$__psrlVersion = (Get-Module PSReadLine).Version

if ($__psrlVersion -ge [version]"2.1.0") {
  # Inline gray suggestions from history, like zsh-autosuggestions
  Set-PSReadlineOption -PredictionSource History
}

function __theme.set-light() {
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
  if ($__psrlVersion -ge [version]"2.2.0") {
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

function __theme.set-dark() {
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
  if ($__psrlVersion -ge [version]"2.2.0") {
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

function g() {
  git status $args
}

function gl() {
  git log $args
}

function d() {
  (Get-Location).Path
}

# Easy open files
function o() {
  if ($args) {
    Invoke-Item @args
  } else {
    Invoke-Item .
  }
}

$esc = [char]27
function ansi {
  "$esc[$($args -join ';')m"
}
$bold = ansi 1

function __install.eza {
  winget install eza-community.eza
}

if (Get-Command eza -ErrorAction SilentlyContinue) {
  function ls() {
    eza --group-directories-first $args
  }

  function l() {
    ls $args
  }

  function ll() {
    ls -l $args
  }

  function la() {
    ls -la $args
  }
} else {
  Set-Alias l ls
  Set-Alias ll ls
}

# Python virtualenv assumes you want your shell prompt mangled without this
$env:VIRTUAL_ENV_DISABLE_PROMPT = "true"

# Still easier to use vim for quick edits even though I prefer VS Code
if (Get-Command nvim -ErrorAction SilentlyContinue) {
  $env:EDITOR = "nvim"
  Set-Alias vim nvim
} else {
  $env:EDITOR = "vim"
}
$env:GIT_EDITOR = $env:EDITOR
$env:VISUAL = $env:EDITOR

# Abbreviate a leading $HOME to ~ (only when it's a real prefix, not a substring)
function __path.tilde($path) {
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
  $cwd = __path.tilde $rawCwd

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

function __git.fix () {
  git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
}

__theme.set-dark

# Windows default powershell doesn't have `cd` hooks. Got it, thanks.
$env:MISE_PWSH_CHPWD_WARNING = "0"
# When `cd` hooks are missing, mise wraps your `prompt` function. So keep this
# after `prompt` is defined.
mise activate pwsh | Out-String | Invoke-Expression
