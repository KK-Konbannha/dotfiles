from typing import Literal


Dist_type = Literal["A", "U"]


def check_env():
    """
    Function to check the environment. Ask if it is on WSL and the distribution.

    Returns:
        list[bool | Dist_type]: List containing environment information.
            - "DIST" (Dist_type): Distribution ("A" -> Arch, "U" -> Ubuntu).
            - "IS_GUI" (bool): Whether it is a GUI environment or not.
            - "IS_WSL" (bool): Whether to install on WSL or not.
    """
    DIST: Dist_type = check_dist()
    if DIST == "A":
        IS_GUI: bool = check_gui()
        IS_WSL: bool = check_wsl()
    else:
        IS_GUI: bool = False
        IS_WSL: bool = False

    return [
        DIST,
        IS_GUI,
        IS_WSL,
    ]


def check_dist() -> Dist_type:
    """
    Function to check the distribution.

    Returns:
        Dist_type: Distribution ("A" -> Arch, "U" -> Ubuntu).
    """
    while True:
        dist: str = input(
            "Which distribution are you using?[(A)rch/(U)buntu]: "
        ).lower()
        match dist:
            case "a" | "arch":
                return "A"
            case "u" | "ubuntu":
                return "U"
            case _:
                print("Only Arch or Ubuntu is supported.")
                print("Please answer Arch or Ubuntu.")


def check_gui() -> bool:
    """
    Function to check if it is a GUI environment.

    Returns:
        bool: Whether it is a GUI environment or not.
    """
    while True:
        is_gui: str = input("Is it a GUI environment? [Y/n]: ").lower()
        match is_gui:
            case "y" | "yes":
                return True
            case "n" | "no":
                return False
            case _:
                print("Please answer Yes or No.")


def check_wsl() -> bool:
    """
    Function to check if it is on WSL.

    Returns:
        bool: Whether to install on WSL or not.
    """
    while True:
        is_wsl_input: str = input("Are you trying to install on WSL? [Y/n]: ").lower()
        match is_wsl_input:
            case "y" | "yes":
                return True
            case "n" | "no":
                return False
            case _:
                print("Please answer Yes or No.")
