from libqtile import qtile, hook
from libqtile.backend.wayland import InputConfig


from modules.settings import *
from modules.groups import groups
from modules.keys import keys
from modules.layouts import layouts
from modules.screens import screens
from modules.floating import mouse, floating_layout
from modules.colors import dracula


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"

if qtile.core.name == "X11":
    wl_input_rules = None
elif qtile.core.name == "wayland":
    wl_input_rules = {
        "type:keyboard": InputConfig(kb_layout="jp", kb_options="ctrl:nocaps"),
    }

    @hook.subscribe.startup_once
    def autostart():
        qtile.cmd_spawn("fcitx5 &")
