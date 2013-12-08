#! /opt/csw/bin/perl
use warnings;

require "/www/cgi-bin/rrd/common/build_graphs.pl";
require "/www/cgi-bin/rrd/common/disk_list.pl";

my @graphs_data = ();

for $drive (@drives){
    push @graphs_data,[
        $drive->{name},
        $drive->{name},
        $drive->{color},
        $drive->{sn},
        "%2.lf"];
}

my @opt = ();

BuildGraphs("hdd temperature :: hard disk drives", "hddtemp", "degrees C",\@opt,@graphs_data);




