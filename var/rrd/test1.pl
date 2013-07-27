#! /opt/csw/bin/perl

use RRDs;
use warnings;

my $rrd = '/var/lib/rrd/cputemp.rrd';


print RRDs::dump $rrd;

