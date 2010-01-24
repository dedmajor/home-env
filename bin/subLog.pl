#!/usr/bin/perl

#
# Copyright (c) 2009 by dedmajor@gmail.com
#


use strict;
use warnings;


my $SUBLOG = glob('~/.mplayer/subtitle_log');

die "Pipe $SUBLOG not found." unless (-p $SUBLOG);


open LOG, "+< $SUBLOG";

my $printing = 0;
my $prevLog = '';

while (<LOG>) {
	next if (/^---/);
	if (/^N: /) {
		if ($prevLog ne $_) {
			$printing = 1;
		} else {
			$printing = 0;
		}
		$prevLog = $_;
		next;
	}
	if ($printing) {
		print;
	}
	sleep(0.2);
}

close LOG;

