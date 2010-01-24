#!/bin/sh

USERNAME=`cat .auth | grep ^cruc | cut -d ' ' -f 2`;
PASSWORD=`cat .auth | grep ^cruc | cut -d ' ' -f 3`;
HOST=`cat .auth | grep ^cruc | cut -d ' ' -f 4`;

if [ -z "$USERNAME" -o -z "$PASSWORD" -o -z "$HOST" ]; then
	exit 1;
fi

REV=$1

if [ -z "$REV" ]; then
	exit 1;
fi

TMP=`mktemp`

POST="rememberme=yes&username=$USERNAME&password=$PASSWORD"
wget --quiet --save-cookies $TMP --keep-session-cookie --post-data="$POST" $HOST/login -O /dev/null
# todo: extract project name
wget --quiet --load-cookies $TMP "$HOST/rdiff/visor?csid=$REV&u&N" -O -

rm $TMP
