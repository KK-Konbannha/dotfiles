import os
import subprocess
import zipfile
import re
from shutil import which
from urllib.request import urlopen


def clone_dotfiles(home_dir: str, dotfiles_dir: str, remote_url: str) -> bool:
    """
    Install dotfiles from remote repository.

    Params:
        home_dir (str): Home directory path.
        dotfiles_dir (str): Directory path where to install dotfiles.
        remote_url (str): Remote repository URL.

    Returns:
        bool: Whether the installation was successful or not.
    """
    # Handle if the installation directory already exists.
    if os.path.exists(dotfiles_dir):
        while True:
            other_place: str = input(
                "dotfiles are already exists. Clone dotfiles to other place? [Y/n] "
            ).lower()

            match other_place:
                case "y" | "yes":
                    other_dir: str = os.path.expanduser(
                        input(
                            "Please provide a directory relative to home: (e.g., ~/your): "
                        )
                    )
                    if os.path.exists(other_dir) and os.path.isdir(other_dir):
                        return clone_dotfiles(
                            other_dir, f"{other_dir}/dotfiles", remote_url
                        )

                    else:
                        print("Such a directory does not exist.")
                        print("Please enter again.")
                        print("e.g., ~/your")
                        return False

                case "n" | "no":
                    print("Installation of dotfiles is aborted.")
                    return False

                case _:
                    pass

    # If git command is available, execute git clone.
    if which("git"):
        subprocess.run(["git", "clone", remote_url, dotfiles_dir])
        return True

    # If git command is not available, download zip file from remote.
    remote_zip_url = re.sub(r"\.git$", "/archive/refs/heads/main.zip", remote_url)
    zip_file_path = dotfiles_dir + ".zip"

    with urlopen(remote_zip_url) as res, open(zip_file_path, "wb") as f:
        f.write(res.read())

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
    remote_url: str = input("Please input remote url: ")
    clone_dotfiles(home_dir, f"{home_dir}/dotfiles", remote_url)
