#!/usr/bin/perl

# Orginal of this script is here:
# http://en.gentoo-wiki.com/wiki/Converting_mp3_audio_books_to_m4b

use File::Basename;
my @m3u;
my @files;
my $f;
my $count = 1;
my $discs;
opendir(DIR, $ARGV[0]) or die("Can't open \"$ARGV[0]\"!\n");
@files = readdir(DIR);
closedir(DIR);
$path = $ARGV[0];
foreach $f ( @files ) {
	if ( ! -d $f ) {
		if ( ($f =~ m/^.*\.m3u$/) && ! ( $f =~ m/^0000.*$/) ) {
			push(@m3u, $f);
		}

	}
}
@m3u = sort(@m3u);
$discs = @m3u;
print "Found $discs m3u files.\n";
foreach $m ( @m3u ) {
	my @data;
	$file = $m;
	$file =~ s/^(.*)\..*/\1/;
	$outfile = $file.".m4b";
	open ID3, "<$ARGV[0]/$m" or die("File \"$ARGV[0]/$m\" not found!\n");
	while ( <ID3> ) {
		push (@data,$_);
	}
	close(ID3);
	if ( -f tmpfile ) {
		print "tmpfile found.. Deleteing\n";
		unlink(tmpfile);
	}
	open(TMPFILE, ">tmpfile");
	foreach $line (@data) {
		if ( $line =~ m/^#.*/ ) {
		} else {
			if ( $line !=~ m/.*\.rar.*/ ) {
				print TMPFILE "$path/$line";
			}
		}
	}
	close(TMPFILE);
	my $id3 = `head -1 tmpfile`;
	print "Getting id3-data from $id3\n";
	@id3 = `id3v2 --list $id3`;
	foreach $line (@id3) {
		if ( $line =~ m/^TALB.*/ ) {
			$TITLE = $line;
			$TITLE =~ s/^.*: (.*)\n$/\1/;
		}
		if ( $line =~ m/^TPE1.*/ ) {
			$AUTH = $line;
			$AUTH =~ s/^.*: (.*)\n$/\1/;
		}
	}
	print "Got:\n";
	print "Title:  $TITLE\n";
	print "Author: $AUTH\n";
	print "Output: $outfile\n";
	print "Converting..\n";
	system ("mpg321 -@ tmpfile -q -w - | faac -w --disc \"$count/$discs\" --track \"1/1\" --artist \"$AUTH\" \ "
			"--title \"$TITLE\" --album \"$TITLE\" --writer  \"$AUTH\" --genre \"Audiobook\" -o \"$file.m4b\" - ");

	$count++;
}
print "Done, I think.. Have a nice day!\n";
