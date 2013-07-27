#! /opt/csw/bin/perl
require '/var/rrd/common/update_table.pl';

my $temp=`/var/rrd/common/cpu_temp.sh`;
ProcessTable("cputemp", $temp);
