# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from lib.widget import MyGmailChecker
from lib.get_wallpaper_path import (
    get_random_wallpaper_path,
    get_black_wallpaper_path,
)


mod = "mod4"
terminal = guess_terminal()
wallpapers_dir_path = os.path.expanduser("~/Wallpapers")
selected_wallpaper_path = get_random_wallpaper_path(wallpapers_dir_path)
black_wallpaper_path = get_black_wallpaper_path()

keys = [
    Key([mod], "a", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "d", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "s", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "w", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod, "shift"],
        "a",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "d",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "s",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key([mod, "shift"], "w", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
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


def init_group_names():
    return [
        ("   ", {"layout": "MonadTall"}),
        ("   ", {"layout": "MonadTall"}),
        ("   ", {"layout": "MonadTall"}),
    ]


def init_groups(group_names):
    return [Group(name, **kwargs) for name, kwargs in group_names]


if __name__ in ["config", "__main__"]:
    group_names = init_group_names()
    groups = init_groups(group_names)

    for i, (name, kwargs) in enumerate(group_names, 1):
        keys.extend(
            [
                Key(
                    [mod],
                    str(i),
                    lazy.group[name].toscreen(),
                ),
                Key(
                    [mod, "shift"],
                    str(i),
                    lazy.window.togroup(name, switch_group=True),
                ),
            ]
        )

layouts = [
    layout.MonadTall(border_focus="#57ffff", border_width=2, margin=16),
]

widget_defaults = dict(
    font="HackGenNerd With FFxiv Glyph",
    fontsize=20,
    padding=4,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox("    "),
                widget.GroupBox(
                    fontsize=18,
                    border_width=1,
                    this_current_screen_border="03f8fc",
                    margin=3,
                ),
                widget.Prompt(prompt="  : "),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                MyGmailChecker(),
                widget.Clock(format="%m-%d %a %H:%M"),
            ],
            32,
            margin=[16, 16, 0, 16],
            border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            border_color=[
                "ff8fff",
                "000000",
                "ff8fff",
                "000000",
            ],  # Borders are magenta
        ),
        wallpaper=selected_wallpaper_path,
        wallpaper_mode="fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client. # noqa: E501
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
