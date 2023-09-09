import subprocess
from shutil import which


def run_command_with_sudo(command):
    subprocess.run(["sudo", "sh", "-c", command])


def before_install_app():
    if which("vim") and (not which("nvim")):
        run_command_with_sudo("pacman -R vim")
