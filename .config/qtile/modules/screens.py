import os
from libqtile import qtile
from libqtile import bar, widget
from libqtile.config import Screen

from modules.settings import wallpapers_dir_path
from modules.get_images_path import get_random_wallpaper_path
from modules.colors import dracula
from modules.arcobattery import BatteryIcon, is_laptop

selected_wallpaper_path = get_random_wallpaper_path(wallpapers_dir_path)


def open_rofi():
    qtile.cmd_spawn("rofi -show combi")


def display_Battery():
    slash = widget.TextBox(
        text="",
        font="Hack Nerd Font",
        fontsize=33,
        foreground=dracula["bg"],
        padding=0,
    )
    icon = BatteryIcon(
        padding=0,
        scale=0.7,
        y_poss=2,
        theme_path=os.path.expanduser("~/.config/qtile/icons/battery_icons_horiz"),
        update_interval=5,
        background=dracula["bg"],
    )
    condition_str = widget.Battery(
        font="EorzeaSmart",
        fontsize=23,
        format="{percent:2.0%}",
        background=dracula["bg"],
    )

    if is_laptop():
        return [slash, icon, condition_str]
    else:
        return []


widgets = [
    widget.Spacer(length=22, background=dracula["purple"]),
    widget.TextBox(
        text="零",
        font="apricotJapanesefontT",
        fontsize=25,
        background=dracula["purple"],
        mouse_callbacks={"Button1": open_rofi},
    ),
    widget.Spacer(length=5, background=dracula["purple"]),
    widget.TextBox(
        text="",
        fontsize=33,
        font="Hack Nerd Font",
        foreground=dracula["purple"],
        background=dracula["bg"],
        padding=0,
    ),
    widget.Spacer(length=15, background=dracula["bg"]),
    widget.GroupBox(
        font="apricotJapanesefontT",
        fontsize=25,
        border_width=1,
        this_current_screen_border="8be9fd",
        padding=2,
        background=dracula["bg"],
    ),
    widget.TextBox(
        font="Hack Nerd Font",
        text=" ",
        fontsize=33,
        foreground=dracula["bg"],
        padding=0,
    ),
    widget.Spacer(length=40),
    widget.Spacer(length=bar.STRETCH),
    widget.Systray(icon_size=28),
    *display_Battery(),
    widget.TextBox(
        text="",
        font="Hack Nerd Font",
        fontsize=32,
        foreground=dracula["green"],
        background=dracula["bg"] if is_laptop() else "#00000000",
        padding=0,
    ),
    widget.Spacer(length=5, background=dracula["green"]),
    widget.Clock(
        font="EorzeaSmart",
        fontsize=23,
        format="%m-%d %a %H:%M",
        background=dracula["green"],
        foreground=dracula["bg"],
    ),
]

screens = [
    Screen(
        top=bar.Bar(
            widgets,
            32,
            background="#00000000",
            opacity=1,
            margin=[12, 16, 0, 16],
        ),
        wallpaper=selected_wallpaper_path,
        wallpaper_mode="fill",
    ),
]
