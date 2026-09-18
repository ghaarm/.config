#!/bin/bash

sketchybar --add item battery right \
           --set battery update_freq=120 \
                         background.color="$ACCENT_COLOR" \
                         icon.color="$BAR_COLOR" \
                         label.color="$BAR_COLOR" \
                         script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change
