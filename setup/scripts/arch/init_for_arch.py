import os
import subprocess
from shutil import which

from exec_sh import exec_sh
from ..makedirs import makedirs
from ..install_apps import install_apps
from ..symlink import symlink_dotfiles

dirs_should_make = [".config", "dev", "Wallpapers", "Downloads"]
dirs_should_reset = ["tmp", ".Trash"]


def init_for_arch(HOME, DIST):

    # locale設定
    exec_sh("set-locale.sh")

    # vimのアンインストール
    if which("vim") and (not which("nvim")):
        subprocess.run(["sudo", "pacman", "-R", "vim"])

    # paruのインストール
    if not which("paru"):
        exec_sh("install-paru.sh")
        os.chdir(HOME)

    makedirs(
        dirs_should_make=dirs_should_make, dirs_should_reset=dirs_should_reset
    )

    install_apps(DIST)
    symlink_dotfiles([".git", ".gitigonre"], ["bin"])

    # nvmにリンクを貼る
    subprocess.run(["sudo", "ln", "-sf", which("nvim"), "/usr/bin/vim"])  # type: ignore

    # シェルをzshにする
    if os.getenv("SHELL") != "/bin/zsh":
        subprocess.run(["chsh", "-s", "/bin/zsh"])

    # ranger plugins
    exec_sh("install-ranger-plugin.sh")
    os.chdir(HOME)

    # font instalation
    print("You have to install fonts!")
