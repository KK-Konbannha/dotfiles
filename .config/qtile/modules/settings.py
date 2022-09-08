import os
from libqtile.utils import guess_terminal


mod = "mod4"
terminal = os.getenv("TERM") or guess_terminal()
wallpapers_dir_path = os.path.expanduser("~/Wallpapers")
widget_defaults = dict(
    font="HackGenNerd With FFxiv Glyph",
    fontsize=20,
    padding=4,
)
