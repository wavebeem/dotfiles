#!/usr/bin/env bash

# Make "dark mode" only apply to the dock and menubar
# defaults write -g NSRequiresAquaSystemAppearance -bool YES
###
### This has a bug with the notification center, so disable for now
###
defaults delete -g NSRequiresAquaSystemAppearance &>/dev/null

# Enable subpixel antialiasing
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
