#!/usr/bin/perl

use strict;

my $scale = shift || 1.0;

while(<>){
  chomp;
  my ($re, $im, $idx) = split(" ");
  
  my $mag = sqrt(($re * $re) + ($im * $im));
  
  print "$idx => ".int($mag * $scale)."\n";

}
