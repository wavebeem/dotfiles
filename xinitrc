#!/bin/bash
# vim: set syn=sh:

source "$HOME/bin/lib/host.sh"
source "$HOME/bin/lib/driver.sh"

bg_color="#000000"
default_wm=openbox

# Enable Japanese input
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"

# Sleep before doing a command
SleepDo() {
    local time="$1"
    shift

    sleep "$time"
    eval "$@"
}

# Programs to help flesh out a window manager
Autostart() {
    xsetroot -solid "$bg_color" &
    nitrogen --restore &
    xscreensaver -no-splash &

    # Enable compose key
    SleepDo 1 setxkbmap us \
        -variant altgr-intl \
        -option  nodeadkeys  \
        -option  compose:ralt \
        -option  compose:caps  &

    # Fix Shift-Backspace not working...
    SleepDo 1 xmodmap -e "keycode 22 = BackSpace BackSpace BackSpace VoidSymbol VoidSymbol VoidSymbol Terminate_Server"

    ibus-daemon &

    # Load keybindings
    xbindkeys &

    # Scrobble songs on desktop
    OnHost truffle && mpdscribble &

    # Load font and cursor settings
    xrdb ~/.Xdefaults &

    # Remove bell
    xset b off &

    # Remove screen blanking
    xset -dpms &

    # Set cursor type on root window (avoid X-shape)
    xsetroot -cursor_name left_ptr &

    # Enable Ctrl-Alt-Backspace for zapping X
    setxkbmap -option terminate:ctrl_alt_bksp &

    # Disable touchpad while typing (for 0.5 seconds)
    OnHost profiterole && sydaemon -i 0.5 &

    SleepDo 0.25 COMPOSITE on &
    SleepDo 0.50 PANEL on &
}

# Launch a window manager with proper permissions
Start() {
    OnHost truffle && nvidia-settings -l &
    exec ck-launch-session "$@"
}

if [ -z "$DE" ]; then
    #SleepDo 0.5 Autostart &
    Autostart &
    Start WM on
else
    Start "$DE"
fi
