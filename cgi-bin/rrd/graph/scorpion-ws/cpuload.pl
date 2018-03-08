#! /opt/csw/bin/perl
use warnings;

require "build_graphs.pl";

my @graphs_data = (["cpu","cpuload","1","0000FF","","%2.1lf"]);
my @opt = ("-l 0");

BuildPeriodsGraphs("Average CPU usage :: Intel Xeon X5450 Quad-core", "cpuload", "%%", \@opt, @graphs_data);

1;