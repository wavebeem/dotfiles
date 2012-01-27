for icon in close-*.xpm maximize-*.xpm shade-*.xpm stick-*.xpm hide-*.xpm; do
    rm "$icon"
    ln -s "empty.xpm" "$icon"
done
