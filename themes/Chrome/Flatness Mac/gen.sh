#!/usr/bin/env bash
set -e

dir="img"

if which gm >/dev/null; then
    _ImgConvert='gm convert'
elif which convert >/dev/null; then
    _ImgConvert='convert'
else
    echo "Please install either ImageMagick or GraphicsMagick" 1>&2
    exit 1
fi

ImgConvert() {
    $_ImgConvert "$@"
}

Build() {
    local color="$1"
    local name="$2"
    ImgConvert "xc:#$color" -resize 1x1 "$dir/$name.png"
}

Build dddddd frame
Build ffffff frame_inactive
Build dddddd tab_background
Build eeeeee toolbar
