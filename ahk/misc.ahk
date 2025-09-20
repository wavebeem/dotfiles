#Requires AutoHotKey v2.0
; Reload the script without confirmation when re-executing
#SingleInstance force

; Ubind Win-C to prevent Cortana from opening
#c:: Return

; Unbind Ctrl-Shift-Q to prevent accidental program quits
^+q:: Return

; Send an ISO8601-ish filesystem timestamp, good for naming files
^!t::
{
  SendInput FormatTime(A_Now, "yyyy-MM-dd HH.mm.ss")
}

; Send an ISO8601-ish filesystem timestamp, date only
^!d::
{
  SendInput FormatTime(A_Now, "yyyy-MM-dd")
}

; Reload this script and display a notification
^!y::
{
  MsgBox "Configuration reloaded"
  Reload
}

; Edit AHK config
^!u::
{
  Edit
}
