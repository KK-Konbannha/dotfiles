import os
import subprocess


def exec_sh(sh):
    HOME = os.path.expanduser("~")
    SETUP_SHELL_SCRIPTS_DIR = f"{HOME}/dotfiles/setup/arch"
    subprocess.run([f"{SETUP_SHELL_SCRIPTS_DIR}/{sh}"])
