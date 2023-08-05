from typing import Literal, Union


Dist_type = Literal["A", "U"]


def check_env() -> dict[str, Union[bool, Dist_type]]:
    """
    環境を確認する関数。WSL上かどうかとディストリビューションを尋ねる。

    Returns:
        dict[str, Union[bool, Dist_type]]: 環境情報を含む辞書。
            - "IS_WSL" (bool): WSL上にインストールするかどうかの真偽値。
            - "DIST" (Dist_type): ディストリビューション ("A" -> Arch, "U" -> Ubuntu)。
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

    IS_WSL: bool = check_wsl()
    DIST: Dist_type = check_dist()

    return {"IS_WSL": IS_WSL, "DIST": DIST}


def check_wsl() -> bool:
    """
    WSL上かどうかを確認する関数。
    Returns:
        bool: WSL上にインストールするかどうかの真偽値。
    """
    while True:
        is_wsl_input: str = input("wsl上にインストールしようとしていますか？ [Y/n] ").lower()
        match is_wsl_input:
            case "y" | "yes":
                return True
            case "n" | "no":
                return False
            case _:
                print("YesかNoで答えてください。")


def check_dist() -> Dist_type:
    """
    ディストリビューションを確認する関数。
    Returns:
        Dist_type: ディストリビューション ("A" -> Arch, "U" -> Ubuntu)。
    """
    while True:
        dist: str = input("ディストリビューションは何を使っていますか？[(A)rch/(U)buntu] ").lower()
        match dist:
            case "a" | "arch":
                return "A"
            case "u" | "ubuntu":
                return "U"
            case _:
                print("ArchまたはUbuntuのみの対応になります。")
                print("ArchかUbuntuで答えてください。")
