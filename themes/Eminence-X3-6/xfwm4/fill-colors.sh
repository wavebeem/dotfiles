#!/bin/bash
nbg="5b606c"
fbg="8b909c"

for img in *-active.xpm; do
    sed -i 's/=\tc #....../=\tc #'"${fbg}/" "$img"
done

for img in *-inactive.xpm; do
    sed -i 's/=\tc #....../=\tc #'"${nbg}/" "$img"
done
