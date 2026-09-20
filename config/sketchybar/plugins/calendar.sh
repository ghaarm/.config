#!/bin/bash

sketchybar --set "$NAME" label="$(LC_TIME=de_DE.UTF-8 date +'%a %d. %H:%M')"
