from shutil import which

from setup.scripts.checkenv import checkenv
from setup.scripts.arch.init_for_arch import init_for_arch
from setup.scripts.wsl import setup_wsl


def init(HOME):
    if not which("sudo"):
        print("sudo is required")
        return

    print(checkenv)

    # IS_WSL, DIST = checkenv()

    # if IS_WSL:
    #     setup_wsl(DIST)

    # if DIST == "A":
    #     init_for_arch(HOME, DIST)
