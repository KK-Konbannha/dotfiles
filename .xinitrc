#!/bin/sh

[-f /etc/xprofile ] && source /etc/xprofile
[-f ~/.xprofile ] && source ~/.xprofile

exec qtile start
