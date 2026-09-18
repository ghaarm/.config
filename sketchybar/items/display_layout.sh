#!/bin/bash

# Invisible controller that adapts the layout when displays are connected or
# disconnected. The polling interval is a fallback for mirrored displays,
# which do not always emit a display_change event immediately.
sketchybar --add item display_layout left \
           --set display_layout drawing=off \
                                update_freq=3 \
                                script="$PLUGIN_DIR/display_layout.sh" \
           --subscribe display_layout display_change system_woke
