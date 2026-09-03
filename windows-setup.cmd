@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
  echo This must be run as Administrator - right-click, "Run as administrator".
  pause
  exit /b 1
)

powershell -NoProfile -Command ^
  "Set-ExecutionPolicy -Scope CurrentUser RemoteSigned"
fsutil behavior set SymlinkEvaluation L2L:1 L2R:0 R2L:0 R2R:0
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" ^
  /v AllowDevelopmentWithoutDevLicense ^
  /t REG_DWORD ^
  /d 1 ^
  /f

powershell -NoProfile -File "%~dp0install.ps1"
pause
