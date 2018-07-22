#SingleInstance force

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
