# vim

## Install

```shell
$ sudo apt install vim-gtk
```

### Plugins

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

$ cd ~/.vim/pack/themes/start

$ git clone https://github.com/dracula/vim.git dracula
```
