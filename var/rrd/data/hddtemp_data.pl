#! /opt/csw/bin/perl

use RRDs;

# define location of rrdtool databases
my $rrd = '/var/lib/rrd';

# process data for each specified HDD (add/delete as required)
require "/var/rrd/common/disk_list.pl";

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
# process HDD
# inputs: $_[0]: hdd (ie, hda, etc)
#         $_[1]: hdd description

	# get hdd temp for master drive on secondary IDE channel
	my $temp=`/root/bin/hdd-temp $_[0]`;
	# remove eol chars and white space
	$temp =~ s/[\n ]//g;
	
	print "$_[1] (/dev/rdsk/$_[0]) temp: $temp degrees C\n";

	# if rrdtool database doesn't exist, create it
	if (! -e "$rrd/$_[0].rrd")
	{
		print "creating rrd database for /dev/rdsk/$_[0]...\n";
		RRDs::create "$rrd/$_[0].rrd",
			"-s 300",
			"DS:temp:GAUGE:600:0:100",
			"RRA:AVERAGE:0.5:1:576",
			"RRA:AVERAGE:0.5:6:672",
			"RRA:AVERAGE:0.5:24:732",
			"RRA:AVERAGE:0.5:144:1460";
	}

	# insert value into rrd
	RRDs::update "$rrd/$_[0].rrd",
		"-t", "temp",
		"N:$temp";
	
}