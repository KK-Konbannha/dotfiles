from shutil import which

from setup.scripts.check_env import check_env
from setup.scripts.wsl import setup_wsl
from setup.scripts.arch.init_for_arch import init_for_arch


def init(HOME):
    if not which("sudo"):
        print("sudo is required")
        return

    print(check_env)

    IS_WSL, DIST = check_env()

    if IS_WSL:
        setup_wsl(DIST)

    match DIST:
        case "A":
            init_for_arch(HOME, DIST)
        case "U":
            # init_for_ubuntu()
            pass
