#! /opt/csw/bin/perl
use warnings;

use RRDs;
use POSIX;

# define location of rrdtool databases
my $rrd = '/var/lib/rrd';

require '/var/rrd/common/cpu_load.pl';
our $cpu_used;

&ProcessCPU("cpuload",ceil($cpu_used));

sub ProcessCPU
{
# process CPU


	# if rrdtool database doesn't exist, create it
	if (! -e "$rrd/$_[0].rrd")
	{
		print "creating rrd database for /var/lib/$_[0]...\n";
		RRDs::create "$rrd/$_[0].rrd",
			"-s 300",
			"DS:$_[0]:GAUGE:600:0:100",
			"RRA:AVERAGE:0.5:1:576",
			"RRA:AVERAGE:0.5:6:672",
			"RRA:AVERAGE:0.5:24:732",
			"RRA:AVERAGE:0.5:144:1460";
	}

	# insert value into rrd
	RRDs::update "$rrd/$_[0].rrd",
		"-t", "$_[0]",
		"N:$_[1]";
	
}