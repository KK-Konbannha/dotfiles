import subprocess
import os


def install_yay():
    """
    yayをインストールする。
    """
    print("yayをインストールします。")
    original_directory = os.getcwd()
    os.chdir("/tmp")
    commands = ["git clone https://aur.archlinux.org/yay.git", "cd yay", "makepkg -si"]

    for command in commands:
        subprocess.run(command, shell=True)

    os.chdir(original_directory)
