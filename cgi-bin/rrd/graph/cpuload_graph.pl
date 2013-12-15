#! /opt/csw/bin/perl
use warnings;
($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../common/build_graphs.pl";

my @graphs_data = (["cpuload","cpuload","0000FF","","%2.1lf"]);
my @opt = ("-l 0");

BuildGraphs("Average CPU usage :: Intel Xeon X3440 Quad-core", "cpuload", "%%", \@opt, @graphs_data);

1;