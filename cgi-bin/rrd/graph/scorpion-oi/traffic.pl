#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";
require "$cur_dir/../../common/traffic_list.pl";

our @ifaces;

my @graphs_data = ();
for $iface (@ifaces){
    push @graphs_data,[basename($cur_dir),$iface->{name},"in","1",$iface->{color_in},"$iface->{name} in ","%5.1lf"];
    push @graphs_data,[basename($cur_dir),$iface->{name},"out","1",$iface->{color_out},"$iface->{name} out","%5.1lf"];
}
my @opt = ("-l 0");
BuildGraphs("traffic on Tiera", "traffic", "bytes/sec",\@opt,@graphs_data);

1;