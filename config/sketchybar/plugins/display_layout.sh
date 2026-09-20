#!/bin/bash

WINDOWSERVER_PLIST="/Library/Preferences/com.apple.windowserver.displays.plist"

# SketchyBar reports a mirrored pair as one logical display. WindowServer's
# active configuration retains both physical displays, so use it first.
DISPLAY_COUNT="$(plutil -extract DisplayAnyUserSets.Configs.0.DisplayConfig json \
  -o - "$WINDOWSERVER_PLIST" 2>/dev/null | jq -r 'length' 2>/dev/null)"

if [ -z "$DISPLAY_COUNT" ]; then
  DISPLAY_COUNT="$(sketchybar --query displays 2>/dev/null \
    | jq -r 'if type == "array" or type == "object" then length else 1 end' 2>/dev/null)"
fi

case "$DISPLAY_COUNT" in
  ''|*[!0-9]*) DISPLAY_COUNT=1 ;;
esac

WORKSPACES="$(aerospace list-workspaces --all 2>/dev/null)"
if [ -z "$WORKSPACES" ]; then
  WORKSPACES="1 2 3 5 B E G I M P R S T V W X Y Z"
fi

NORMAL_SPACES=""
REVERSED_SPACES=""
for sid in $WORKSPACES; do
  NORMAL_SPACES="$NORMAL_SPACES space.$sid"
  REVERSED_SPACES="space.$sid $REVERSED_SPACES"
done

if [ "$DISPLAY_COUNT" -gt 1 ]; then
  # External (also mirrored) display: use the wide layout.
  sketchybar --set '/space\..*/' position=center \
             --set media position=right \
             --reorder battery cpu volume calendar media
  # shellcheck disable=SC2086
  sketchybar --reorder $NORMAL_SPACES
else
  # Built-in display only: keep the center clear for the MacBook notch.
  sketchybar --set '/space\..*/' position=q \
             --set media position=e
  # q grows outwards from the notch, so its internal order must be reversed.
  # shellcheck disable=SC2086
  sketchybar --reorder $REVERSED_SPACES
fi
