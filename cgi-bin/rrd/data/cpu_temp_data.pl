#! /opt/csw/bin/perl
my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../common/update_table.pl";

my $temp=`ipmitool -c -I lan -H 192.168.1.112 -f /www/cgi-bin/rrd/common/xeon.psw -U root sdr list | grep "P1 Therm Margin" | awk -F, '{sum = \$2 + 73; printf "%s",sum}'`;

&ProcessTable("cputemp", $temp);

1;