#!/bin/bash

source "$CONFIG_DIR/colors.sh"

SID="$1"
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
ICON_STRIP=""
WINDOW_COUNT=0

while IFS= read -r app; do
  [ -z "$app" ] && continue
  WINDOW_COUNT=$((WINDOW_COUNT + 1))
  ICON_STRIP="$ICON_STRIP $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
done < <(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null)

if [ -z "$ICON_STRIP" ]; then
  ICON_STRIP=" —"
fi

if [ "$SID" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" drawing=on \
                           background.drawing=on \
                           background.color="$ACCENT_COLOR" \
                           label="$ICON_STRIP" \
                           label.color="$BAR_COLOR" \
                           icon.color="$BAR_COLOR"
elif [ "$WINDOW_COUNT" -eq 0 ]; then
  sketchybar --set "$NAME" drawing=off
else
  sketchybar --set "$NAME" drawing=on \
                           background.drawing=off \
                           label="$ICON_STRIP" \
                           label.color="$ACCENT_COLOR" \
                           icon.color="$ACCENT_COLOR"
fi
