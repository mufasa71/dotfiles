#!/usr/bin/env bash

current_wid=$(xdo id)
selection=$(rofi -i -dmenu $@ < $(dirname $0)/deutsch.txt)
deutsch=$(echo $selection | sed "s|$(echo -e "\ufeff").*||")
echo -n "$deutsch" | xclip -selection clipboard
xdotool key --window $current_wid --clearmodifiers ctrl+v
