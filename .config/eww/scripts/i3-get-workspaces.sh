#!/usr/bin/env bash

i3-msg -t get_workspaces 

i3-msg -m '["workspace"]' -t 'subscribe' | while read -r line; do
    i3-msg -t get_workspaces 
done

