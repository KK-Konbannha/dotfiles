from libqtile.config import Key
from libqtile.lazy import lazy

from modules.groups import groups
from modules.get_images_path import get_black_wallpaper_path

mod = "mod4"
terminal = "wezterm"
black_wallpaper_path = get_black_wallpaper_path()

keys = [
    Key([mod], "w", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "a", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "s", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "d", lazy.layout.right(), desc="Move focus to right"),
    Key([mod, "shift"], "w", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(
        [mod, "shift"],
        "a",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "s",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key(
        [mod, "shift"],
        "d",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod, "control"],
        "r",
        lazy.reload_config(),
        desc="Reload the config",
    ),
    Key(
        [mod],
        "0",
        lazy.spawn("rofi -show drun"),
    ),
    Key(
        [mod],
        "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget",
    ),
    Key([mod], "f", lazy.spawn("firefox"), desc="Launch firefox"),
    Key(
        [mod],
        "b",
        lazy.screen.set_wallpaper(black_wallpaper_path, mode="stretch"),
        desc="Change wallpaper to black",
    ),
]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
            ),
            Key(
                [mod, "control"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
            ),
        ]
    )
