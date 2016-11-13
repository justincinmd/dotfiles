#!/bin/bash

# Disables all but the center monitor
xrandr --output DP-4 --off \
  --output HDMI-0 --off \
  --output DP-1 --off
