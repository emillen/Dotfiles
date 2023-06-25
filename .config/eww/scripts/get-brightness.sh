#!/usr/bin/env bash

MAX=$(brightnessctl m)
CURRENT=$(brightnessctl g)

echo "$CURRENT / $MAX * 100" | bc -l | sed -e "s/\..*//g"

