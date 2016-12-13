# Takes a hex color string with no hash
# Returns an int describing the color
function HexColor([string]$s) {
  $r = $s.Substring(0, 2)
  $g = $s.Substring(2, 2)
  $b = $s.Substring(4, 2)
  [int]"0x00$b$g$r"
}

$C = @{}
$C.Black   = HexColor("222222")
$C.Blue    = HexColor("3F51B5")
$C.Green   = HexColor("4CAF50")
$C.Cyan    = HexColor("00BCD4")
$C.Red     = HexColor("f44336")
$C.Magenta = HexColor("9C27B0")
$C.Yellow  = HexColor("FFEB3B")
$C.White   = HexColor("eeeeee")
$C.Gray    = HexColor("888888")

### Color table codes ###
# 0 = Black
# 1 = Blue
# 2 = Green
# 3 = Aqua
# 4 = Red
# 5 = Purple
# 6 = Yellow
# 7 = White
# 8 = Gray
# 9 = Light Blue
# A = Light Green
# B = Light Aqua
# C = Light Red
# D = Light Purple
# E = Light Yellow
# F = Bright White

Push-Location
Set-Location HKCU:\Console

Set-ItemProperty . ColorTable00 -type DWORD -value $C.Black
Set-ItemProperty . ColorTable01 -type DWORD -value $C.Blue
Set-ItemProperty . ColorTable02 -type DWORD -value $C.Green
Set-ItemProperty . ColorTable03 -type DWORD -value $C.Cyan
Set-ItemProperty . ColorTable04 -type DWORD -value $C.Red
Set-ItemProperty . ColorTable05 -type DWORD -value $C.Magenta
Set-ItemProperty . ColorTable06 -type DWORD -value $C.Yellow
Set-ItemProperty . ColorTable07 -type DWORD -value $C.White
Set-ItemProperty . ColorTable08 -type DWORD -value $C.Black
Set-ItemProperty . ColorTable09 -type DWORD -value $C.Blue
Set-ItemProperty . ColorTable10 -type DWORD -value $C.Green
Set-ItemProperty . ColorTable11 -type DWORD -value $C.Cyan
Set-ItemProperty . ColorTable12 -type DWORD -value $C.Red
Set-ItemProperty . ColorTable13 -type DWORD -value $C.Magenta
Set-ItemProperty . ColorTable14 -type DWORD -value $C.Yellow
Set-ItemProperty . ColorTable15 -type DWORD -value $C.White

Set-ItemProperty . PopupColors  -type DWORD -value 0x000000f8
Set-ItemProperty . ScreenColors -type DWORD -value 0x0000000f

# Set-ItemProperty . CursorSize -type DWORD -value 0x00000019
# Set-ItemProperty . FaceName -type STRING -value "Input"
# Set-ItemProperty . FontFamily -type DWORD -value 0x00000036
# Set-ItemProperty . FontSize -type DWORD -value 0x00120000 # 18pt
# Set-ItemProperty . FontWeight -type DWORD -value 0x00000190 # Normal
# Set-ItemProperty . FullScreen -type DWORD -value 0x00000000
# Set-ItemProperty . HistoryBufferSize -type DWORD -value 0x00000063
# Set-ItemProperty . HistoryNoDup -type DWORD -value 0x00000001
# Set-ItemProperty . InsertMode -type DWORD -value 0x00000001
# Set-ItemProperty . NumberOfHistoryBuffers -type DWORD -value 0x00000004
# Set-ItemProperty . QuickEdit -type DWORD -value 0x00000001
# Set-ItemProperty . ScreenBufferSize -type DWORD -value 0x03e7007d #ScreenBufferSize 125 w x 999 h
# Set-ItemProperty . WindowSize -type DWORD -value 0x0028007d #WindowSize 125 w x 40 h

Pop-Location
$Host.PrivateData.DebugBackgroundColor = "DarkGray"
$Host.PrivateData.ErrorBackgroundColor = "DarkGray"
################################################################################

$color = "Cyan"
Set-PSReadlineOption -TokenKind None -ForegroundColor $color
Set-PSReadlineOption -TokenKind Comment -ForegroundColor $color
Set-PSReadlineOption -TokenKind Keyword -ForegroundColor $color
Set-PSReadlineOption -TokenKind String -ForegroundColor $color
Set-PSReadlineOption -TokenKind Operator -ForegroundColor $color
Set-PSReadlineOption -TokenKind Variable -ForegroundColor $color
Set-PSReadlineOption -TokenKind Command -ForegroundColor $color
Set-PSReadlineOption -TokenKind Parameter -ForegroundColor $color
Set-PSReadlineOption -TokenKind Type -ForegroundColor $color
Set-PSReadlineOption -TokenKind Number -ForegroundColor $color
Set-PSReadlineOption -TokenKind Member -ForegroundColor $color

Set-Alias l ls

function prompt {
  Write-Host ""
  Write-Host ">" -NoNewline -ForegroundColor $color
  return " "
}


function g {
  git status
}

function gco {
  git checkout $args
}

function gaa {
  git add -A $args
}

function gg {
  git commit $args
}

function gd {
  git diff $args
}

function gdd {
  git diff --cached $args
}
