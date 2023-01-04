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
# tab = "mod3"
terminal = guess_terminal()

colors = [["#292d3e", "#292d3e"],  # Panel background
          ["#434758", "#434758"],  # Promp background
          ["#78aedd", "#78aedd"],  # Alternate powerline
          ["#bc13fe", "#bc13fe"],  # Prompt foreground
          ["#8d62a9", "#8d62a9"],  # This screen group border
          #   ["#e1acff", "#e1acff"],  # window name
          ["#f1ffff", "#f1ffff"],  # Group up
          ["#4c566a", "#4c566a"],  # Group down
          ["#000000", "#000000"],          
          ["#04adff", "#04adff"],  # begin colormap
          ["#AFE1AF", "#AFE1AF"],
          ["#039c4b", "#039c4b"],
          ["#F7DC6F", "#F7DC6F"],
          ["#F39C12", "#F39C12"],
          ["#f76e5c", "#f76e5c"],
          ["#AD343E", "#AD343E"],  # end colormap, red
          ]
rofi_cmd = lazy.spawn("rofi -show drun -display-drun '> '")

keys = [
    # Switch between windows
    Key([mod, "control"], "h", lazy.layout.left()),
    Key([mod, "control"], "l", lazy.layout.right()),
    Key([mod, "control"], "j", lazy.layout.down()),
    Key([mod, "control"], "k", lazy.layout.up()),
    Key([mod, "control"], "space", lazy.layout.next()),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "control", "shift"], "h", lazy.layout.shuffle_left(),),
    Key([mod, "control", "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "control", "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "control", "shift"], "k", lazy.layout.shuffle_up()),
    # Grow windows
    # Key([mod, "shift"], "h", lazy.layout.shrink()),
    # Key([mod, "shift"], "l", lazy.layout.grow()),
    Key([mod, "shift"], "j", lazy.layout.shrink()),
    Key([mod, "shift"], "k", lazy.layout.grow()),
    Key([mod, "shift"], "n", lazy.layout.reset()),
    # Key([mod], "m", lazy.layout.maximize()),
    Key([mod], "f", lazy.window.toggle_floating()),
    Key([mod], "m", lazy.window.toggle_fullscreen()),
    # Toggle between split and unsplit sides of stack.
    # Key([mod, "shift"], "space", lazy.layout.toggle_split()),
    # Toggle between different layouts as defined below
    Key([mod, "shift"], "Tab", lazy.next_layout()),
    # Qtile
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.reload_config()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod, "control", "shift"], "return", lazy.spawn("virtual-monitor")),
    # Applications
    Key([mod], "r", lazy.spawn("rofi -show run -display-run '> '")),
    Key([mod], "return", rofi_cmd()),
    Key([mod, "control"], "w", lazy.run_extension(extension.WindowList())),
    Key([mod, "control"], "t", lazy.spawn(terminal)),
    Key([mod, "control"], "b", lazy.spawn("chromium")),
    Key([mod, "control"], "e", lazy.spawn("nautilus")),
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
group_names = ["H  ",
               "B  ",
               "D  ",
               "T  ",
               "E  ",
               "C  ",
               "V  ",
               "A  ",
               #    "R  ",
               ]

groups = [Group(name, layout="monadtall") for name in group_names]

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
                  "border_focus": colors[2], "border_normal": "#1D2330"}

layouts = [
    # layout.Bsp(),
    # layout.Columns(**layout_default),
    # layout.Floating(**layout_default),
    # layout.Matrix(),
    layout.Max(**layout_default),
    layout.MonadTall(**layout_default),
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

widget_default = {"padding": 0}
screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.Image(
                    filename="/usr/share/lxqt/graphics/helix_60.png",
                    background=colors[0],
                    margin_x=6,
                    mouse_callbacks={
                        'Button1': rofi_cmd()
                    }
                ),                
                widget.GroupBox(
                    font="Ubuntu Bold",
                    fontsize=12,
                    margin_y=2,
                    margin_x=0,
                    padding_y=5,
                    padding_x=0,
                    borderwidth=3,
                    active=colors[5],
                    inactive=colors[6],
                    rounded=True,
                    # highlight_color=colors[9],
                    highlight_method='block',
                    urgent_alert_method='block',
                    this_current_screen_border=colors[4],
                    this_screen_border=colors[4],
                    other_current_screen_border=colors[0],
                    other_screen_border=colors[0],
                    foreground=colors[0],
                    background=colors[0],
                    disable_drag=True
                ),
                widget.Prompt(
                    prompt=lazy.run_extension(extension.J4DmenuDesktop(
        background=colors[0][0],
        # foreground=colors[2][0],
        selected_background=colors[4][0],
        # selected_foreground=colors[2][0],
        dmenu_bottom=True,
        dmenu_ignorecase=True,
        dmenu_prompt=">",
    )),
                    # font="Ubuntu Mono",
                    padding=10,
                    foreground=colors[4],
                    background=colors[1],
                    # prompt="Run: ",
                ),
                widget.Sep(
                    linewidth=0,
                    padding=40,
                    foreground=colors[0],
                    background=colors[0]
                ),
                widget.WindowName(
                    foreground=colors[2],
                    background=colors[0],
                    **widget_default
                ),
                widget.TextBox(
                    text='',
                    foreground=colors[4],
                    background=colors[0],
                    **widget_default,
                    fontsize=45
                ),
                widget.Systray(                    
                    background=colors[4],
                    padding=0,                    
                ),
                widget.TextBox(
                    text='',
                    foreground=colors[2],
                    background=colors[4],
                    **widget_default,
                    fontsize=45
                ),
                widget.TextBox(
                    text="",
                    foreground=colors[7],
                    background=colors[2],
                    **widget_default,
                    fontsize=16
                ),
                widget.CPU(
                    foreground=colors[0],
                    background=colors[2],
                    format="{freq_current}Ghz {load_percent}%",
                    mouse_callbacks={'Button1': lazy.spawn(
                        'terminator -e htop')},
                    padding=5,
                ),
                widget.TextBox(
                    text='',
                    foreground=colors[4],
                    background=colors[2],
                    **widget_default,
                    fontsize=45
                ),
                widget.TextBox(
                    text="",
                    foreground=colors[7],
                    background=colors[4],
                    **widget_default,
                    fontsize=16
                ),
                widget.Memory(
                    foreground=colors[7],
                    background=colors[4],
                    mouse_callbacks={'Button1': lazy.spawn(
                        'terminator -e htop')},
                    padding=5
                ),
                widget.TextBox(
                    text='',
                    foreground=colors[2],
                    background=colors[4],
                    **widget_default,
                    fontsize=45
                ),
                widget.TextBox(
                    text="直",
                    foreground=colors[7],
                    background=colors[2],
                    **widget_default,
                    fontsize=16,
                    mouse_callbacks={'Button1': lazy.spawn(
                        'rofi-network-manager')},
                ),
                widget.Net(
                    foreground=colors[7],
                    background=colors[2],
                    prefix="M",
                    format="{down}↓↑{up}",
                    mouse_callbacks={'Button1': lazy.spawn(
                        'rofi-network-manager')},                                    
                ),
                widget.TextBox(
                    text='',
                    foreground=colors[4],
                    background=colors[2],
                    **widget_default,
                    fontsize=37
                ),
                widget.TextBox(
                    text="墳",
                    foreground=colors[7],
                    background=colors[4],
                    **widget_default,
                    mouse_callbacks={
                        "Button1": lazy.spawn("pavucontrol")},
                    fontsize=16
                ),
                widget.PulseVolume(
                    foreground=colors[7],
                    background=colors[4],
                    padding=5,
                    limit_max_volume=True,
                ),
                widget.TextBox(
                    text='',
                    foreground=colors[2],
                    background=colors[4],
                    **widget_default,
                    fontsize=37
                ),
                widget.Battery(
                    foreground=colors[7],
                    background=colors[2],
                    charge_char="",
                    full_char="",
                    discharge_char="",
                    unknown_char="",
                    empty_char="",
                    format=" {char} {percent:2.0%} ",
                ),
                widget.TextBox(
                    text='',
                    foreground=colors[4],
                    background=colors[2],
                    **widget_default,
                    fontsize=42
                ),
                widget.TextBox(
                    text='',
                    foreground=colors[7],
                    background=colors[4],
                    **widget_default,
                    fontsize=16
                ),
                widget.Clock(
                    foreground=colors[7],
                    background=colors[4],
                    # mouse_callbacks={
                    #     "Button1": lambda qtile: qtile.cmd_spawn(PWA.calendar())},
                    format=" %a, %B %d - %H:%M ",
                ),
                widget.TextBox(
                    text='',
                    foreground=colors[7],
                    background=colors[4],
                    mouse_callbacks={'Button1': lazy.spawn(
                        "rofi -show powermenu -theme powermenu -modi powermenu:' \
                            rofi-power-menu --choices=lockscreen/logout/suspend/reboot/shutdown'")},
                    padding=6,
                    fontsize=16,
                ),
            ],
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
    DropDown("terminal", terminal, x=0.0, y=0.65, width=0.998)])])

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


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
