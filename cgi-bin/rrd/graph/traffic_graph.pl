#! /opt/csw/bin/perl
use warnings;

require "/www/cgi-bin/rrd/common/build_graphs.pl";
require "/www/cgi-bin/rrd/common/network_list.pl";

our ($eIfaceName, $eColorIn, $eColorOut);

my @graphs_data = ();
foreach $iface(@ifaces)
{
    my $ifaceName = $iface->[$eIfaceName];
    my $ifaceColorIn = $iface->[$eColorIn];
    my $ifaceColorOut = $iface->[$eColorOut];
    
    push @graphs_data,[$ifaceName,"in",$ifaceColorIn,"$ifaceName in ","%5.1lf"];
    push @graphs_data,[$ifaceName,"out",$ifaceColorOut,"$ifaceName out","%5.1lf"];
}
my @opt = ("-l 0");
BuildGraphs("traffic on Tiera", "traffic", "bytes/sec",\@opt,@graphs_data);

