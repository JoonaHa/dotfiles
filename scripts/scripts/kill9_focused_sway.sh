#!/bin/bash
kill -n 9 $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).pid')
