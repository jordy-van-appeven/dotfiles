# Customized config.py for Qtile (tiling) window manager configuration (http://www.qtile.org/)
# Modified by Jordy van Appeven (https://github.com/jordy-van-appeven/dotfiles/tree/main/qtile)

import os
import subprocess
from libqtile import bar, extension, hook, layout, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
alt = "mod1"
terminal = guess_terminal()
#file_manager = "nautilus --new-window "
file_manager = terminal + " --command vifm"
browser = "chromium --new-window "
dev_env = terminal + " --command vim"

from theme import dracula
theme = dracula

rofi_cmd = lazy.spawn("rofi -show drun -display-drun '> '")

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "space", lazy.layout.next()),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "return", lazy.layout.toggle_split()),
    # Grow windows
    # Key([mod, "shift"], "h", lazy.layout.shrink()),
    # Key([mod, "shift"], "l", lazy.layout.grow()),
    Key([mod, "control"], "j", lazy.layout.shrink()),
    Key([mod, "control"], "k", lazy.layout.grow()),
    Key([mod, "control"], "n", lazy.layout.reset()),
    # Key([mod], "m", lazy.layout.maximize()),
    Key([mod, "control"], "f", lazy.window.toggle_floating()),
    Key([mod, "control"], "m", lazy.window.toggle_fullscreen()),
    # Toggle between split and unsplit sides of stack.
    # Key([mod, "shift"], "space", lazy.layout.toggle_split()),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.run_extension(extension.WindowList())),
    # Qtile
    Key([mod, "control"], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.reload_config()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod, "control", "shift"], "return", lazy.spawn("virtual-monitor $(xrandr --listactivemonitors | grep -m1 0 | grep -o '[^ ]*$')")),
    # Applications
    Key([mod], "r", lazy.spawn("rofi -show run -display-run '> '")),
    Key([mod], "return", rofi_cmd()),    
    Key([mod, "control"], "d", lazy.spawn(dev_env)),
    Key([mod, "control"], "t", lazy.spawn(terminal)),
    Key([mod, "control"], "b", lazy.spawn(browser)),
    Key([mod, "control"], "e", lazy.spawn(file_manager)),
    Key([mod, "control"], "v", lazy.spawn(browser + "http://youtube.com")),
    # Treetab controls
    # Key([mod, "shift"], "j", lazy.layout.move_up()),
    # Key([mod, "shift"], "k", lazy.layout.move_down()),
    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
]

# You can define a letter and its icon here
group_names = ["S  ",
               "B  ",
               "D  ",
               "T  ",
               "E  ",
               "C  ",
               "V  ",
               "M  ",
               #    "R  ",
               ]

groups = [Group(name, layout="columns") for name in group_names]

for group in groups:
    keys.extend(
        [
            Key(
                [mod],
                group.name[0],
                lazy.group[group.name].toscreen(),
            ),
            Key([mod, "shift"], group.name[0],
                lazy.window.togroup(group.name, switch_group=True)),
        ]
    )

layout_default = {"border_width": 2, "margin": 0,
                  "border_focus": theme["bar_background"], "border_normal": "#1D2330"}

layouts = [
    # layout.Bsp(),
    layout.Columns(**layout_default, num_columns=2, insert_position=1),
    # layout.Floating(**layout_default),
    # layout.Matrix(),
    layout.Max(**layout_default),
    # layout.MonadTall(**layout_default),
    # layout.MonadWide(**layout_default),
    # layout.RatioTile(),
    # layout.Stack(num_stacks=2),
    # layout.Tile(**layout_default),
    # layout.TreeTab(font="Ubuntu",
    #                fontsize=10,
    #                sections=["FIRST", "SECOND", "THIRD", "FOURTH"],
    #                section_fontsize=10,
    #                border_width=2,
    #                bg_color="1c1f24",
    #                active_bg="c678dd",
    #                active_fg="000000",
    #                inactive_bg="a9a1e1",
    #                inactive_fg="1c1f24",
    #                padding_left=0,
    #                padding_x=0,
    #                padding_y=5,
    #                section_top=10,
    #                section_bottom=20,
    #                level_shift=8,
    #                vspace=3,
    #                panel_width=200),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Ubuntu Nerd Font',
    fontsize=14,
    padding=4,
    foreground=theme["bar_foreground"],
    background=theme["bar_background"]
)
extension_defaults = widget_defaults.copy()


def get_widgets(primary=False):
    return [
        widget.Image(
            filename="/usr/share/lxqt/themes/Lubuntu Arc/mainmenu.svg",
            background=theme["background"],
            margin=2,
            scale=True,
            margin_x=5,            
            mouse_callbacks={
                'Button1': rofi_cmd()
            }
        ),
        widget.GroupBox(
            font="Ubuntu Nerd Font",
            fontsize=14,
            margin_y=4,
            margin_x=0,
            padding_y=5,
            padding_x=4,
            borderwidth=3,
            active=theme["foreground"],
            inactive=theme["inactive"],
            rounded=True,
            highlight_color=theme["bar_background"],
            highlight_method='block',
            urgent_alert_method='block',
            this_current_screen_border=theme["bar_background"],
            this_screen_border=theme["bar_background"],
            other_current_screen_border=theme["background"],
            other_screen_border=theme["background"],
            foreground=theme["background"],
            background=theme["background"],
            disable_drag=True
        ),
        widget.Sep(
            linewidth=0,
            padding=40,
            foreground=theme["background"],
            background=theme["background"],
        ),
        widget.WindowName(
            foreground=theme["bar_background"],
            background=theme["background"],            
        ),
        widget.TextBox(
            text=' ',
            foreground=theme["bar_background"],
            background=theme["background"],
            fontsize=45,
            padding=0,
        ),
        widget.Systray(
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
        ) if primary else widget.Sep(foreground=theme["bar_foreground"], background=theme["bar_background"],),
        widget.TextBox(
            text=" ",
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            fontsize=17,
        ),
        widget.CPU(
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            format="{freq_current}Ghz {load_percent}%",
            mouse_callbacks={'Button1': lazy.spawn(
                terminal + ' -e htop')},
        ),
        widget.TextBox(
            text=" ",
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            fontsize=17
        ),
        widget.Memory(
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            format='{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}',
            mouse_callbacks={'Button1': lazy.spawn(
                terminal + ' -e htop')},
        ),
        widget.TextBox(
            text=" 直",
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            fontsize=17,
            mouse_callbacks={'Button1': lazy.spawn(
                'rofi-network-manager')},
        ),
        widget.Net(
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            prefix="M",
            format="{down} ↓↑ {up}",
            mouse_callbacks={'Button1': lazy.spawn(
                'rofi-network-manager')},
        ),
        widget.TextBox(
            text=" 墳",
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            mouse_callbacks={
                "Button1": lazy.spawn("pavucontrol")},
            fontsize=17,
        ),
        widget.PulseVolume(
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            limit_max_volume=True,
            fmt="{}"
        ),
        widget.Battery(
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            charge_char="",
            full_char="",
            discharge_char="",
            unknown_char="",
            empty_char="",
            format=" {char} {percent:2.0%} ",
        ),
        widget.Clock(
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            # mouse_callbacks={
            #     "Button1": lambda qtile: qtile.cmd_spawn(PWA.calendar())},
            format=" %a, %B %d |  %H:%M ",
        ),
        widget.TextBox(
            text=' ',
            foreground=theme["bar_foreground"],
            background=theme["bar_background"],
            mouse_callbacks={'Button1': lazy.spawn(
                "rofi -show powermenu -theme powermenu -modi powermenu:' \
                            rofi-power-menu --choices=lockscreen/logout/suspend/reboot/shutdown'")},
            padding=6,
            fontsize=17,
        ),
    ]


screens = [
    Screen(
        bottom=bar.Bar(get_widgets(primary=True),
                       size=24,
                       ),
    ),
    Screen(
        bottom=bar.Bar(get_widgets(),
                       size=24,
                       ),
    ),
    Screen(
        bottom=bar.Bar(get_widgets(),
                       size=24,
                       ),
    ),
    Screen(
        bottom=bar.Bar(get_widgets(),
                       size=24,
                       ),
    ),
    Screen(
        bottom=bar.Bar(get_widgets(),
                       size=24,
                       ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

groups.extend([ScratchPad("terminal", [
    DropDown("terminal", terminal, x=0.0, y=0.25, width=0.998, height=0.75)])])

keys.extend([Key([mod, "control"], "return", lazy.group["terminal"].dropdown_toggle("terminal")),
             ])

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    **layout_default,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
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


@hook.subscribe.startup
def start():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

