import os
import subprocess
import requests
import zipfile
import re
from shutil import which


def clone_dotfiles(home_dir: str, dotfiles_dir: str, remote_url: str) -> bool:
    """
    リモートリポジトリからdotfilesをインストールする。

    Parameters:
        home_dir (str): ホームディレクトリパス。
        dotfiles_dir (str): インストール先のディレクトリパス。
        remote_url (str): リモートリポジトリのURL。

    Returns:
        bool: インストールが成功した場合はTrue、失敗した場合はFalse。
    """
    # インストール先のディレクトリが既に存在する場合の処理
    if os.path.exists(dotfiles_dir):
        while True:
            other_place: str = input(
                "dotfilesは既に存在します。他の場所にdotfilesをcloneしますか？ [Y/n] "
            ).lower()

            match other_place:
                case "y" | "yes":
                    other_dir: str = os.path.expanduser(
                        input("homeからの相対パスでディレクトリを教えてください: (e.g., ~/your): ")
                    )
                    if os.path.exists(other_dir) and os.path.isdir(other_dir):
                        return clone_dotfiles(
                            other_dir, f"{other_dir}/dotfiles", remote_url
                        )

                    else:
                        print("そのようなディレクトリは存在しません。")
                        return False

                case "n" | "no":
                    print("dotfilesのインストールを中止します。")
                    return False

                case _:
                    pass

    # gitコマンドが使える場合はgit cloneを実行
    if which("git"):
        subprocess.run(["git", "clone", remote_url, dotfiles_dir])
        return True

    # gitコマンドが使えない場合はリモートからzipファイルをダウンロード
    remote_zip_url = re.sub(r"\.git$", "/archive/refs/heads/main.zip", remote_url)
    res = requests.get(remote_zip_url)
    zip_file_path = dotfiles_dir + ".zip"

    with open(zip_file_path, "wb") as f:
        f.write(res.content)

    with zipfile.ZipFile(zip_file_path, "r") as zip_ref:
        zip_ref.extractall(home_dir)

    os.rename(
        os.path.join(home_dir, "dotfiles-main"),
        os.path.join(home_dir, "dotfiles"),
    )
    os.remove(zip_file_path)

    return True


if __name__ == "__main__":
    home_dir = os.path.expanduser("~")
    remote_url: str = input("Remote urlを入力してください: ")
    clone_dotfiles(home_dir, f"{home_dir}/dotfiles", remote_url)
