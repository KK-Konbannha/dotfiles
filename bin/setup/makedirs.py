from typing import Final
import os
import shutil


def makedirs(dirs_should_make: list[str], dirs_should_reset: list[str] = []):
    """
    ディレクトリをホームディレクトリの下に作るだけ。

    dir_should_make: 作りたいディレクトリのリスト。
    dirs_should_reset: リセットし(消してもう一度作り)たいディレクトリのリスト。
    """
    HOME_DIR: Final[str] = os.path.expanduser("~")

    for dir_should_reset in dirs_should_reset:
        shutil.rmtree(os.path.join(HOME_DIR, dir_should_reset))

    for dir_should_make in dirs_should_make + dirs_should_reset:
        os.makedirs(os.path.join(HOME_DIR, dir_should_make))
