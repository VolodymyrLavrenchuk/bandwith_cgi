#! /opt/csw/bin/perl
use POSIX;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};

require "$cur_dir/../common/update_table.pl";
require "$cur_dir/../common/cpu_load.pl";
our $cpu_used;
&ProcessTable("cpuload",ceil($cpu_used));

1;