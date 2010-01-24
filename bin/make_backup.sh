#!/bin/bash

rm -rf ~/backup/home/snapshot.2
mv -f ~/backup/home/snapshot.1 ~/backup/home/snapshot.2
mv -f ~/backup/home/snapshot.0 ~/backup/home/snapshot.1
rsync -aRv --delete --link-dest=../../../backup/home/snapshot.1 \
	~/devel/ ~/keys/ ~/.ssh/ \
	~/logs/ ~/.kde4/share/apps/kopete/logs/ \
	~/.climm/ ~/.purple/ \
	~/backup/home/snapshot.0
