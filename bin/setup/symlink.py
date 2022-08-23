from typing import Final
import os


def symlink_dotfiles(
    dirs_should_exclude: list[str], dirs_shouldnt_exclude: list[str] = []
) -> int:
    """
    dotfilesのファイルのシンボリックリンクを貼る。

    dirs_should_exclude: 除外したいディレクトリのリスト。
    dirs_shouldnt_exclude: dotfileじゃないけどリンクを作りたいディレクトリのリスト。
    """
    HOME_DIR: Final[str] = os.path.expanduser("~")
    DOTFILES_DIR: Final[str] = os.path.expanduser("~/dotfiles")
    if not os.path.exists(DOTFILES_DIR):
        return 0

    DOTFILES: Final[tuple] = tuple(
        file for file in os.listdir(DOTFILES_DIR) if file[0] == "."
    )
    REMAINING_DOTFILES: Final[tuple] = tuple(
        dotfile for dotfile in DOTFILES if dotfile not in dirs_should_exclude
    )
    TARGET_FILES: Final[tuple] = REMAINING_DOTFILES + tuple(
        dirs_shouldnt_exclude
    )

    for target_file in TARGET_FILES:
        IS_CONFIG: Final[bool] = ".config" == target_file

        if IS_CONFIG:
            for config_dirs in os.listdir(
                os.path.join(DOTFILES_DIR, target_file)
            ):
                ORG_CONFIG_PATH: Final[str] = os.path.join(
                    DOTFILES_DIR, target_file, config_dirs
                )
                SYMLINK_CONFIG_PATH: Final[str] = os.path.join(
                    HOME_DIR, target_file, config_dirs
                )
                os.system(f"ln -snfv {ORG_CONFIG_PATH} {SYMLINK_CONFIG_PATH}")
        else:
            ORG_PATH: Final[str] = os.path.join(DOTFILES_DIR, target_file)
            SYMLINK_PATH: Final[str] = os.path.join(HOME_DIR, target_file)
            os.system(f"ln -snfv {ORG_PATH} {SYMLINK_PATH}")

    return 1
