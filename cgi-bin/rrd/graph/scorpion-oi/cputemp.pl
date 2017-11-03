#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};

require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = ([basename($cur_dir), "cputemp","cputemp","1","0000FF","","%2.1lf"]);
my @opt = ();

BuildGraphs("CPU temperature :: Intel Xeon X3440 Quad-core", "cputemp", "degrees C", \@opt, @graphs_data);

1;