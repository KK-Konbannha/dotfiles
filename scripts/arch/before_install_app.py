import subprocess
from shutil import which


def run_command_with_sudo(command):
    subprocess.run(["sudo", "sh", "-c", command])


def before_install_app():
    # vimのアンインストール
    if which("vim") and (not which("nvim")):
        run_command_with_sudo("pacman -R vim")

    # en_US.UTF-8のコメントを解除
    run_command_with_sudo("sed -i -e 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen")
    run_command_with_sudo("locale-gen")

    # ja_JP.UTF-8のコメントを解除
    run_command_with_sudo("sed -i -e 's/#ja_JP.UTF-8/ja_JP.UTF-8/' /etc/locale.gen")
    run_command_with_sudo("locale-gen")
