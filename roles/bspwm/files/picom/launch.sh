#!/usr/bin/env bash

# Terminate already running picom instances
killall -q picom

echo "---" | tee -a /tmp/picom.log
picom --experimental-backends --backend xrender 2>&1 | tee -a /tmp/picom.log &
disown

echo "Picom launched..."
