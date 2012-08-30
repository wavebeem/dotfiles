#!/bin/bash
# main backgrounds
nbg="4b505c"
fbg="fef9f5"

# inner borders
nib="bbc0cc"
fib="bbc0cc"

for img in *-active.xpm; do
    sed -i 's/=\tc #....../=\tc #'"${fbg}/" "$img"
    sed -i 's/-\tc #....../-\tc #'"${fib}/" "$img"
done

for img in *-inactive.xpm; do
    sed -i 's/=\tc #....../=\tc #'"${nbg}/" "$img"
    sed -i 's/-\tc #....../-\tc #'"${nib}/" "$img"
done
