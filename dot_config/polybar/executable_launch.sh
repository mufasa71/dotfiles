#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=($(ls --hide="launch.sh" $dir))

launch_bar() {
  # Terminate already running bar instances
  killall -q polybar

  # Wait until the processes have been shut down
  while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

  # Launch the bar
  if [[ "$style" == "hack" || "$style" == "cuts" ]]; then
    polybar -q top -c "$dir/$style/config.ini" &
    polybar -q bottom -c "$dir/$style/config.ini" &
  elif [[ "$style" == "pwidgets" ]]; then
    bash "$dir"/pwidgets/launch.sh --main
  else
    for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR="$monitor" polybar -q main -c "$dir/$style/config.ini" &
    done
  fi
}

style="grayblocks"
launch_bar
