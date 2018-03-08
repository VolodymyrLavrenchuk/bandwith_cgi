#! /opt/csw/bin/perl
use warnings;
require "build_graphs.pl";

my @graphs_data = (
["gpu0","gpuload","1","FF0000","load       ","%3.1lf"],
["gpu0","fanspeed","1","377037","fan speed","%3.1lf"],
["gpu0","memload","1","0000FF","memory load","%3.1lf"]
);

my @opt = ("-l 0");
BuildPeriodsGraphs("GPU load :: gpu load, memory load, fan speed", "gpuload", "%%",\@opt,@graphs_data);

1;
