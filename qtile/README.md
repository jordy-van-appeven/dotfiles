# Qtile

## Install
Follow instructions from http://docs.qtile.org/en/latest/manual/install/ to install Qtile.

Install depencendies,
```shell
$ sudo apt install suckless-tools 
$ sudo apt install fonts-font-awesome # Note, appears needed for proper font display
```

Additionally, download `Ubuntu Nerd Font` from http://nerdfonts.com/font-downloads. Then install fonts by extracting to `~/.fonts` and rebuild font cache.

```shell
$ unzip Ubuntu.zip -d ~/.fonts
$ fc-cache -fv
```

Now reboot or relogin the Qtile window manager.

## Test
For Ubuntu version 20.04 and newer

```shell
$ unset XDG_SEAT
```

Open nested X Server with Xephyr

```shell
$ Xephyr -br -ac -noreset -screen 1280x720 :1
```

Within a new terminal session specify `DISPLAY` variable and open Qtile with `config.py` file.

```shell
$ export DISPLAY=:1
$ qtile start -c config.py
```