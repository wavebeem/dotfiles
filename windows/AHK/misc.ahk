; Reload the script without confirmation when re-executing
#SingleInstance force

; I guess this matters? But calling "Send" still mangles Unicode characters
FileEncoding UTF-8-RAW

; I can't live without this one now...
CapsLock::Control

; Tap control and both shift keys for caps lock
^>+RShift::CapsLock

; Alt-Q to close windows
!q::!F4

; Unbind Ctrl-Shift-Q to prevent accidental program quits
^+q::Return

; Alt-L to lock computer; annoyingly #l doesn't work on the RHS here
>!l::DllCall("LockWorkStation")

; Media keys
>!\::Media_Play_Pause
>![::Media_Prev
>!]::Media_Next

; Volume controls
>!;::Volume_Down
>!'::Volume_Up
>!Enter::Volume_Mute

; Random taskbar icons flash using these keyboard shortcuts
; >!a::Send #^{Left}
; >!d::Send #^{Right}

; Unicode characters
>!c::Send {u+00a9} ; copyright
>!r::Send {u+00ae} ; registered trademark
>!t::Send {u+2122} ; trademark
>!8::Send {u+2022} ; bullet
>!-::Send {u+2013} ; en-dash
>!.::Send {u+2026} ; ellipses
>!0::Send {u+00b0} ; degree symbol
>!e::Send {u+00e9} ; e-acute
>!n::Send {u+00f1} ; n-tilde
>!+-::Send {u+2014} ; em-dash

+>!1::Send {u+25ca} ; lozenge
+>!2::Send {u+2605} ; star

+>!l::Send {u+03bb} ; lambda
+>!p::Send {u+03c0} ; pi
+>!d::Send {u+0394} ; delta

#>!w::Send {u+2191} ; N arrow
#>!d::Send {u+2192} ; E arrow
#>!s::Send {u+2193} ; S arrow
#>!a::Send {u+2190} ; W arrow
#>!e::Send {u+2197} ; NE arrow
#>!q::Send {u+2196} ; NW arrow
#>!c::Send {u+2198} ; SE arrow
#>!z::Send {u+2199} ; SW arrow
#>!x::Send {u+21BB} ; 360 arrow
