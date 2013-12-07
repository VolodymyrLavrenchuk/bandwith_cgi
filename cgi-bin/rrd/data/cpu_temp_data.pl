#! /opt/csw/bin/perl
require '/www/cgi-bin/rrd/common/update_table.pl';

my $temp=`/www/cgi-bin/rrd/common/cpu_temp.sh`;
ProcessTable("cputemp", $temp);

1;