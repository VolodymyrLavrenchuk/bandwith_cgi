#! /opt/csw/bin/perl
use warnings;

require "/www/cgi-bin/rrd/common/build_graphs.pl";
require "/www/cgi-bin/rrd/common/disk_list.pl";


our ($eDriveName, $eDriveSN, $eDriveColor);

my @graphs_data = ();
foreach $drive(@drives)
{
    my $driveName = $drive->[$eDriveName];
    my $driveSN = $drive->[$eDriveSN];
    my $driveColor = $drive->[$eDriveColor];    
    
    
    push @graphs_data,[$driveName,$driveName,$driveColor,$driveSN,"%2.lf"];
}

my @opt = ();

BuildGraphs("hdd temperature :: hard disk drives", "hddtemp", "degrees C",\@opt,@graphs_data);




