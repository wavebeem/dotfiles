# cd to directory of dotfiles based on this script.
$DOTFILES = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -Parent
Set-Location $DOTFILES

$VSCODE = "$env:APPDATA\Code\User"

function main() {
  install "vimrc"
  install "gitconfig"
  install "gitignore"
  install "welcome"

  installAs "ahk\misc.ahk" "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\misc.ahk"
  installAs "Microsoft.PowerShell_profile.ps1" $profile
  installAs "win-terminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
  installAs "vscode\keybindings.json" "$VSCODE\keybindings.json"
  installAs "vscode\settings.json" "$VSCODE\settings.json"
  installAs "vscode\snippets" "$VSCODE\snippets"
}

function install($path) {
  $dest = "$HOME\.$path"
  installAs $path $dest
}

function installAs($path, $dest) {
  $src = "$DOTFILES\$path"
  show $src $dest
  if (Test-Path $dest) {
    if (isSymlink $dest) {
      Remove-Item -Force $dest
    } else {
      if (-Not (confirm "Replace $dest with symlink?")) {
        return
      }
      Remove-Item -Force $dest
    }
  }
  $dir = Split-Path -Path $path
  maybeCreatePrefix $dir
  linkItUp $src $dest
}

function show($src, $dest) {
  Write-Host -NoNewline -Foreground Green $src
  Write-Host -NoNewline -Foreground Blue " => "
  Write-Host -NoNewline -Foreground Red $dest
  Write-Host
}

function linkItUp($src, $dest) {
  if (Test-Path -PathType Container -Path $src) {
    cmd /c mklink /d $dest $src | Out-Null
  } else {
    cmd /c mklink $dest $src | Out-Null
  }
}

function maybeCreatePrefix($path) {
  if (($path -Eq $null) -Or ($path -Eq "")) {
    return
  }
  if (-Not (Test-Path -PathType Container $path)) {
    New-Item $path
  }
}

function confirm($title) {
  $message = ""
  $choices = @("y", "n")
  $answer = $host.ui.PromptForChoice($title, $message, $choices, 1)
  return $answer -eq 0
}

function isSymlink($path) {
  Get-Item $path | Where-Object {
    $_.Attributes -match "ReparsePoint"
  }
}

main
