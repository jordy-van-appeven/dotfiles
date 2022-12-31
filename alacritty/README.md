# Alacritty

## Install

```shell
$ git clone https://github.com/alacritty/alacritty.git
```

Then follow manual build [instructions](https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu)

## Theme

```shell
$ mkdir -p ~/.config/alacritty

$ wget https://raw.githubusercontent.com/alacritty/alacritty/master/alacritty.yml -O ~/.config/alacritty/alacritty.yml
```

Open `alacritty.yml`, add import tag and specify `yml` theme file.

```vim
import:
  - dracula.yml
```
