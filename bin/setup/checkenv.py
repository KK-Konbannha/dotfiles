from typing import Final, Literal


Dist_type = Literal["A", "U"]


def checkenv() -> dict[str, bool | Dist_type]:
    """
    環境を確かめる関数。

    2022/08/23 現在 対応環境
    wsl上:              Arch
                        Ubuntu
    直接インストール:   Arch
    """
    print(
        """

======================================================
    2022/08/23 現在 対応環境
    wsl上:              Arch
                        Ubuntu
    直接インストール:   Arch
======================================================

    """
    )

    IS_WSL: Final[bool] = checkwsl()
    DIST: Final[Dist_type] = checkdist()

    return {"IS_WSL": IS_WSL, "DIST": DIST}


def checkwsl() -> bool:
    """
    wsl上か確かめる関数。
    """
    is_wsl_input: Final[str] = input("wsl上にインストールしようとしていますか？ [Y/n]")
    match is_wsl_input:
        case "Y" | "Yes" | "y" | "yes":
            return True
        case "N" | "No" | "n" | "no":
            return False
        case _:
            print("YesかNoで答えてください。\n")
            checkwsl()

    return False


def checkdist() -> Dist_type:
    """
    ディストリビューションを確かめる関数。
    """
    dist: Final[str] = input("ディストリビューションは何を使っていますか？[(A)rch/(U)buntu]")
    match dist:
        case "A" | "Arch" | "a" | "arch":
            return "A"
        case "U" | "Ubuntu" | "u" | "ubuntu":
            return "U"
        case _:
            print("現在ArchまたはUbuntuのみの対応になります。\n")
            checkdist()

    return "A"
