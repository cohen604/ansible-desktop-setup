#!/usr/bin/env bash

# Terminate already running picom instances
killall -q picom

picom --experimental-backends --backend xrender &

echo "Picom launched..."
