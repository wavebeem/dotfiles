#!/bin/bash
for active in *-active.*; do
    inactive=${active/active/inactive}

    rm "$inactive"
    ln -s "$active" "$inactive"
done
