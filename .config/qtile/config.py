"""
# My qtile config
"""
import subprocess
from os.path import expanduser
from libqtile import bar, layout, hook

from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.command.client import CommandClient
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

command_client = CommandClient()

colors = {
    "black": "#1d2021",
    "gray": "#282828",
    "gray2": "#504945",
    "blue": "#458588",
    "cyan": "#689d6a",
    "green": "#98971a",
    "magenta": "#b16286",
    "red": "#cc241d",
    "white": "#ebdbb2",
    "yellow": "#d79921",
    "separator": "#3c3836",
}

mod = "mod4"
terminal = guess_terminal()

keys = [
    # Switch between windows
    Key(
        [mod],
        "h",
        lazy.layout.left(),
        desc="Move focus to left"
    ),
    Key(
        [mod],
        "l",
        lazy.layout.right(),
        desc="Move focus to right"
    ),
    Key(
        [mod],
        "j",
        lazy.layout.down(),
        desc="Move focus down"
    ),
    Key(
        [mod],
        "k",
        lazy.layout.up(),
        desc="Move focus up"
    ),
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window"
    ),
    Key(
        [mod],
        "n",
        lazy.layout.normalize(),
        desc="Reset all window sizes"
    ),
    Key(
        [mod],
        "Return",
        lazy.spawn(terminal),
        desc="Launch terminal"
    ),
    Key(
        [mod],
        "d",
        lazy.spawn("rofi -show drun -modi drun &")
    ),
    Key(
        [mod],
        "c",
        lazy.spawn(
            """
            rofi \
                -modi \"clipboard:greenclip print\" \
                -show clipboard \
                -run-command '{cmd}'
            """
        )
    ),
    Key(
        [mod],
        "w",
        lazy.spawn(
            "rofi -show window &")
    ),
    Key(
        [mod],
        "s",
        lazy.next_screen(),
        desc="Go to next screen"
    ),
    Key(
        [mod],
        "a",
        lazy.prev_screen(),
        desc="Go to previous screen"
    ),
    Key(
        [mod],
        "p",
        lazy.spawn("flameshot screen "),
        desc="Take a screenshot"
    ),
    # Toggle between different layouts as defined below
    Key(
        [mod],
        "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts"
    ),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen()),
    Key(
        [mod],
        "b",
        lazy.screen.toggle_group()),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "Shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key(
        [mod, "Shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key(
        [mod, "Shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"
    ),
    Key(
        [mod, "Shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"
    ),
    Key(
        [mod, "Shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(
        [mod, "Shift"],
        "Space",
        lazy.window.toggle_floating()),
    Key(
        [mod, "Shift"],
        "q",
        lazy.window.kill(),
        desc="Kill focused window"
    ),
    Key(
        [mod, "Shift"],
        "r",
        lazy.reload_config(),
        desc="Reload the config"
    ),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "Control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key(
        [mod, "Control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key(
        [mod, "Control"],
        "j",
        lazy.layout.grow(),
        desc="Grow window down"
    ),
    Key(
        [mod, "Control"],
        "k",
        lazy.layout.shrink(),
        desc="Grow window up"
    ),
    Key(
        [mod, "Control"],
        "h",
        lazy.layout.grow(),
        desc="Grow window down"
    ),
    Key(
        [mod, "Control"],
        "l",
        lazy.layout.shrink(),
        desc="Grow window up"
    ),
    Key(
        [mod, "Control"],
        "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
    ),
    Key(
        [mod, "Shift", "Control"],
        "l",
        lazy.spawn("light-locker-command -l"),
        desc="Grow window up"
    ),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.MonadTall(
        margin=8,
        border_width=3,
        border_focus=colors["gray2"],
        border_normal=colors["black"],

    ),
    layout.Max(
        margin=8,
        border_width=3,
        border_focus=colors["gray2"],
        border_normal=colors["black"],
    ),
]

screens = [
    Screen(
        top=bar.Gap(24)
    ),
]
#
# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),
    Drag(
        [mod, "Shift"],
        "Button1",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),
    Click(
        [mod],
        "Button1",
        lazy.window.bring_to_front()
    ),

]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
    ],
    border_width=4,
    border_normal=colors["black"],
    border_focus=colors["gray2"]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True


@hook.subscribe.startup_once
def start_things_once():
    home = expanduser("~")
    processes = [
        "redshift -P -O 4500".split(" "),
        "eww daemon".split(" "),
        "eww open bar --screen=0".split(" "),
        "eww open bar --screen=1".split(" "),
        "greenclip daemon".split(" "),
        f"picom -b --config {home}/.config/picom.conf".split(" "),
        "light-locker".split(" "),
    ]
    for process in processes:
        subprocess.Popen(process)


@hook.subscribe.startup
def start_things_always():

    home = expanduser("~")
    processes = [
        "setxkbmap -option caps:swapescape".split(" "),
        ["feh", "--bg-scale",
            f"{home}/Pictures/Wallpapers/gruvbox-rocket.png"],
        "eww reload".split(" ")
    ]
    for process in processes:
        subprocess.Popen(process)


@hook.subscribe.client_managed
@hook.subscribe.client_urgent_hint_changed
@hook.subscribe.client_killed
@hook.subscribe.setgroup
@hook.subscribe.group_window_add
@hook.subscribe.current_screen_change
@hook.subscribe.changegroup
def register_workspace_switch(*args, **kwargs):
    python_script = expanduser('~/.config/eww/scripts/qtile-get-workspaces.py')
    subprocess.Popen(["python3", python_script, "--direct-update"])


auto_minimize = True

wl_input_rules = None

wmname = "LG3D"
