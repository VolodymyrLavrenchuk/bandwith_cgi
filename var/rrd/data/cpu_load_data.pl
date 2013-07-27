#! /opt/csw/bin/perl
use POSIX;
require '/var/rrd/common/update_table.pl';
require '/var/rrd/common/cpu_load.pl';
our $cpu_used;

ProcessTable("cpuload",ceil($cpu_used));

