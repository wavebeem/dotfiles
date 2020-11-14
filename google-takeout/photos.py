#!/usr/bin/env python3
import json
import os
from datetime import date
from pathlib import Path
from shutil import copy2


takeout_dir = Path("/mnt/e/Dropbox/Apps/Google Download Your Data")
backup_dir = Path("/mnt/e/backup")


def all_photos():
  here = Path(".")
  yield from here.glob("**/*.jpeg")
  yield from here.glob("**/*.png")
  yield from here.glob("**/*.gif")
  yield from here.glob("**/*.mp4")


os.chdir(takeout_dir)
dir = list(Path(".").glob("takeout-*/Takeout/Google Photos"))
if dir:
  os.chdir(dir[0])
else:
  raise Exception("where is google takeout?")

for file in all_photos():
  try:
    with open(f"{file}.json") as f:
      data = json.load(f)
      timestamp = int(data["photoTakenTime"]["timestamp"])
      taken_date = date.fromtimestamp(timestamp)
      dest = f"{taken_date.year:04d}-{taken_date.month:02d}"
  except IOError:
    dest = "misc"
  output = Path(backup_dir, dest)
  output.mkdir(parents=True, exist_ok=True)
  print(Path(file).name, end="", flush=True)
  copy2(file, output)
  print()

