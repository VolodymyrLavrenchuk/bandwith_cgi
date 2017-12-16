#! /opt/csw/bin/perl
use warnings;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/build_js_graph.pl";

BuildJSGraph("GPU temperature", "degrees C", "gputemp", "%2.1lf", ());

1;