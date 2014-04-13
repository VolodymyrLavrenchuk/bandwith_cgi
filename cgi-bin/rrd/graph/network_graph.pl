#! /opt/csw/bin/perl
use warnings;
my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../common/build_graphs.pl";
require "$cur_dir/../common/network_list.pl";

our @ports;

my @graphs_data = ();
for $port (@ports){
    if ($port->{color_in})
    {
        push @graphs_data,[$port->{ip_address},"in",$port->{color_in},"$port->{name} in ","%5.1lf"];
    }
    push @graphs_data,[$port->{ip_address},"out",$port->{color_out},"$port->{name} out","%5.1lf"];
}
my @opt = ("-l 0");
BuildGraphs("Local network traffic", "network", "bytes/sec",\@opt,@graphs_data);

1;