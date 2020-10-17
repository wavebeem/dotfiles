; Reload the script without confirmation when re-executing
#SingleInstance force

; I guess this matters? But calling "Send" still mangles Unicode characters
FileEncoding UTF-8-RAW

; Alt-Q to close windows
!q::Send !{F4}

; Unbind Ctrl-Shift-Q to prevent accidental program quits
^+q::Return

; Send an ISO8601-ish filesystem timestamp, good for naming files
^!t::
  FormatTime, time, A_now, yyyy-MM-dd HH.mm.ss
  Send %time%
  Return

; Send an ISO8601-ish filesystem timestamp, good for naming files
^!d::
  FormatTime, time, A_now, yyyy-MM-dd
  Send %time%
  Return

; Reload this script and display a notification
^!y::
  TrayTip, AutoHotkey, AutoHotkey configuration reloaded
  Reload
  Return
