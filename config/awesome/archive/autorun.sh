#!/usr/bin/env bash

function run {
    if ! pgrep $1 ; then
        $@&
    fi
}

if xrandr | grep -q 'DisplayPort-2 connected 3440x1440+0+0' ; then
    xrandr --output DisplayPort-2 --mode 3440x1440 --rate 100
fi
