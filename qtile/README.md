# Qtile

## Install
Follow instructions from http://docs.qtile.org/en/latest/manual/install/

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