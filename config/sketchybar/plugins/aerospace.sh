#!/bin/bash

source "$CONFIG_DIR/colors.sh"

SID="$1"
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
WINDOW_COUNT=0

# Bisheriger Code: App-Icons fuer jedes offene Programm erzeugen.
# ICON_STRIP=""
# while IFS= read -r app; do
#   [ -z "$app" ] && continue
#   WINDOW_COUNT=$((WINDOW_COUNT + 1))
#   ICON_STRIP="$ICON_STRIP $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
# done < <(
#   aerospace list-windows --workspace "$SID" --format $'%{app-bundle-id}\t%{app-name}' 2>/dev/null \
#     | awk -F '\t' 'NF { key = ($1 != "" ? $1 : $2); if (!seen[key]++) print $2 }'
# )
#
# if [ -z "$ICON_STRIP" ]; then
#   ICON_STRIP=" —"
# fi

# Neue Darstellung: Fenster nur zaehlen, damit leere Workspaces weiterhin
# ausgeblendet werden. Im Label werden keine Programm-Icons mehr angezeigt.
while IFS= read -r app; do
  [ -z "$app" ] && continue
  WINDOW_COUNT=$((WINDOW_COUNT + 1))
done < <(
  aerospace list-windows --workspace "$SID" --format $'%{app-bundle-id}\t%{app-name}' 2>/dev/null \
    | awk -F '\t' 'NF { key = ($1 != "" ? $1 : $2); if (!seen[key]++) print $2 }'
)

if [ "$SID" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" drawing=on \
                           background.drawing=on \
                           background.color="$ACCENT_COLOR" \
                           label="" \
                           label.color="$BAR_COLOR" \
                           icon.color="$BAR_COLOR"
elif [ "$WINDOW_COUNT" -eq 0 ]; then
  sketchybar --set "$NAME" drawing=off
else
  sketchybar --set "$NAME" drawing=on \
                           background.drawing=off \
                           label="" \
                           label.color="$ACCENT_COLOR" \
                           icon.color="$ACCENT_COLOR"
fi
