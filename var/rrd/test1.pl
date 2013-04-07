#! /opt/csw/bin/perl

use RRDs;

my $rrd = '/var/lib/rrd/e1000g1.rrd';


print RRDs::dump $rrd;