#!/bin/bash

#
# Copyright (c) 2009 by dedmajor@gmail.com
#

onKill()
{
	if [ ! -z "$SUBLOG_PID" -a -d /proc/$SUBLOG_PID ]; then
		kill $SUBLOG_PID
	fi
	if [ ! -z "$DUMP_PID" -a -d /proc/$DUMP_PID ]; then
		kill $DUMP_PID
	fi
}

trap 'onKill' EXIT


SUBLOG="$HOME/.mplayer/subtitle_log"
CMD="$HOME/.mplayer/cmd"

MKPIPE="$ rm -i $SUBLOG $CMD; mkfifo $SUBLOG $CMD"

if [ ! -p $CMD ]; then
	echo -e "Pipe $CMD not found. Try using command:\n$MKPIPE"
	exit
fi
if [ ! -p $SUBLOG ]; then
	echo -e "Pipe $SUBLOG not found. Try using command:\n$MKPIPE"
	exit
fi


SUBLOG_CMD="$HOME/bin/subLog.pl"

$SUBLOG_CMD &
sleep 0.1
SUBLOG_PID=$!

if [ -z "$SUBLOG_PID" -o ! -d /proc/$SUBLOG_PID ]; then
	echo "$SUBLOG_CMD failed to start"
	exit
fi


DUMP_CMD="$HOME/bin/subDump.sh"

$DUMP_CMD &
sleep 0.1
DUMP_PID=$!

if [ -z "$DUMP_PID" -o ! -d /proc/$DUMP_PID ]; then
	echo "$DUMP_CMD failed to start"
	exit
fi


ps -p $SUBLOG_PID -p $DUMP_PID

mplayer -input file=$CMD -quiet $*

