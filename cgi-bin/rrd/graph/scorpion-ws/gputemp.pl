#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = (["gpu","gputemp","1","0000FF","","%2.1lf"]);
my @opt = ();

BuildGraphs(basename($cur_dir),"GPU temperature :: MSI GeForce GTX 1060", "gputemp", "degrees C", \@opt, @graphs_data);

1;