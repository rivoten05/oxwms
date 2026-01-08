#!/bin/env bash

choice=$(printf "  Lock\n󰍃  Logout\n  Reboot\n  Shutdown" | rofi -dmenu)

case "$choice" in
  "  Lock") loginctl lock-session ;;
  "󰍃  Logout") pkill -KILL -u "$USER" ;;
  "  Reboot") systemctl reboot ;;
  "  Shutdown") systemctl poweroff ;;
esac
