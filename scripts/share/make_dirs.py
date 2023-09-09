import os
import shutil


def make_dirs(home_dir: str, dirs_to_create: list[str], dirs_to_reset: list[str] = []):
    """
    Function to create or reset directories in the home directory.

    Params:
        home_dir (str): Home directory path.
        dirs_to_create (list[str]): List of directories to create.
        dirs_to_reset (list[str], optional): List of directories to reset.

    """
    # Remove directories to reset.
    for dir_to_reset in dirs_to_reset:
        full_path = os.path.join(home_dir, dir_to_reset)
        if os.path.exists(full_path):
            shutil.rmtree(full_path)

    # Create directories.
    for dir_to_create in dirs_to_create + dirs_to_reset:
        os.makedirs(os.path.join(home_dir, dir_to_create), exist_ok=True)
