#! /opt/csw/bin/perl
use warnings;
my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../common/build_graphs.pl";
require "$cur_dir/../common/traffic_list.pl";

our @ifaces;

my @graphs_data = ();
for $iface (@ifaces){
    push @graphs_data,[$iface->{name},"in",$iface->{color_in},"$iface->{name} in ","%5.1lf"];
    push @graphs_data,[$iface->{name},"out",$iface->{color_out},"$iface->{name} out","%5.1lf"];
}
my @opt = ("-l 0");
BuildGraphs("traffic on Tiera", "traffic", "bytes/sec",\@opt,@graphs_data);

1;