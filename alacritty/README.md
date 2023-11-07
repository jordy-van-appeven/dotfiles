# Alacritty

## Install

```shell
$ sudo apt install cargo
$ cd ~ && git clone https://github.com/alacritty/alacritty.git
```

Next, follow manual [build](https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu) and post [build](https://github.com/alacritty/alacritty/blob/master/INSTALL.md#post-build) instructions. 

Then change the default terminal emulator.

```shell
$ sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
$ sudo update-alternatives --config x-terminal-emulator
```

## Theme

Open `alacritty.yml`, add import tag and uncomment one of the `yml` theme files (see example below).

```vim
import:
  - dracula.yml
```

For a 'catppuccin' theme, execute the following command:

```shell
$ git clone https://github.com/catppuccin/alacritty.git ~/.config/alacritty/catppuccin
```

