# vim

## Install

```shell
$ sudo apt install vim-gtk
```

### Plugins

#### colorizer
```shell
$ git clone https://github.com/chrisbra/Colorizer.git ~/.vim/pack/start/Colorizer
$ vim ~/.vim/pack/plugins/start/Colorizer/Colorizer.vmb -c ":so %"
```

#### fugitive
```shell
$ mkdir -p ~/.vim/pack/tpope/start
$ git clone https://tpope.io/vim/fugitive.git ~/.vim/pack/tpope/start/fugitive
$ vim -u NONE -c "helptags fugitive/doc" -c q
```

#### lightline
```shell
$ git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline
```

#### vifm
```shell
$ git clone https://github.com/vifm/vifm.vim.git ~/.vim/pack/plugins/start/vifm
```

### Dracula theme

```shell
$ mkdir -p ~/.vim/pack/themes/start

$ git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula
```
