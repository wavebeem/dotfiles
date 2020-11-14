#!/usr/bin/env python3
import os
import json
import glob
import datetime

os.chdir("/mnt/e/Dropbox/Apps/Google Download Your Data")
dir = glob.glob("takeout-*/Takeout/Google Photos")
if dir:
  os.chdir(dir)
else:
  raise Exception("no takeout dir")

for file in glob.glob("**/*.{jpg,jpeg,png,mp4,gif}"):
  try:
    with open(file) as f:
      data = json.load(f)
      timestamp = data["photoTakenTime"]["timestamp"]
      dest = datetime.date.fromtimestamp(timestamp).isoformat()
  except IOError:
    dest = "misc"
  mkdir -p "dest/$dest"
  base=$(basename "$file")
  cp -v "$file" "dest/$dest/$base"
done
