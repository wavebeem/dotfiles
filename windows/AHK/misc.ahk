; Reload the script without confirmation when re-executing
#SingleInstance force

; I guess this matters? But calling "Send" still mangles Unicode characters
FileEncoding UTF-8-RAW

; I can't live without this one now...
; CapsLock::Control

; Sometimes caps lock is fun, I guess...
; <^RShift::CapsLock

; Alt-Q to close windows
!q::Send !{F4}

; Unbind Ctrl-Shift-Q to prevent accidental program quits
^+q::Return

; Send an ISO8601-ish filesystem timestamp, good for naming files
^#!t::
  FormatTime, time, A_now, yyyy-MM-dd HH.mm.ss
  Send %time%
  Return

; Rename file with timestamp from above
^#!r::
  Send {Alt}{F2}
  FormatTime, time, A_now, yyyy-MM-dd HH.mm.ss
  Send %time%
  Send {Enter}
  Return

; Reload this script and display a notification
^#!y::
  TrayTip, AutoHotkey, AutoHotkey configuration reloaded
  Reload
  Return

; Alt-L to lock computer; annoyingly #l doesn't work on the RHS here
>!l::DllCall("LockWorkStation")

; Media keys
^#!i::Send {Media_Prev}
^#!o::Send {Media_Next}
^#!p::Send {Media_Play_Pause}

; Volume controls
^#!k::Send {Volume_Mute}
^#!l::Send {Volume_Down}
^#!;::Send {Volume_Up}
