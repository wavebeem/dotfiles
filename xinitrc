# vim: syn=sh:

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
    nitrogen --restore &
    xscreensaver -no-splash &
    wmname LG3D &

    # Seems to not mess up when using -noevents
    unclutter -noevents &
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
    xsetroot -solid black &
    xsetroot -cursor_name left_ptr &

    # Enable Ctrl-Alt-Backspace for zapping X
    setxkbmap -option terminate:ctrl_alt_bksp &

    # Load keybindings
    xbindkeys &

    # Load graphics settings
    nvidia-settings -l &

    # Preload thunar for very slight speed increases
    thunar --daemon &

    # Pretty window fading
    #dcompmgr &

    # Put proper text into the wmfs bars
    wmfs-bars.sh &
}

SleepDo 2 Autostart &
SleepDo 2 Basics &

# Launch a window manager with proper permissions
Start() {
    exec ck-launch-session "$@"
}

# Start i3
# Start dwm
  Start wmii
# Start wmfs
# Start xfwm4
# Start xmonad
# Start startkde
# Start startxfce4
# Start ~/wmfs/wmfs
# Start ~/xorg62/wmfs
# Start gnome-session
# Start openbox-session
