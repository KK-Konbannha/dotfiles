import subprocess
import os


def install_paru(home_dir: str):
    """
    Function to install paru.

    Params:
        home_dir (str): The home directory of the user.
    """
    if os.path.exists(f"{home_dir}/paru"):
        print("paru is already installed.")
        return
    print("Install paru.")
    original_directory = os.getcwd()
    os.chdir(home_dir)
    commands = [
        ["sudo", "pacman", "-S", "--needed", "--noconfirm", "git", "base-devel"],
        ["git", "clone", "https://aur.archlinux.org/paru.git"],
        ["cd", "paru"],
        ["makepkg", "-si"],
    ]

    for command in commands:
        if "cd" in command:
            os.chdir(f"{home_dir}/paru")
            continue
            
        subprocess.run(command)

    os.chdir(original_directory)
