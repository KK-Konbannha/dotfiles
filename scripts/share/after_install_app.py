import os
import subprocess
from shutil import which


def after_install_app(home_dir: str):
    # Create symbolic link to nvim.
    print("Create symbolic link to nvim.")
    subprocess.run(["sudo", "ln", "-sf", str(which("nvim")), "/usr/bin/vim"])

    # Change login shell to zsh.
    print("Change login shell to zsh.")
    if os.getenv("SHELL") != "/bin/zsh":
        subprocess.run(["chsh", "-s", "/bin/zsh"])

    # Clone ranger_devicons.
    print("Clone ranger_devicons.")
    subprocess.run(
        [
            "git",
            "clone",
            "https://github.com/alexanderjeurissen/ranger_devicons",
            f"{home_dir}/.config/ranger/plugins/ranger_devicons",
        ]
    )
