#!/usr/bin/env python3
import json
import os
import contextlib
import shutil
import datetime
from pathlib import Path
from zipfile import ZipFile


path_takeout = Path("/mnt/e/Dropbox/Apps/Google Download Your Data")
path_done = Path("/mnt/e/done")
path_tmp = Path("/mnt/e/tmp")
path_backup = Path("/mnt/e/backup")


@contextlib.contextmanager
def changed_dir(path):
  cwd = os.getcwd()
  try:
    os.chdir(path)
    yield
  finally:
    os.chdir(cwd)


def all_photos_and_videos(path):
  path = Path(path)
  yield from path.glob("**/*.jpeg")
  yield from path.glob("**/*.jpg")
  yield from path.glob("**/*.png")
  yield from path.glob("**/*.gif")
  yield from path.glob("**/*.mp4")


def main():
  path_tmp.mkdir(parents=True, exist_ok=True)
  path_done.mkdir(parents=True, exist_ok=True)
  path_backup.mkdir(parents=True, exist_ok=True)
  with changed_dir(path_takeout):
    for zip_filename in Path(".").glob("*.zip"):
      process_zip(zip_filename)
      return # TODO: Just start with one zip


def folder_name_for_file(file):
  try:
    with open(f"{file}.json") as json_file:
      data = json.load(json_file)
      timestamp = int(data["photoTakenTime"]["timestamp"])
      return datetime.date.fromtimestamp(timestamp).strftime("%Y-%m")
  except IOError:
    return "misc"


def new_filename(file):
  prefix = datetime.datetime.now().strftime("%Y-%m-%d_%H.%M")
  return prefix + Path(file).suffix



def process_zip(zip_filename):
  with ZipFile(zip_filename) as zip:
    shutil.rmtree(path_tmp, ignore_errors=True)
    print()
    print("==> Extracting", zip_filename)
    zip.extractall(path=path_tmp)
    with changed_dir(path_tmp):
      for path_file in all_photos_and_videos_paths(Path(".")):
        dest = folder_name_for_file(path_file)
        output = Path(path_backup, dest)
        output.mkdir(parents=True, exist_ok=True)
        print("Moving", path_file.name)
        try:
          shutil.move(str(path_file), str(output))
        except shutil.Error:
          shutil.move(str(path_file), str(output / new_filename(path_file)))
    print("Moving the .zip")
    shutil.move(str(zip_filename), str(path_done))


try:
  main()
except KeyboardInterrupt:
  pass
