#!/bin/sh

# Custom Wayland varibale exports
export MOZ_DBUS_REMOTE=1
export MOZ_ENABLE_WAYLAND=1
#export GDK_BACKEND="wayland"
export XDG_SESSION_TYPE="wayland"
export XDG_CURRENT_DESKTOP="Unity"
export ECORE_EVAS_ENGINE="wayland_egl"
export ELM_ENGINE="wayland_egl"
export SDL_VIDEODRIVER="wayland"      
export _JAVA_AWT_WM_NONREPARENTING=1
export CLUTTER_BACKEND="wayland"

#systemd-cat --identifier=sway sway
dbus-run-session sway
