#!/bin/bash


# DVI-D-0: Main Monitor
# DP-4: Left Monitor
# HDMI-0: Right-top Monitor
# DP-1: Right-bottom Monitor
xrandr --output DVI-D-0 --mode 2560x1600 --pos 2560x471 \
  --output DP-4 --mode 2560x1440 --pos 0x558 \
  --output HDMI-0 --mode 1600x1200 --pos 5120x0 \
  --output DP-1 --mode 1600x1200 --below HDMI-0
