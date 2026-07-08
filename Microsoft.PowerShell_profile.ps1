Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineOption -ContinuationPrompt "? "

function __theme.set-light() {
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

function __theme.set-dark() {
  Set-PSReadLineOption -Colors @{
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
function ansi {
  "$esc[$($args -join ';')m"
}
$bold = ansi 1

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

# Plain ANSI colors — relies on the terminal's colorscheme (Gruvbox
# everywhere) to remap the base 16 colors, so no truecolor/256 detection.
function prompt {
  $ok = $?
  $rawCwd = (Get-Location).Path
  $cwd = __path.tilde $rawCwd

  $edge = ansi 90
  $dir = ansi 32
  $err = ansi 31
  if (-not $ok) {
    $dir = $err
  }
  $reset = ansi 0
  Write-Host ""
  Write-Host -NoNewline "${bold}${dir}${cwd} ${edge}>${reset}"
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
