#! /opt/csw/bin/perl
use warnings;
require "build_graphs.pl";

my @graphs_data = (
  ["mb","temperature","1","0000FF"," ","%2.1lf"]
);
my @opt = ();

BuildPeriodsGraphs("Motherboard temperature :: ASUS P5K", "mbtemp", "degrees C", \@opt, @graphs_data);

1;