#! /opt/csw/bin/perl
use warnings;

require '/www/cgi-bin/rrd/common/update_table.pl';
require "/www/cgi-bin/rrd/common/disk_list.pl";

my $iDrive  = 0;
our ($eDriveName, $eDriveSN, $eDriveColor);

for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
{
    my $driveName = $drives[$iDrive][$eDriveName];
    my $driveSN = $drives[$iDrive][$eDriveSN];
    &ProcessHDD($driveName, $driveSN);
}

sub ProcessHDD
{
	# get hdd temp for master drive on secondary IDE channel
	my $temp=`/www/cgi-bin/hdd-temp $_[0]d0s0`;
	# remove eol chars and white space
	$temp =~ s/[\n ]//g;
	
	&ProcessTable($_[0],$temp);
}

1;