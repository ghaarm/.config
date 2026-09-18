#!/bin/bash

sketchybar --add item volume right \
           --set volume background.color="$ACCENT_COLOR" \
                        icon.color="$BAR_COLOR" \
                        label.color="$BAR_COLOR" \
                        script="$PLUGIN_DIR/volume.sh" \
           --subscribe volume volume_change 
