#!/usr/bin/perl

#
# Copyright (c) 2009 by dedmajor@gmail.com
#


$XCLIP = '/usr/bin/xclip';
$DICT = '/usr/bin/dict';

$prevClip = null;
while (1) {
	$clip = `$XCLIP -o`;
	chomp($clip);
	if ($clip ne $prevClip && $clip =~ /^[\w-]+$/i) {
		print "-------------\n";
		system("$DICT '$clip'");
		print "\n"x3;
	};
	$prevClip = $clip;
	sleep(0.2);
}
