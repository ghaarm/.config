#!/bin/bash

if [ -n "$INFO" ] && echo "$INFO" | jq -e . >/dev/null 2>&1; then
  STATE="$(echo "$INFO" | jq -r '.state // empty')"
  TITLE="$(echo "$INFO" | jq -r '.title // empty')"
  ARTIST="$(echo "$INFO" | jq -r '.artist // empty')"
else
  SPOTIFY_INFO="$(osascript -l JavaScript 2>/dev/null <<'JXA'
const spotify = Application('Spotify');
if (spotify.running()) {
  const track = spotify.currentTrack;
  JSON.stringify({
    state: String(spotify.playerState()),
    title: track.name(),
    artist: track.artist()
  });
}
JXA
)"

  STATE="$(echo "$SPOTIFY_INFO" | jq -r '.state // empty' 2>/dev/null)"
  TITLE="$(echo "$SPOTIFY_INFO" | jq -r '.title // empty' 2>/dev/null)"
  ARTIST="$(echo "$SPOTIFY_INFO" | jq -r '.artist // empty' 2>/dev/null)"
fi

if [ "$STATE" = "playing" ]; then
  sketchybar --set "$NAME" label="$TITLE - $ARTIST" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
