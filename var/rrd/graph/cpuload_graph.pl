#! /opt/csw/bin/perl
use warnings;

use RRDs;

# define location of rrdtool databases
my $rrd = '/var/lib/rrd';

# define location of images
my $img = '/www/rrd';

my $iface = 'cpuload';

	# create traffic graphs
	&CreateGraph($iface, "day");
	&CreateGraph($iface, "week");
	&CreateGraph($iface, "month");
	&CreateGraph($iface, "year");
    
sub CreateGraph
{
	RRDs::graph "$img/cpuload-$_[1].png",
		"-s -1$_[1]",
		"-t Average CPU usage :: Intel Xeon X3440 Quad-core",
		"--lazy",
		"-h", "80", "-w", "600",
		"-a", "PNG",
		"-v %",
		"DEF:cpuload=$rrd/$_[0].rrd:cpuload:AVERAGE",
		"LINE2:cpuload#0000FF",
		"GPRINT:cpuload:MIN: Min\\: %2.1lf ",        
		"GPRINT:cpuload:MAX: Max\\: %2.1lf ",
		"GPRINT:cpuload:AVERAGE: Avg\\: %4.1lf",
		"GPRINT:cpuload:LAST: Current\\: %2.1lf %%\\n",
        "HRULE:0#000000";
	if ($ERROR = RRDs::error) { print "$0: unable to generate $_[0] $_[1] graph: $ERROR\n"; }
}