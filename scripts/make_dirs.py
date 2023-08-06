import os
import shutil


def make_dirs(home_dir: str, dirs_to_create: list[str], dirs_to_reset: list[str] = []):
    """
    ホームディレクトリ内にディレクトリを作成またはリセットする。

    Parameters:
        home_dir (str): ホームディレクトリのパス。
        dirs_to_create (list[str]): 作成したいディレクトリのリスト。
        dirs_to_reset (list[str], optional): リセットしたいディレクトリのリスト。

    Notes:
        dirs_to_createとdirs_to_resetに含まれるディレクトリは全てhome_dir内に作成される。
        dirs_to_resetに含まれるディレクトリは既に存在している場合、削除され再作成される。
    """
    # リセットしたいディレクトリを削除
    for dir_to_reset in dirs_to_reset:
        shutil.rmtree(os.path.join(home_dir, dir_to_reset))

    # ディレクトリを作成
    for dir_to_create in dirs_to_create + dirs_to_reset:
        os.makedirs(os.path.join(home_dir, dir_to_create), exist_ok=True)
