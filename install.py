#!/bin/python
import os
import argparse
from typing import Final

from setup.scripts.symlink import symlink_dotfiles
from setup.scripts.init import init


def main():
    HOME: Final[str] = os.path.expanduser("~")

    DOT_DIRECTORY: Final[str] = f"{HOME}/dotfiles"
    REMOTE_URL: Final[str] = "https://github.com/KK-Konbannha/dotfiles.git"

    DIRS_SHOULD_MAKE: Final[list[str]] = [
        ".config",
        "dev",
        "Wallpapers",
        "Downloads",
    ]
    DIRS_SHOULD_RESET: Final[list[str]] = [".Trash", "tmp"]

    DIRS_SHOULD_EXLCUDE: Final[list[str]] = [".git", ".gitignore"]
    DIRS_SHOULDNT_EXCLUDE: Final[list[str]] = ["bin"]

    parser = argparse.ArgumentParser(description="setup my dotfiles")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument(
        "-d", "--deploy", help="deploy my dotfiles", action="store_true"
    )
    group.add_argument(
        "-i",
        "--init",
        help="install packages and deploy my dotfiles",
        action="store_true",
    )
    args = parser.parse_args()

    if args.deploy:
        symlink_dotfiles(DIRS_SHOULD_EXLCUDE, DIRS_SHOULDNT_EXCLUDE)
    elif args.init:
        init(HOME)
    else:
        pass


if __name__ == "__main__":
    main()
