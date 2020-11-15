#!/usr/bin/env python3
import os
import re
import shutil
import sys
import time
from pathlib import Path

path_src = Path("/mnt/e/backup/misc")
path_dst = Path("/mnt/e/backup")

prefix = "(?:B612_|PANO_|IMG_|MVIMG_|PXL_|VID_|Screenshot_|Screen Shot )"
date = "(20\d\d)-?(\d\d)-?\d\d"
suffix = "*"
re_file = re.compile(prefix + date + suffix)


def main():
    os.chdir(str(path_src))
    for path_file in Path().iterdir():
        match = re_file.match(path_file.name)
        if match:
            year = match[1]
            month = match[2]
            path_dest = Path(path_dst, f"{year}-{month}")
            try:
                if not Path(path_dest, path_file.name).exists():
                    print(f"{path_dest} <== {path_file}")
                    shutil.move(str(path_file), str(path_dest))
                else:
                    shutil.move(str(path_file), "../dupe")
            except shutil.Error as err:
                print(err, file=sys.stderr)


try:
    start = time.perf_counter()
    main()
    end = time.perf_counter()
    print(f"{end - start:.4f} seconds")
except KeyboardInterrupt:
    pass
