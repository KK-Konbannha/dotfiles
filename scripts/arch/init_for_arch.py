## import os
## import subprocess
## from shutil import which
##
## from setup.scripts.arch.exec_sh import exec_sh
## from setup.scripts.make_dirs import makedirs
## from setup.scripts.install_apps import install_apps
## from setup.scripts.sym_link import symlink_dotfiles
##
## dirs_should_make = [".config", "dev", "Wallpapers", "Downloads"]
## dirs_should_reset = ["tmp", ".Trash"]
##
##
## def init_for_arch(HOME, DIST):
##
##     # locale設定
##     exec_sh("set-locale.sh")
##
##     # vimのアンインストール
##     if which("vim") and (not which("nvim")):
##         subprocess.run(["sudo", "pacman", "-R", "vim"])
##
##     # paruのインストール
##     if not which("paru"):
##         exec_sh("install-paru.sh")
##         os.chdir(HOME)
##
##     makedirs(
##         dirs_should_make=dirs_should_make, dirs_should_reset=dirs_should_reset
##     )
##
##     install_apps(DIST)
##     symlink_dotfiles([".git", ".gitigonre"], ["bin"])
##
##     # nvmにリンクを貼る
##     subprocess.run(["sudo", "ln", "-sf", which("nvim"), "/usr/bin/vim"])  # type: ignore
##
##     # シェルをzshにする
##     if os.getenv("SHELL") != "/bin/zsh":
##         subprocess.run(["chsh", "-s", "/bin/zsh"])
##
##     # ranger plugins
##     exec_sh("install-ranger-plugin.sh")
##     os.chdir(HOME)
##
##     # font instalation
##     print("You have to install fonts!")
##
import os
import subprocess
from shutil import which


# シェルスクリプトを実行する関数
def execute_shell_script(script_name):
    subprocess.run(["bash", script_name])


# 新しいディレクトリを作成する関数
def create_directories(directories_to_make, directories_to_reset):
    for directory in directories_to_make:
        os.makedirs(directory, exist_ok=True)
    for directory in directories_to_reset:
        os.makedirs(directory, exist_ok=True)


# ディストリビューションに応じたアプリケーションをインストールする関数
def install_applications(distribution):
    # ここにディストリビューション別のアプリケーションのインストール処理を記述する
    pass


# シンボリックリンクを作成する関数
def create_symlinks(files_to_link, directories_to_link):
    for file in files_to_link:
        os.symlink(file, os.path.join(os.path.expanduser("~"), file))
    for directory in directories_to_link:
        os.symlink(directory, os.path.join(os.path.expanduser("~"), directory))


def main():
    home_directory = os.path.expanduser("~")
    distribution = "Arch"  # ここに実際のディストリビューション名を指定する

    # locale設定の実行
    execute_shell_script("set-locale.sh")

    # vimのアンインストール
    if which("vim") and (not which("nvim")):
        subprocess.run(["sudo", "pacman", "-R", "vim"])

    # paruのインストール
    if not which("paru"):
        execute_shell_script("install-paru.sh")

    create_directories(
        dirs_should_make=[".config", "dev", "Wallpapers", "Downloads"],
        dirs_should_reset=["tmp", ".Trash"],
    )

    install_applications(distribution)

    create_symlinks(files_to_link=[".git", ".gitigonre"], directories_to_link=["bin"])

    # nvmにリンクを貼る
    subprocess.run(["sudo", "ln", "-sf", which("nvim"), "/usr/bin/vim"])  # type: ignore

    # シェルをzshにする
    if os.getenv("SHELL") != "/bin/zsh":
        subprocess.run(["chsh", "-s", "/bin/zsh"])

    # ranger pluginsのインストール
    execute_shell_script("install-ranger-plugin.sh")

    # fontのインストール
    print("You have to install fonts!")


if __name__ == "__main__":
    main()
