#!/bin/bash 

# Save this script into set_colors.sh, make this file executable and run it: 
# 
# $ chmod +x set_colors.sh 
# $ ./set_colors.sh 
# 
# Alternatively copy lines below directly into your shell. 

gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_theme_background --type bool false 
gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_theme_colors --type bool false 
gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/background_color '#000000000000'
gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/foreground_color '#ffffffffffff'
gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/palette '#606060606060:#ffff71716a6a:#6a6affff7171:#f7f7ffff6a6a:#71716a6affff:#ffff6a6af7f7:#6a6af7f7ffff:#e9e9e9e9e9e9:#888888888888:#ffff92928c8c:#8c8cffff9292:#fafaffff8c8c:#92928c8cffff:#ffff8c8cfafa:#8c8cfafaffff:#ffffffffffff'
