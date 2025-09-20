# cd to directory of dotfiles based on this script.
$DOTFILES = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -Parent
Set-Location $DOTFILES

$VSCODE = "$env:APPDATA\Code\User"

function main() {
  install "vimrc"
  install_cp "gitconfig"
  install "gitignore"
  install "welcome"

  install_as "ahk\misc.ahk" "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\misc.ahk"
  mkdir (Split-Path $profile)
  install_as "Microsoft.PowerShell_profile.ps1" $profile
  install_as "win-terminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
  install_as "vscode\keybindings.json" "$VSCODE\keybindings.json"
  install_as "vscode\settings.json" "$VSCODE\settings.json"
  install_as "vscode\snippets" "$VSCODE\snippets"

  Write-Host ""
  Write-Host -Background Red -Foreground Black "  Don't forget to use OpenSSH for 1Password  "
  Write-Host ""
  Write-Host "git config --global core.sshCommand ""C:/Windows/System32/OpenSSH/ssh.exe"""
}

function install($path) {
  install_as $path "$HOME\.$path"
}

function install_cp($path) {
  Copy-Item $path "$HOME\.$path"
}

function install_as($path, $dest) {
  $src = "$DOTFILES\$path"
  show $src $dest
  if (Test-Path $dest) {
    if (is_symlink $dest) {
      Remove-Item -Recurse -Force $dest
    } else {
      if (-Not (confirm "Replace $dest with symlink?")) {
        return
      }
      Remove-Item -Recurse -Force $dest
    }
  }
  $dir = Split-Path -Path $path
  maybe_create_prefix $dir
  link_it_up $src $dest
}

function show($src, $dest) {
  Write-Host -NoNewline -Foreground Green $src
  Write-Host -NoNewline -Foreground Blue " => "
  Write-Host -NoNewline -Foreground Red $dest
  Write-Host
}

function link_it_up($src, $dest) {
  if (Test-Path -PathType Container -Path $src) {
    cmd /c mklink /d $dest $src | Out-Null
  } else {
    cmd /c mklink $dest $src | Out-Null
  }
}

function maybe_create_prefix($path) {
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

function is_symlink($path) {
  Get-Item $path | Where-Object {
    $_.Attributes -match "ReparsePoint"
  }
}

main
