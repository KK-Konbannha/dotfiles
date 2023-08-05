#!/bin/python
import os
import argparse

from scripts.symlink import symlink_dotfiles

## from scripts.init import init


def main():
    home_dir = os.path.expanduser("~")

    dotfiles_dir = f"{home_dir}/dotfiles"
    remote_url = "https://github.com/KK-Konbannha/dotfiles.git"

    dirs_to_make = [
        ".config",
        ".lyrics",
        "dev",
        "Wallpapers",
        "Downloads",
        "Music",
    ]
    dirs_to_reset = [".Trash", "tmp"]

    dirs_to_exclude = [".git", ".gitignore"]
    dirs_to_include = ["bin"]

    parser = argparse.ArgumentParser(description="setup my dotfiles")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("-d", "--deploy", help="deploy my dotfiles", action="store_true")
    group.add_argument(
        "-i",
        "--init",
        help="install packages and deploy my dotfiles",
        action="store_true",
    )
    args = parser.parse_args()

    if args.deploy:
        res = symlink_dotfiles(home_dir, dotfiles_dir, dirs_to_exclude, dirs_to_include)
        if res:
            print("dotfilesを正常に展開しました。")
        else:
            print("dotfilesの展開に失敗しました。")
    elif args.init:
        ## init(home_dir)
        if not (os.path.exists(dotfiles_dir) and os.path.isdir(dotfiles_dir)):
            pass


if __name__ == "__main__":
    main()
