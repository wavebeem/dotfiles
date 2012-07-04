#for i in 2 3 4 5; do
#    ln -s "title-1-active.xpm" "title-$i-active.xpm"
#    ln -s "title-1-active.xpm" "title-$i-inactive.xpm"
#done

ln -s "title-1-active.png" "title-1-inactive.png"
for i in 2 3 4 5; do
    ln -s "title-1-active.png" "title-$i-active.png"
    ln -s "title-1-active.png" "title-$i-inactive.png"
done
