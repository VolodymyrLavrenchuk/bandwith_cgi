#! /opt/csw/bin/perl
use warnings;
use File::Basename;

($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = (["cpu","cpuload","1","0000FF","","%2.1lf"]);
my @opt = ("-l 0");

BuildPeriodsGraphs(basename($cur_dir),"Average CPU usage :: Intel Xeon X5450 Quad-core", "cpuload", "%%", \@opt, @graphs_data);

1;