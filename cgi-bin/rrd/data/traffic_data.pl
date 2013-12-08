#! /opt/csw/bin/perl
use warnings;

use RRDs;

# define location of rrdtool databases
my $rrd = '/var/lib/rrd';

# process data for each interface (add/delete as required)
require "/www/cgi-bin/rrd/common/network_list.pl";

for $iface(@ifaces){
    &ProcessInterface($iface->{name}, $iface->{number});
}

sub ProcessInterface
{
# process interface
# inputs: $_[0]: interface name (ie, eth0/eth1/eth2/ppp0)
#	  $_[1]: interface description 

	# get network interface info
	my $in = `snmpget -v 1 -c public -Oqv localhost IF-MIB::ifInOctets.$_[1]`;
	my $out = `snmpget -v 1 -c public -Oqv localhost IF-MIB::ifOutOctets.$_[1]`;

	# remove eol chars
	chomp($in);
	chomp($out);

	print "$_[0] traffic in, out: $in, $out\n";

	# if rrdtool database doesn't exist, create it
	if (! -e "$rrd/$_[0].rrd")
	{
		print "creating rrd database for $_[0] interface...\n";
		RRDs::create "$rrd/$_[0].rrd",
			"-s 300",
			"DS:in:DERIVE:600:0:12500000",
			"DS:out:DERIVE:600:0:12500000",
			"RRA:AVERAGE:0.5:1:576",
			"RRA:AVERAGE:0.5:6:672",
			"RRA:AVERAGE:0.5:24:732",
			"RRA:AVERAGE:0.5:144:1460";
	}

	# insert values into rrd
	RRDs::update "$rrd/$_[0].rrd",
		"-t", "in:out",
		"N:$in:$out";
}

1;
