# cd to directory of dotfiles based on this script.
$scriptDir = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -Parent
$DOTFILES = Resolve-Path (Join-Path $scriptDir "..")
cd $DOTFILES

$VSCODE = "$env:APPDATA\Code\User"

function install($path) {
  $dest = "$HOME\.$path"
  installAs $path $dest
}

function installAs($path, $dest) {
  if (Test-Path $dest) {
    if (isSymlink $dest) {
      Remove-Item $dest
    } else {
      if (-Not (confirm "Replace $dest with symlink?")) {
        return
      }
      Remove-Item $dest
    }
  }
  $dir = (Get-Item $path).DirectoryName
  maybeCreatePrefix $dir
  $src = "$DOTFILES\$path"
  linkItUp $src $dest
}

function linkItUp($src, $dest) {
  Write-Host -NoNewline -Foreground Green $src
  Write-Host -NoNewline -Foreground Blue " => "
  Write-Host -NoNewline -Foreground Red $dest
  Write-Host
  New-Item -ItemType SymbolicLink -Path $dest -Value $src | Out-Null
}

function maybeCreatePrefix($path) {
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

install "vimrc"
install "gitconfig"
install "atom\config.cson"
install "atom\init.coffee"
install "atom\keymap.cson"
install "atom\snippets.cson"
install "atom\styles.less"

installAs "vscode\keybindings.json" "$VSCODE\keybindings.json"
installAs "vscode\settings.json" "$VSCODE\settings.json"