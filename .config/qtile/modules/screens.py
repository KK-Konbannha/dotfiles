from libqtile import qtile
from libqtile import bar, widget
from libqtile.config import Screen

from modules.settings import wallpapers_dir_path
from modules.get_images_path import get_random_wallpaper_path
from modules.colors import dracula

selected_wallpaper_path = get_random_wallpaper_path(wallpapers_dir_path)


def open_rofi():
    qtile.cmd_spawn("rofi -show combi")


screens = [
    Screen(
        top=bar.Bar(
            [
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
                    text=" ",
                    fontsize=33,
                    foreground=dracula["purple"],
                    background=dracula["bg"],
                    padding=0,
                ),
                widget.Spacer(length=20, background=dracula["bg"]),
                widget.GroupBox(
                    font="apricotJapanesefontT",
                    fontsize=25,
                    border_width=1,
                    this_current_screen_border="8be9fd",
                    padding=2,
                    # margin=4,
                    background=dracula["bg"],
                ),
                widget.TextBox(
                    text=" ",
                    fontsize=33,
                    foreground=dracula["bg"],
                    padding=0,
                ),
                widget.Spacer(length=40),
                # widget.Prompt(
                #     prompt="  : ",
                # ),
                widget.Spacer(length=bar.STRETCH),
                widget.Systray(icon_size=28),
                widget.TextBox(
                    text=" ",
                    fontsize=33,
                    foreground=dracula["bg"],
                    padding=0,
                ),
                widget.Battery(
                    format="  {percent:2.0%}", background=dracula["bg"]
                ),
                widget.TextBox(
                    text=" ",
                    fontsize=33,
                    foreground=dracula["green"],
                    background=dracula["bg"],
                    padding=0,
                ),
                widget.Clock(
                    font="apricotJapanesefontT",
                    fontsize=25,
                    format="%m-%d %a %H:%M",
                    background=dracula["green"],
                    foreground=dracula["bg"],
                ),
            ],
            32,
            # background=dracula["bg"],
            background="#00000000",
            opacity=1,
            margin=[12, 16, 0, 16],
        ),
        wallpaper=selected_wallpaper_path,
        wallpaper_mode="fill",
    ),
]
