#!/usr/bin/perl
use strict;

while(<>){
	chomp;
	$a = unpack("c", pack("B*", $_));
	print "$a\n";
}
