#! /opt/csw/bin/perl
use POSIX;
require '/www/cgi-bin/rrd/common/update_table.pl';
require '/www/cgi-bin/rrd/common/cpu_load.pl';
our $cpu_used;

ProcessTable("cpuload",ceil($cpu_used));

