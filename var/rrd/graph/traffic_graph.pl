#! /opt/csw/bin/perl
use warnings;

use RRDs;

# define location of rrdtool databases
my $rrd = '/var/lib/rrd';

# define location of images
my $img = '/www/rrd';

my $iface = 'e1000g1';
my $provider = 'Tiera';

	# create traffic graphs
	&CreateGraph($iface, "day", $provider);
	&CreateGraph($iface, "week", $provider);
	&CreateGraph($iface, "month", $provider); 
	&CreateGraph($iface, "year", $provider);
    
sub CreateGraph
{
# creates graph
# inputs: $_[0]: interface name (ie, eth0/eth1/eth2/ppp0)
#	  $_[1]: interval (ie, day, week, month, year)
#	  $_[2]: interface description 

	RRDs::graph "$img/traffic-$_[1].png",
		"-s -1$_[1]",
		"-t traffic on $_[0] :: $_[2]",
		"--lazy",
		"-h", "80", "-w", "600",
		"-l 0",
		"-a", "PNG",
		"-v bytes/sec",
		"DEF:in=$rrd/$_[0].rrd:in:AVERAGE",
		"DEF:out=$rrd/$_[0].rrd:out:AVERAGE",
		"LINE2:in#336600:Traffic in ",
		"GPRINT:in:MAX: Max\\: %5.1lf %s",
		"GPRINT:in:AVERAGE: Avg\\: %5.1lf %S",
		"GPRINT:in:LAST: Current\\: %5.1lf %Sbytes/sec\\n",
		"LINE2:out#0033CC:Traffic out",
		"GPRINT:out:MAX: Max\\: %5.1lf %s",
		"GPRINT:out:AVERAGE: Avg\\: %5.1lf %S",
		"GPRINT:out:LAST: Current\\: %5.1lf %Sbytes/sec\\n",
        "HRULE:0#000000";
	if ($ERROR = RRDs::error) { print "$0: unable to generate $_[0] $_[1] traffic graph: $ERROR\n"; }
}
