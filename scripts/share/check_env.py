from typing import Literal, Union


Dist_type = Literal["A", "U"]


def check_env() -> dict[str, Union[bool, Dist_type]]:
    """
    環境を確認する関数。WSL上かどうかとディストリビューションを尋ねる。

    Returns:
        dict[str, Union[bool, Dist_type]]: 環境情報を含む辞書。
            - "DIST" (Dist_type): ディストリビューション ("A" -> Arch, "U" -> Ubuntu)。
            - "IS_GUI" (bool): GUI環境かどうかの真偽値。
            - "IS_WSL" (bool): WSL上にインストールするかどうかの真偽値。
    """
    print(
        """

╭──────────────────────────────────────────────────────────╮
│  ======================================================  │
│                 2022/08/23 現在 対応環境                 │
│                 wsl上:              Arch                 │
│                                     Ubuntu               │
│                 直接インストール:   Arch                 │
│  ======================================================  │
╰──────────────────────────────────────────────────────────╯


    """
    )

    DIST: Dist_type = check_dist()
    if DIST == "A":
        IS_GUI: bool = check_gui()
        IS_WSL: bool = check_wsl()
    else:
        IS_GUI: bool = False
        IS_WSL: bool = False

    return {
        "DIST": DIST,
        "IS_GUI": IS_GUI,
        "IS_WSL": IS_WSL,
    }


def check_dist() -> Dist_type:
    """
    ディストリビューションを確認する関数。
    Returns:
        Dist_type: ディストリビューション ("A" -> Arch, "U" -> Ubuntu)。
    """
    while True:
        dist: str = input("ディストリビューションは何を使っていますか？[(A)rch/(U)buntu]: ").lower()
        match dist:
            case "a" | "arch":
                return "A"
            case "u" | "ubuntu":
                return "U"
            case _:
                print("ArchまたはUbuntuのみの対応になります。")
                print("ArchかUbuntuで答えてください。")


def check_gui() -> bool:
    """
    GUI環境かどうかを確認する関数。
    Returns:
        bool: GUI環境かどうかの真偽値。
    """
    while True:
        is_gui: str = input("GUI環境ですか？ [Y/n]: ").lower()
        match is_gui:
            case "y" | "yes":
                return True
            case "n" | "no":
                return False
            case _:
                print("YesかNoで答えてください。")


def check_wsl() -> bool:
    """
    WSL上かどうかを確認する関数。
    Returns:
        bool: WSL上にインストールするかどうかの真偽値。
    """
    while True:
        is_wsl_input: str = input("wsl上にインストールしようとしていますか？ [Y/n]: ").lower()
        match is_wsl_input:
            case "y" | "yes":
                return True
            case "n" | "no":
                return False
            case _:
                print("YesかNoで答えてください。")
