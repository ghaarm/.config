#!/bin/bash

sketchybar --add event aerospace_workspace_change

WORKSPACES="$(aerospace list-workspaces --all 2>/dev/null)"

# AeroSpace might not be ready yet when the login service starts SketchyBar.
# These are the workspaces referenced by the current AeroSpace config.
if [ -z "$WORKSPACES" ]; then
  WORKSPACES="1 2 3 5 B E G I M P R S T V W X Y Z"
fi

for sid in $WORKSPACES; do
  sketchybar --add item "space.$sid" center \
             --subscribe "space.$sid" aerospace_workspace_change front_app_switched \
             --set "space.$sid" \
                   icon="$sid" \
                   label.font="sketchybar-app-font:Regular:16.0" \
                   label.padding_right=20 \
                   label.y_offset=-1 \
                   script="$PLUGIN_DIR/aerospace.sh $sid" \
                   click_script="aerospace workspace $sid"
done

sketchybar --add item space_separator center \
           --set space_separator icon="󰂊" \
                                 icon.color="$ACCENT_COLOR" \
                                 icon.padding_left=4 \
                                 label.drawing=off \
                                 background.drawing=off

FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused 2>/dev/null)"
if [ -n "$FOCUSED_WORKSPACE" ]; then
  sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE="$FOCUSED_WORKSPACE"
fi
