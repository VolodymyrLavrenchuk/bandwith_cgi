#! /opt/csw/bin/perl

system ("/www/cgi-bin/rrd/data/hddtemp_data.pl");
system ("/www/cgi-bin/rrd/data/traffic_data.pl");
system ("/www/cgi-bin/rrd/data/cpu_load_data.pl");
system ("/www/cgi-bin/rrd/data/cpu_temp_data.pl");
