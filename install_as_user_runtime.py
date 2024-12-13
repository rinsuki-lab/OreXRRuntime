#!/usr/bin/python3
#
#  install_as_user_runtime.py
#  OreXRRuntime
#
#  Created by user on 2024/12/13.
#

import json
import os

OPENXR_USER_DIR = "/usr/local/share/openxr/1"
os.makedirs(OPENXR_USER_DIR, exist_ok=True)

with open(OPENXR_USER_DIR + "/runtime_orexr.json", "w") as f:
    json.dump({
        "file_format_version": "1.0.0",
        "runtime": {
            "name": "orexr_runtime",
            "library_path": os.environ["CODESIGNING_FOLDER_PATH"],
            "functions": {
                "xrNegotiateLoaderRuntimeInterface": "orexrNegotiateLoaderRuntimeInterface",
            }
        }
    }, f)

os.remove(OPENXR_USER_DIR + "/active_runtime.json")
os.symlink(OPENXR_USER_DIR + "/runtime_orexr.json", OPENXR_USER_DIR + "/active_runtime.json")
