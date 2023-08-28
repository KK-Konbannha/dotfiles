import subprocess
import os


def install_paru(home_dir: str):
    """
    Function to install paru.

    Params:
        home_dir (str): The home directory of the user.
    """
    print("Install paru.")
    original_directory = os.getcwd()
    os.chdir(home_dir)
    commands = [
        ["sudo", "pacman", "-S", "--needed", "--noconfirm", "git", "base-devel"],
        ["git", "clone", "https://aur.archlinux.org/paru.gi"],
        ["cd", "paru"],
        ["makepkg", "-si"],
    ]

    for command in commands:
        subprocess.run(command)

    os.chdir(original_directory)
