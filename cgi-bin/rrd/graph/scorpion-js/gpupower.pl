#! /opt/csw/bin/perl
use warnings;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/build_js_graph.pl";

BuildJSGraph("GPU power usage", "Watts", "gpupower", "%2.1lf", ("-l 0"));

1;
