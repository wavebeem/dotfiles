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
    SleepDo 3 setxkbmap us \
        -variant altgr-intl \
        -option  nodeadkeys  \
        -option  compose:ralt \
        -option  compose:caps  &

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

    # Enable compositing (maybe)
    COMPOSITE on &
}

# Launch a window manager with proper permissions
Start() {
    UsingDriver nvidia &&
        OnHost truffle &&
        nvidia-settings -l
    OnHost truffle && conky &
    exec ck-launch-session "$@"
}

WM=${WM:-$default_wm}
if [ -z "$DE" ]; then
    SleepDo 2 Autostart &
    Start "$WM"
else
    Start "$DE"
fi
