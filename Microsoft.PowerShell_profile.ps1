Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

$host.PrivateData.ErrorForegroundColor = "Red"
$host.PrivateData.ErrorBackgroundColor = $host.ui.RawUI.BackgroundColor

Set-Alias l ls
Set-Alias ll ls
Set-Alias g "git status"

function prompt {
  Write-Host ""
  Write-Host -NoNewline -ForegroundColor Cyan "pwsh:"
  return " "
}

function .. {
  Set-Location ..
}
