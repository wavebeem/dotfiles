#!/bin/bash
nbg="4b505c"
fbg="9ba0ac"

for img in *-active.xpm; do
    sed -i 's/=\tc #....../=\tc #'"${fbg}/" "$img"
done

for img in *-inactive.xpm; do
    sed -i 's/=\tc #....../=\tc #'"${nbg}/" "$img"
done
