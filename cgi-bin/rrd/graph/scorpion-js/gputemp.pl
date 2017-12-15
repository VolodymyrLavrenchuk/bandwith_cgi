#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";

my @gpu_colors = ("A8907A", "F8D9AF", "CC00CC", "00FF00", "0000FF", "00FFFF");

my @graphs_data = ();

for my $index (0 .. $#gpu_colors) {
  push @graphs_data,["gpu$index","gputemp","1",$gpu_colors[$index],"GPU$index","%2.1lf"]
}

my @opt = ();

BuildGraphs(basename($cur_dir), "GPU temperature :: Palit JetStream GeForce GTX 1070ti", "gputemp", "degrees C", \@opt, @graphs_data);

1;