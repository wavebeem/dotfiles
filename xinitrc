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

    # Load keybindings
    xbindkeys &

    # Load font and cursor settings
    xrdb ~/.Xdefaults &

    # Set cursor type on root window (avoid X-shape)
    xsetroot -cursor_name left_ptr &

    SleepDo 0.50 PANEL on &
}

# Launch a window manager with proper permissions
Start() {
    ibus-daemon &

    # Remove bell
    xset b off &

    # Remove screen blanking
    xset -dpms &

    # Scrobble songs on desktop
    killall mpdscribble
    mpdscribble &
    if !  pidof mpd >/dev/null 2>&1; then
        mpd ~/.mpd/mpd.conf &
    fi

    # Enable Ctrl-Alt-Backspace for zapping X
    setxkbmap -option terminate:ctrl_alt_bksp &

    nvidia-settings -l &
    exec ck-launch-session "$@"
}

DE=startkde
if [ -z "$DE" ]; then
    SleepDo 0.75 Autostart &
    Start openbox
else
    Start "$DE"
fi
