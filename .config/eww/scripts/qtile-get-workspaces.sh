#!/usr/bin/env bash

tail -f -n1 $HOME/.cache/workspaces | while read -r line; do
    python3 "$(dirname "$0")/qtile-get-workspaces.py"
done
