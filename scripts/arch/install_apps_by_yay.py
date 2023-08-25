import os
import subprocess


def install_packages_from_file(file_path: str, IS_BREAK: bool = False):
    """
    指定されたファイルパスからパッケージリストを読み取り、yayを用いてインストールする。

    Parameters:
        file_path (str): パッケージリストのファイルパス。
        IS_BREAK (bool): 空行があった場合にループを抜けるか否か。
    """
    with open(file_path, "r") as f:
        packages = f.readlines()

    for package in packages:
        package = package.strip()  # 余分なスペースや改行を削除
        if not package:  # 空行の場合
            if IS_BREAK:
                break
            else:
                continue
        cmd = ["yay", "-S", package]
        subprocess.run(cmd)


def install_apps_by_yay(dotfiles_dir: str, IS_GUI: bool, IS_WSL: bool):
    """
    app_list.txtに記載されたアプリケーションをyayを用いてインストールする。

    Parameters:
        dotfiles_dir (str): ドットファイルディレクトリのパス。
        IS_GUI (bool): GUI環境か否か。
        IS_WSL (bool): WSL環境か否か。

    Notes:
        - 各パッケージ名は新しい行に記載されていることを前提としています。
        - yayが既にインストールされていることと、適切な権限でこの関数が実行されていることを前提としています。
    """
    if IS_WSL:
        app_list_path = os.path.join(dotfiles_dir, "app_list", "app_list_cui.txt")
    elif IS_GUI:
        app_list_path = os.path.join(dotfiles_dir, "app_list", "app_list_for_arch.txt")
    else:
        app_list_path = os.path.join(dotfiles_dir, "app_list", "app_list_cui.txt")

    install_packages_from_file(app_list_path, IS_GUI and IS_WSL)


if __name__ == "__main__":
    home_dir = os.path.expanduser("~")
    install_apps_by_yay(f"{home_dir}/dotfiles", False, False)
