#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};

require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = (["cputemp","cputemp","1","0000FF","","%2.1lf"]);
my @opt = ();

BuildPeriodsGraphs(basename($cur_dir), "CPU temperature :: Intel Xeon X3440 Quad-core", "cputemp", "degrees C", \@opt, @graphs_data);

1;