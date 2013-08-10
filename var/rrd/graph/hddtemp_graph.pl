#! /opt/csw/bin/perl
use warnings;

require "/var/rrd/common/build_graphs.pl";
# process data for each specified HDD (add/delete as required)
require "/var/rrd/common/disk_list.pl";


our ($eDriveName, $eDriveSN, $eDriveColor);

my @graphs_data = ();
foreach $drive(@drives)
{
    my $driveName = $drive->[$eDriveName];
    my $driveSN = $drive->[$eDriveSN];
    my $driveColor = $drive->[$eDriveColor];    
    
    
    push @graphs_data,[$driveName,"temp",$driveColor,$driveSN,"%2.lf"];
}

my @opt = ();

BuildGraphs("hdd temperature :: hard disk drives", "hddtemp", "degrees C",\@opt,@graphs_data);




