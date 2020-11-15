#!/usr/bin/env python3
import os
import re
import shutil
import sys
import time
from pathlib import Path

path_src = Path("/mnt/e/backup")
path_dst = Path("/mnt/e/backup/suffix-1")

prefix = "(?:B612_|PANO_|IMG_|MVIMG_|PXL_|VID_|Screenshot_|Screen Shot )"
date = "(20\d\d)-?(\d\d)-?\d\d"
suffix = "*"
re_file = re.compile(prefix + date + suffix)


def main():
    os.chdir(str(path_src))
    for path_file in Path().glob("20*-*/*(1)*"):
        path_file1 = Path(str(path_file).replace("(1)", ""))
        try:
            size = path_file.stat().st_size
            size1 = path_file1.stat().st_size
            if size == size1:
                dest = "dupe"
            else:
                dest = "unsure"
        except FileNotFoundError:
            dest = "broken"
        print(dest, "<==", path_file)
        shutil.move(str(path_file), str(Path(path_dst, dest)))


try:
    start = time.perf_counter()
    main()
    end = time.perf_counter()
    print(f"{end - start:.4f} seconds")
except KeyboardInterrupt:
    pass
