#!/bin/bash
kill -n 9 $(xdotool getwindowpid $(xdotool getactivewindow))
