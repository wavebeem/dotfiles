; Reload the script without confirmation when re-executing
#SingleInstance force

; I guess this matters? But calling "Send" still mangles Unicode characters
FileEncoding UTF-8-RAW

; I can't live without this one now...
CapsLock::Control

; Alt-Q to close windows
!q::!F4

; Unbind Ctrl-Shift-Q to prevent accidental program quits
^+q::

; Alt-L to lock computer; annoyingly #l doesn't work on the RHS here
>!l::DllCall("LockWorkStation")

; Media keys
>!p::Media_Play_Pause
>![::Media_Prev
>!]::Media_Next

; Volume controls
>!;::Volume_Down
>!'::Volume_Up
>!Enter::Volume_Mute

; Unicode characters
>!c::Send {u+00a9} ; copyright
>!r::Send {u+00ae} ; registered trademark
>!8::Send {u+2022} ; bullet
>!-::Send {u+2013} ; en-dash
>!.::Send {u+2026} ; ellipses
>!0::Send {u+00b0} ; degree symbol
>!e::Send {u+00e9} ; e-acute
>!n::Send {u+00f1} ; n-tilde
>!+-::Send {u+2014} ; em-dash
