#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_gpu_graphs.pl";

BuildGPUGraphs(basename($cur_dir), "GPU load :: Palit JetStream GeForce GTX 1070Ti", "%%", "gpuload", "%3.1lf", ("-l 0"));

1;
