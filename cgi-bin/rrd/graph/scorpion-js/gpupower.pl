#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = (["gpu0","gpupower","1","0000FF","","%2.1lf"]);
my @opt = ("-l 0");

BuildGraphs(basename($cur_dir), "GPU power usage :: Palit JetStream GeForce GTX 1070ti", "gpupower", "Watts", \@opt, @graphs_data);

1;
