# vim: set syn=sh:

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
}

Basics() {
    ibus-daemon &

    # Enable compose key
    setxkbmap us \
        -variant altgr-intl \
        -option  nodeadkeys  \
        -option  compose:ralt \
        -option  compose:caps  &

    # Load font and cursor settings
    xrdb ~/.Xdefaults &

    # Remove bell
    xset -b &

    # Remove screen blanking
    xset -dpms &

    # Set cursor type on root window (avoid X-shape)
    xsetroot -cursor_name left_ptr &

    # Enable Ctrl-Alt-Backspace for zapping X
    setxkbmap -option terminate:ctrl_alt_bksp &

    # Load keybindings
    xbindkeys &

    [ "$HOST" = "profiterole" ] && tint2 &
}

SleepDo 2 Autostart &
SleepDo 3 Basics &

# Launch a window manager with proper permissions
Start() {
    [ "$HOST" = "truffle" ] && ~/.screenlayout/dual.sh
    exec ck-launch-session "$@"
}

WM=${WM:-$default_wm}
Start "$WM"
