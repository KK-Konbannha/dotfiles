import os
import subprocess


def install_packages_from_file(file_path: str, IS_BREAK: bool = False):
    """
    Function to read the package list from the specified file path and install it using paru.

    Params:
        file_path (str): Package list file path.
        IS_BREAK (bool): Whether to exit the loop if there is a blank line or not.
    """
    install_packages = []

    with open(file_path, "r") as f:
        packages = f.readlines()

    for package in packages:
        package = package.strip()  # Delete extra spaces and line breaks
        if not package:
            if IS_BREAK:
                break
            else:
                continue

        install_packages.append(package)

    subprocess.run(["paru", "-g"])
    subprocess.run(
        ["paru", "-S", "--needed", "--noconfirm"]
        + [package for package in install_packages]
    )


def install_apps_by_paru(dotfiles_dir: str, IS_GUI: bool, IS_WSL: bool):
    """
    Function to install applications listed in app_list.txt using paru.

    Params:
        dotfiles_dir (str): Path to dotfiles directory.
        IS_GUI (bool): Whether it is a GUI environment or not.
        IS_WSL (bool): Whether to install on WSL or not.
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
    install_apps_by_paru(f"{home_dir}/dotfiles", False, False)
