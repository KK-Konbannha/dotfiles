import subprocess
import os


def install_yay(home_dir: str):
    """
    Function to install yay.

    Params:
        home_dir (str): The home directory of the user.
    """
    print("Install yay.")
    original_directory = os.getcwd()
    os.chdir(home_dir)
    commands = ["git clone https://aur.archlinux.org/yay.git", "cd yay", "makepkg -si"]

    for command in commands:
        subprocess.run(command, shell=True)

    os.chdir(original_directory)
