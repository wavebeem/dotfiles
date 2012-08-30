#!/bin/bash
# main backgrounds
nbg="111111"
fbg="333333"

# inner borders (1st)
nib="555555"
fib="555555"

# inner borders (2nd)
nii="000000"
fii="000000"

for img in *-active.xpm; do
    sed -i 's/=\tc #....../=\tc #'"${fbg}/" "$img"
    sed -i 's/-\tc #....../-\tc #'"${fib}/" "$img"
    sed -i 's/+\tc #....../+\tc #'"${fii}/" "$img"
done

for img in *-inactive.xpm; do
    sed -i 's/=\tc #....../=\tc #'"${nbg}/" "$img"
    sed -i 's/-\tc #....../-\tc #'"${nib}/" "$img"
    sed -i 's/+\tc #....../+\tc #'"${nii}/" "$img"
done
