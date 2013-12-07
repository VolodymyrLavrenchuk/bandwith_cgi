#! /opt/csw/bin/perl

use RRDs;
use warnings;

my $rrd = '/var/lib/rrd/cpuload.rrd';


print RRDs::dump $rrd;

