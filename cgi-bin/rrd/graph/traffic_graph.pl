#! /opt/csw/bin/perl
use warnings;

require "/www/cgi-bin/rrd/common/build_graphs.pl";
require "/www/cgi-bin/rrd/common/network_list.pl";

my @graphs_data = ();
for $iface (@ifaces){
    push @graphs_data,[$iface->{name},"in",$iface->{color_in},"$ifaceName in ","%5.1lf"];
    push @graphs_data,[$iface->{name},"out",$iface->{color_out},"$ifaceName out","%5.1lf"];
}
my @opt = ("-l 0");
BuildGraphs("traffic on Tiera", "traffic", "bytes/sec",\@opt,@graphs_data);

