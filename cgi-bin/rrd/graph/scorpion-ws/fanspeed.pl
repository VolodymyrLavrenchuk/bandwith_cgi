#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};

require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = (
  ["cpu","cpufanspeed","1","0000FF","CPU fan","%2.1lf"]
);
my @opt = ();

BuildPeriodsGraphs(basename($cur_dir), "Rotation per minute fan speed", "fanspeed", "RPM", \@opt, @graphs_data);

1;