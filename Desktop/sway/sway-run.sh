#!/usr/bin/env bash

## Custom Wayland varibale exports
##export MOZ_DBUS_REMOTE=1
##export MOZ_ENABLE_WAYLAND=1
##export GDK_BACKEND="wayland"
#export XDG_SESSION_TYPE="wayland"
#export XDG_CURRENT_DESKTOP="KDE"
##export ECORE_EVAS_ENGINE="wayland_egl"
#export ELM_ENGINE="wayland_egl"
#export SDL_VIDEODRIVER="wayland"      
#export _JAVA_AWT_WM_NONREPARENTING=1
#export CLUTTER_BACKEND="wayland"
##nvidia
#export GBM_BACKEND=nvidia-drm
#export __GLX_VENDOR_LIBRARY_NAME=nvidia
#export MOZ_ENABLE_WAYLAND=1
#export WLR_NO_HARDWARE_CURSORS=1
export MOZ_DBUS_REMOTE=1
export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP="sway"
export XDG_SESSION_TYPE="wayland"
systemd-cat --identifier=sway sway
