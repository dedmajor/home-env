#!/bin/sh

HOST=`cat .auth | grep ^cruc | cut -d ' ' -f 4`;

if [ -z "$HOST" ]; then
	exit 1;
fi

FILE=$1

if [ -z "$FILE" ]; then
	exit 1;
fi

REV=`grep "$HOST/changelog/" $FILE | grep -o 'cs=[0-9]\+' | cut -d= -f2`

{ sed -n "1,/\/changelog\//p" $FILE; ~/bin/crucDiff.sh $REV; sed -n "/\/changelog\//,\$p" $FILE; } | vimpager +set\ ft=mail -

