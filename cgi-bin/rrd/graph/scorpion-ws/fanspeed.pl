#! /opt/csw/bin/perl
use warnings;
use File::Basename;

($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = ([basename($cur_dir), "fanspeed","fanspeed","1","0000FF","","%2.1lf"]);
my @opt = ("-l 0");

BuildGraphs("GPU fan speed :: MSI GeForce GTX 1060", "fanspeed", "%%", \@opt, @graphs_data);

1;