rm "title-1-inactive.xpm"
ln -s "title-1-active.xpm" "title-1-inactive.xpm"
for i in 2 3 4 5; do
    rm "title-$i-active.xpm"
    rm "title-$i-inactive.xpm"

    ln -s "title-1-active.xpm" "title-$i-active.xpm"
    ln -s "title-1-active.xpm" "title-$i-inactive.xpm"
done
