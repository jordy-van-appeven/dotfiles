# Alacritty

## Install

```shell
$ git clone https://github.com/alacritty/alacritty.git
```

Next, follow manual build [instructions](https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu)

Then change the default terminal emulator

```shell
$ sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
$ sudo update-alternatives --config x-terminal-emulator
```

## Theme

Open `alacritty.yml`, add import tag and specify `yml` theme file.

```vim
import:
  - dracula.yml
```
