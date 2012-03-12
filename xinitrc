#!/bin/bash
# vim: set syn=sh:

bg_color="#000000"

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

    # Load keyboard stuff
    SleepDo 1 KBD-US

    ibus-daemon &

    # Load keybindings
    xbindkeys &

    # Scrobble songs on desktop
    killall mpdscribble
    mpdscribble &
    mpd ~/.mpd/mpd.conf &

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

    SleepDo 0.50 PANEL on &
}

# Launch a window manager with proper permissions
Start() {
    nvidia-settings -l &
    exec ck-launch-session "$@"
}

if [ -z "$DE" ]; then
    SleepDo 0.75 Autostart &
    #Autostart &
    Start openbox
else
    Start "$DE"
fi
