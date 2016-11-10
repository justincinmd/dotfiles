#!/bin/bash

# Disables all but the center monitor
xrandr --output DVI-D-0 --off \
  --output DP-0 --off \
  --output HDMI-0 --off
