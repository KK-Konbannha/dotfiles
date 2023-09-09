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
    Function to create symbolic links to dotfiles.

    Params:
        home_dir (str): Home directory path.
        dotfiles_dir (str): Path to dotfiles.
        dirs_to_exclude (list[str]): List of directories to exclude.
        dirs_to_include (list[str], optional): List of directories to create symbolic links.


    Returns:
        bool: Whether the installation was successful or not.
    """
    config_dir_path = os.path.join(dotfiles_dir, ".config")

    if not os.path.exists(dotfiles_dir):
        return False
    if not os.path.exists(config_dir_path):
        return False

    dotfiles = tuple(file for file in os.listdir(dotfiles_dir) if file[0] == ".")

    remaining_dotfiles = tuple(
        dotfile for dotfile in dotfiles if dotfile not in dirs_to_exclude
    )
    target_files = remaining_dotfiles + tuple(dirs_to_include)

    for target_file in target_files:
        is_config = ".config" == target_file

        if is_config:
            for config_dir in os.listdir(config_dir_path):
                org_config_path = os.path.join(dotfiles_dir, target_file, config_dir)
                symlink_config_path = os.path.join(home_dir, target_file, config_dir)
                res = subprocess.run(
                    ["ln", "-snfv", org_config_path, symlink_config_path],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                )
                if b"failed" in res.stderr:
                    return False
                sys.stdout.buffer.write(res.stdout or res.stderr)
        else:
            org_path = os.path.join(dotfiles_dir, target_file)
            symlink_path = os.path.join(home_dir, target_file)
            res = subprocess.run(
                ["ln", "-snfv", org_path, symlink_path],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
            )
            if b"failed" in res.stderr:
                return False
            sys.stdout.buffer.write(res.stdout or res.stderr)

    return True


if __name__ == "__main__":
    home_dir = os.path.expanduser("~")
    symlink_dotfiles(home_dir, f"{home_dir}/dotfiles", [".git", ".gitignore"])
