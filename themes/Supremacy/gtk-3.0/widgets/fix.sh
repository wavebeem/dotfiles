#!/bin/bash
exec sed -i \
    -e 's/width:\s\+\([0-9]\+\) \([0-9]\+\) \([0-9]\+\) \([0-9]\+\);/width: \1px \2px \3px \4px;/' \
    -e 's/width:\s\+\([0-9]\+\);/width: \1px;/' \
    -e 's/padding:\s\+\([0-9]\+\) \([0-9]\+\) \([0-9]\+\) \([0-9]\+\);/padding: \1px \2px \3px \4px;/' \
    -e 's/padding:\s\+\([0-9]\+\);/padding: \1px;/' \
    -e 's/margin:\s\+\([0-9]\+\) \([0-9]\+\) \([0-9]\+\) \([0-9]\+\);/margin: \1px \2px \3px \4px;/' \
    -e 's/margin:\s\+\([0-9]\+\);/margin: \1px;/' \
    -e 's/radius:\s\+\([0-9]\+\) \([0-9]\+\) \([0-9]\+\) \([0-9]\+\);/radius: \1px \2px \3px \4px;/' \
    -e 's/radius:\s\+\([0-9]\+\);/radius: \1px;/' \
    -e 's/pxpx/px/' \
    "$@"
