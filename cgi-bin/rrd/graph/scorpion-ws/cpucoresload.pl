#! /opt/csw/bin/perl
use warnings;
use File::Basename;

($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = (
  ["cpu","core0load","1","0000FF","CPU core 1 load","%2.1lf"],
  ["cpu","core1load","1","00FFFF","CPU core 2 load","%2.1lf"],
  ["cpu","core2load","1","377037","CPU core 3 load","%2.1lf"],
  ["cpu","core3load","1","00FF00","CPU core 4 load","%2.1lf"]
);
my @opt = ("-l 0");

BuildPeriodsGraphs(basename($cur_dir),"Average CPU usage :: Intel Xeon X5450 Quad-core", "cpucoresload", "%%", \@opt, @graphs_data);

1;