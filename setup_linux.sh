#!/bin/bash

# This script is the file to download which then attempts to do a git pull of the settings installer.
# It should just be runnable.
# It should be downloadable from wget http://linux.newsome.me.uk


# Needs to try a git clone.
# If git fails it needs to notify that git needs installing.

command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }
git clone https://github.com/BenNewsome/setup_linux.git



