#! /opt/csw/bin/perl
do "disk_list.pl";

my $iDrive  = 0;

for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
{
    my $driveName = $drives[$iDrive][$eDriveName];
    my $driveSN = $drives[$iDrive][$eDriveSN];
    my $driveColor = $drives[$iDrive][$eDriveColor];
    
    print "$driveName, $driveSN, $driveColor\n";
}
