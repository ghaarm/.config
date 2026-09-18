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

if [ "$DISPLAY_COUNT" -gt 1 ]; then
  # External (also mirrored) display: use the wide layout.
  sketchybar --set '/space\..*/' position=center \
             --set media position=right \
             --reorder battery cpu volume calendar media
else
  # Built-in display only: keep the center clear for the MacBook notch.
  sketchybar --set '/space\..*/' position=q \
             --set media position=e
fi
