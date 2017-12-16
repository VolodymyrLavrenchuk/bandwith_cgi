#! /opt/csw/bin/perl
use warnings;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/build_js_graph.pl";

BuildJSGraph("GPU memory load", "%%", "memload", "%3.1lf", ("-l 0"));

1;
