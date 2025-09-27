#Requires AutoHotKey v2.0

; Text macros
::;;right::→
::;;up::↑
::;;down::↓
::;;left::←
::;;en::–
::;;em::—

; Caps Lock sends Escape
CapsLock::Esc

; Alt-W sends Alt-F4
!w::!F4

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
