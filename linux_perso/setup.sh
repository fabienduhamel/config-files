#!/bin/bash

# Steam audio output switch issue with PulseAudio (remove DONT_MOVE flag for PulseAudio Steam sinks)
# see http://steamcommunity.com/app/93200/discussions/0/864959809826195633/?l=french
echo "[pulse]\nallow-moves=yes" > ~/.alsoftrc
