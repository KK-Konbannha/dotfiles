from shutil import which

from checkenv import checkenv
from arch.init_for_arch import init_for_arch
from wsl import setup_wsl


def init(HOME):
    if which("sudo"):
        print("sudo is required")
        return

    IS_WSL, DIST = checkenv()

    if IS_WSL:
        setup_wsl(DIST)

    if DIST == "A":
        init_for_arch(HOME, DIST)
