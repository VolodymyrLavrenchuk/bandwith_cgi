#! /opt/csw/bin/perl
use warnings;
require "build_graphs.pl";

my @graphs_data = (
  ["cpu","core0temp","1","0000FF","Core 1","%2.1lf"],
  ["cpu","core1temp","1","00FFFF","Core 2","%2.1lf"],
  ["cpu","core2temp","1","377037","Core 3","%2.1lf"],
  ["cpu","core3temp","1","00FF00","Core 4","%2.1lf"]  
);
my @opt = ();

BuildPeriodsGraphs("CPU temperature :: Intel Xeon X5450 Quad-core", "cputemp", "degrees C", \@opt, @graphs_data);

1;