#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};

require "$cur_dir/../../common/build_graphs.pl";

my @graphs_data = (
  ["mb","temperature","1","0000FF"," ","%2.1lf"]
);
my @opt = ();

BuildPeriodsGraphs(basename($cur_dir), "Motherboard temperature :: ASUS P5K", "mbtemp", "degrees C", \@opt, @graphs_data);

1;