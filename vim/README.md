# vim

## Install

```shell
$ sudo apt install vim-gtk
```

### Plugins

#### asyncrun
```shell
$ git clone https://github.com/skywind3000/asyncrun.vim.git ~/.vim/pack/plugins/start/asyncrun
```

#### [coc](https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#using-vim8s-native-package-manager)
```shell 
$ mkdir -p ~/.vim/pack/coc/start
$ cd ~/.vim/pack/coc/start
$ git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1
$ vim -c "helptags coc.nvim/doc/ | q"
```

#### colorizer
```shell
$ git clone https://github.com/chrisbra/Colorizer.git ~/.vim/pack/start/Colorizer
$ vim ~/.vim/pack/plugins/start/Colorizer/Colorizer.vmb -c ":so %"
```
#### commentary
```shell
$ mkdir -p ~/.vim/pack/tpope/start
$ cd ~/.vim/pack/tpope/start
$ git clone https://tpope.io/vim/commentary.git
$ vim -u NONE -c "helptags commentary/doc" -c q
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
#### sprint
```shell
$ git clone https://github.com/pedsm/sprint.git ~/.vim/pack/plugins/start/sprint
```
#### vifm
```shell
$ git clone https://github.com/vifm/vifm.vim.git ~/.vim/pack/plugins/start/vifm
```

### Theme

Within 'dotfiles/vim/vimrc', under 'Themes' comment out the desired theme.

#### Dracula

```shell
$ mkdir -p ~/.vim/pack/themes/start

$ git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula
```

#### Catppuccin

Make sure to initialize 'catppuccin' submodule:

```shell
$ git submodule update --recursive --init
```

