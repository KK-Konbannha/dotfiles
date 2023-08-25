import os
import subprocess
from shutil import which


def after_install_app():
    # nvimにリンクを貼る
    print("nvimにリンクを貼ります。")
    subprocess.run(["sudo", "ln", "-sf", str(which("nvim")), "/usr/bin/vim"])

    # シェルをzshにする
    print("シェルをzshにします。")
    if os.getenv("SHELL") != "/bin/zsh":
        subprocess.run(["chsh", "-s", "/bin/zsh"])

    # ranger_devicons のクローン
    print("ranger_deviconsをクローンします。")
    subprocess.run(
        [
            "git",
            "clone",
            "https://github.com/alexanderjeurissen/ranger_devicons",
            "~/.config/ranger/plugins/ranger_devicons",
        ]
    )
