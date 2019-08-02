#!/usr/bin/env bash
set -eu

convert a.png b.png a.png b.png +append 0001.png
convert b.png a.png b.png a.png +append 0002.png
