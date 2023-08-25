import os
import subprocess
import sys


def symlink_dotfiles(
    home_dir: str,
    dotfiles_dir: str,
    dirs_to_exclude: list[str],
    dirs_to_include: list[str] = [],
) -> bool:
    """
    ドットファイルのシンボリックリンクを作成する。

    Parameters:
        home_dir (str): ホームディレクトリのパス。
        dotfiles_dir (str): dotfilesのパス。
        dirs_to_exclude (list[str]): 除外するディレクトリのリスト。
        dirs_to_include (list[str], optional): ドットファイルではないがリンクを作成するディレクトリのリスト。

    Returns:
        bool: 成功した場合はTrueを、dotfilesまたは.configディレクトリが存在しない、またはlnのstdoutにfailedが含まれる場合はFalseを返す。
    """
    config_dir_path = os.path.join(dotfiles_dir, ".config")

    # dotfilesディレクトリが存在しない場合は処理を終了
    if not os.path.exists(dotfiles_dir):
        return False
    # .configディレクトリが存在しない場合は処理を終了
    if not os.path.exists(config_dir_path):
        return False

    # dotfilesディレクトリ内のファイルとディレクトリを取得
    dotfiles = tuple(file for file in os.listdir(dotfiles_dir) if file[0] == ".")

    # 除外ディレクトリを除いたdotfilesと、dirs_to_includeを合成して対象とするファイルのリストを作成
    remaining_dotfiles = tuple(
        dotfile for dotfile in dotfiles if dotfile not in dirs_to_exclude
    )
    target_files = remaining_dotfiles + tuple(dirs_to_include)

    for target_file in target_files:
        is_config = ".config" == target_file

        if is_config:
            # .configディレクトリは中に複数のディレクトリがあるため、それらをリンクする
            for config_dir in os.listdir(config_dir_path):
                org_config_path = os.path.join(dotfiles_dir, target_file, config_dir)
                symlink_config_path = os.path.join(home_dir, target_file, config_dir)
                res = subprocess.run(
                    ["ln", "-snfv", org_config_path, symlink_config_path],
                    stdout=subprocess.PIPE,
                )
                if b"failed" in res.stdout:
                    return False
                print(b"/home" in res.stdout)
                print(b"failed" in res.stdout)
                sys.stdout.buffer.write(res.stdout)
                if b"failed" in res.stdout:
                    return False
        else:
            # 通常のファイルをリンクする
            org_path = os.path.join(dotfiles_dir, target_file)
            symlink_path = os.path.join(home_dir, target_file)
            res = subprocess.run(
                ["ln", "-snfv", org_path, symlink_path], stdout=subprocess.PIPE
            )
            sys.stdout.buffer.write(res.stdout)
            if b"failed" in res.stdout:
                return False

    return True


if __name__ == "__main__":
    home_dir = os.path.expanduser("~")
    symlink_dotfiles(home_dir, f"{home_dir}/dotfiles", [".git", ".gitignore"])
