#!/bin/bash

#
# Copyright (c) 2009 by dedmajor@gmail.com
#


CMD="$HOME/.mplayer/cmd"

if [ ! -p $CMD ]; then
	echo -e "Pipe $CMD not found."
	exit 1
fi

while true; do
	echo pausing_keep_force sub_log > $CMD
	sleep 0.2
done
