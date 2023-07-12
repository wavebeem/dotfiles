### Run both of these commands in an Admin PowerShell window:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

fsutil behavior set SymlinkEvaluation L2L:1 L2R:0 R2L:0 R2R:0
```

### Run this in a regular PowerShell window:

```powershell
New-Item $profile -ItemType File -Force
```

### Create a shortcut file...

```
"%AppData%\Microsoft\Windows\Start Menu\Programs\Startup"
```

pointing to

```
"AHK\misc.ahk"
```
