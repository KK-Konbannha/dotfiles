#!/bin/python
import os
import argparse
from typing import Final


def main():
    HOME: Final[str] = os.path.expanduser("~")

    DOT_DIRECTORY: Final[str] = f"{HOME}/dotfiles"
    REMOTE_URL: Final[str] = "https://github.com/KK-Konbannha/dotfiles.git"

    parser = argparse.ArgumentParser(description="setup my dotfiles")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("-d", "--deploy", help="deploy dotfiles")
    group.add_argument(
        "-i", "--init", help="install packages and deploy dotfiles"
    )
