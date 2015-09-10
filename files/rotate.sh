#!/bin/bash
#
# Script to iterate through video outputs and rotates each .

declare -a VOUTS
# Get a list of all video outputs.
VOUTS=$(xrandr|awk 'BEGIN {} /^\S.* connected/{printf("%s,", $1)} END{}')

# For each video output, 
IFS="," read -ra VOUT <<< "$VOUTS"
for i in "${VOUT[@]}"; do
  if [ ! $hadfirst ]; then
    xrandr --output $i --rotate left
    hadfirst=1
  else
    xrandr --output $i --rotate right
  fi
done
#if [ "${2}" == 'connected' ]


#xrandr --output DVI-I-1 --rotate left --output DVI-I-2 --rotate right
