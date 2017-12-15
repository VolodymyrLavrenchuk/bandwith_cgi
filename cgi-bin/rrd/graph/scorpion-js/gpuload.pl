#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = (
["gpu0","gpuload","1","FF0000","load       ","%3.1lf"],
["gpu0","fanspeed","1","377037","fan speed","%3.1lf"],
["gpu0","memload","1","0000FF","memory load","%3.1lf"]
);

my @opt = ("-l 0");
BuildGraphs(basename($cur_dir), "GPU load :: gpu load, memory load, fan speed", "gpuload", "%%",\@opt,@graphs_data);

1;
