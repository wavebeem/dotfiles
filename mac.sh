#!/usr/bin/env bash

# Make "dark mode" only apply to the dock and menubar
defaults write -g NSRequiresAquaSystemAppearance -bool YES

# Enable subpixel antialiasing
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
