# cd to directory of dotfiles based on this script.
$scriptDir = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -Parent
$dir = Resolve-Path (Join-Path $scriptDir "..")
cd $dir

function install($path) {
  $dir = Split-Path $Path
  $filename = (ls $path).Name
  if ($dir) {
    $prefix = Resolve-Path (Join-Path $HOME ".$dir")
    maybeCreatePrefix $prefix
    $dFilename = Join-Path ".$dir" $filename
  } else {
    $dFilename = ".$filename"
  }
  $fullPath = Resolve-Path $path
  $destFile = Join-Path $HOME $dFilename
  if ((isSymlink($destFile)) -or (confirmReplacement($destFile))) {
    Remove-Item $destFile
  }
  linkItUp $destFile $fullPath
}

function linkItUp($destFile, $fullPath) {
  Write-Host -NoNewline -Foreground Green $fullPath
  Write-Host -NoNewline -Foreground Blue " => "
  Write-Host -NoNewline -Foreground Red $destFile
  Write-Host
  New-Item -ItemType SymbolicLink -Path $destFile -Value $fullPath | Out-Null
}

function maybeCreatePrefix($path) {
  if (-Not (Test-Path -PathType Container $path)) {
    New-Item $path
  }
}

function confirmReplacement($path) {
  $title = "Replace $path with symlink?"
  $message = ""
  $choices = @("y", "n")
  $answer = $host.ui.PromptForChoice($title, $message, $choices, 1)
  return $answer -eq 0
}

function isSymlink($path) {
  Get-ChildItem $path | Where-Object { $_.Attributes -match "ReparsePoint" }
}

install "vimrc"
install "gitconfig"
install "atom\config.cson"
install "atom\init.coffee"
install "atom\keymap.cson"
install "atom\snippets.cson"
install "atom\styles.less"

### TODO: Install VS Code files too
# installAs "vscode/keybindings.json" "$VSCODE/keybindings.json"
# installAs "vscode/settings.json" "$VSCODE/settings.json"