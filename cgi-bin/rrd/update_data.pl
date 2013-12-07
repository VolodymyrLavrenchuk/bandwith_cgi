#! /opt/csw/bin/perl

system ("/var/rrd/data/hddtemp_data.pl");
system ("/var/rrd/data/traffic_data.pl");
system ("/var/rrd/data/cpu_load_data.pl");
system ("/var/rrd/data/cpu_temp_data.pl");
