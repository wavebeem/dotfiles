; Reload the script without confirmation when re-executing
#SingleInstance force

; I guess this matters? But calling "Send" still mangles Unicode characters
FileEncoding UTF-8-RAW

; Unbind Ctrl-Shift-Q to prevent accidental program quits
^+q::Return

; Send an ISO8601-ish filesystem timestamp, good for naming files
^!t::
  FormatTime, time, A_now, yyyy-MM-dd HH.mm.ss
  Send %time%
  Return

; Send an ISO8601-ish filesystem timestamp, date only
^!d::
  FormatTime, time, A_now, yyyy-MM-dd
  Send %time%
  Return

; Reload this script and display a notification
^!y::
  TrayTip, AutoHotkey, AutoHotkey configuration reloaded
  Reload
  Return

; Run a windowed game "docked" to the top left of my screen, so the titlebar is
; pushed off screen to avoid distracting me (#FFFFFF white titlebars are painful
; to look at while gaming)
^!u::
  WinMove, A, , -3, -26, DEFAULT, DEFAULT
  Return

