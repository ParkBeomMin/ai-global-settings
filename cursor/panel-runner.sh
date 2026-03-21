#!/bin/bash

while true; do
  output=$(bash ~/.cursor/panel.sh 2>/dev/null)
  printf '\033[2J\033[3J\033[H'
  printf '%s\n' "$output"
  sleep 5
done
