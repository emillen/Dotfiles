#!/bin/env sh

pkill eww

sleep 1;

eww daemon &

if type "xrandr"; then
    displays=$(xrandr --query | grep " connected"| cut -d" " -f1) 
    item=0
    for display in  $displays; do
        eww update bar${item}-screen="$(echo ${display} | xargs)"
        eww open bar${item} --screen="$display"

        item=$(($item+1))
    done
fi
