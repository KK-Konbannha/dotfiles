#!/bin/python
import os
import argparse

from scripts.share.symlink import symlink_dotfiles
from scripts.share.clone_dotfiles import clone_dotfiles
from scripts.share.make_dirs import make_dirs
from scripts.share.check_env import check_env
from scripts.arch.before_install_app import before_install_app
from scripts.arch.install_yay import install_yay
from scripts.arch.install_apps_by_yay import install_apps_by_yay
from scripts.arch.after_install_app import after_install_app

## from scripts.init import init


def main():
    home_dir = os.path.expanduser("~")

    dotfiles_dir = f"{home_dir}/dotfiles"
    remote_url = "https://github.com/KK-Konbannha/dotfiles.git"

    dirs_to_create = [
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
            print("dotfilesの展開に失敗しました。\nディレクトリ構成を確認してください。")

        return

    elif args.init:
        # dotfilesが存在するかを確認し、存在しなければcloneします。
        if not (os.path.exists(dotfiles_dir) and os.path.isdir(dotfiles_dir)):
            if not clone_dotfiles(home_dir, dotfiles_dir, remote_url):
                print("dotfilesのイニシャライズに失敗しました。")
                return

        # dirs_to_create及びdirs_to_resetに存在するディレクトリを作成します。
        print("ディレクトリを作成します。")
        make_dirs(home_dir, dirs_to_create, dirs_to_reset)

        DIST, IS_GUI, IS_WSL = check_env()

        match DIST:
            case "A":
                # init_for_arch()
                before_install_app()
                install_yay()
                install_apps_by_yay(dotfiles_dir, IS_GUI, IS_WSL)
                after_install_app()
            case "U":
                # init_for_ubuntu()
                pass


if __name__ == "__main__":
    main()
