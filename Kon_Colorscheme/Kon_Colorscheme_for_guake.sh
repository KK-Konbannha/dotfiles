#!/bin/bash 

# Save this script into set_colors.sh, make this file executable and run it: 
# 
# $ chmod +x set_colors.sh 
# $ ./set_colors.sh 
# 
# Alternatively copy lines below directly into your shell. 

gconftool-2 -s -t string /apps/guake/style/background/color '#000000000000'
gconftool-2 -s -t string /apps/guake/style/font/color '#ffffffffffff'
gconftool-2 -s -t string /apps/guake/style/font/palette '#606060606060:#888888888888:#ffff71716a6a:#ffff92928c8c:#6a6affff7171:#8c8cffff9292:#f7f7ffff6a6a:#fafaffff8c8c:#71716a6affff:#92928c8cffff:#ffff6a6af7f7:#ffff8c8cfafa:#6a6af7f7ffff:#8c8cfafaffff:#e9e9e9e9e9e9:#ffffffffffff'
