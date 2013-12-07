#! /opt/csw/bin/perl
use warnings;

require "/www/cgi-bin/rrd/common/build_graphs.pl";

my @graphs_data = (["cputemp","cputemp","0000FF","","%2.1lf"]);
my @opt = ();

BuildGraphs("CPU temperature :: Intel Xeon X3440 Quad-core", "cputemp", "degrees C", \@opt, @graphs_data);