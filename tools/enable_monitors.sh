#!/bin/bash


# DVI-I-1: Main Monitor
# DVI-D-0: Left Monitor
# HDMI-0: Right-top Monitor
# DP-0: Right-bottom Monitor
xrandr --output DVI-I-1 --mode 2560x1600 --pos 2560x471 \
  --output DVI-D-0 --mode 2560x1440 --pos 0x558 \
  --output HDMI-0 --mode 1600x1200 --pos 5120x0 \
  --output DP-0 --mode 1600x1200 --below HDMI-0
