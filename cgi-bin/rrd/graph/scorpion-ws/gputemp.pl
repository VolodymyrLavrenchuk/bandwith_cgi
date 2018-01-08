#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_gpu_graphs.pl";

BuildGPUGraphs(basename($cur_dir), "GPU temperature :: MSI GeForce GTX 1060", "degrees C", "gputemp", "%2.1lf", ());

1;