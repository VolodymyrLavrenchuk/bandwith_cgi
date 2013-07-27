#! /opt/csw/bin/perl
use warnings;
use RRDs;

# define location of rrdtool databases
my $rrd = '/var/lib/rrd';

# process data for each specified HDD (add/delete as required)
require "/var/rrd/common/disk_list.pl";

# define location of images
my $img = '/www/rrd';

	&CreateGraph("", "day");
	&CreateGraph("", "week");
	&CreateGraph("", "month");
	&CreateGraph("", "year");
	
sub CreateGraph
{
# creates graph
# inputs: $_[0]: hdd name (ie, hda, etc)
#         $_[1]: interval (ie, day, week, month, year)
#         $_[2]: hdd description

	my @graph_array   = ();
    
    push @graph_array,"$img/hddtemp-$_[1].png";
    push @graph_array,"--lazy";
	push @graph_array,"-s -1$_[1]";
	push @graph_array,"-t hdd temperature :: hard disk drives";
	push @graph_array,"-h";
    push @graph_array,"80";
    push @graph_array,"-w";
    push @graph_array,"600";
    push @graph_array,"-u 41";
    push @graph_array,"-l 33";
    push @graph_array,"-r";
	push @graph_array,"-aPNG";
    push @graph_array,"-v degrees C";
	push @graph_array,"--slope-mode";

    our ($eDriveName, $eDriveSN, $eDriveColor);
    
    for ($iDrive = 0; $iDrive < (int @drives); $iDrive++)
    {
        my $driveName = $drives[$iDrive][$eDriveName];
        my $driveSN = $drives[$iDrive][$eDriveSN];
        my $driveColor = $drives[$iDrive][$eDriveColor];
        
        push @graph_array,"DEF:$driveName=$rrd/$driveName.rrd:temp:AVERAGE";
        push @graph_array,"LINE2:$driveName#$driveColor:$driveSN";
        push @graph_array,"GPRINT:$driveName:MIN:  Min\\: %2.lf";
        push @graph_array,"GPRINT:$driveName:MAX: Max\\: %2.lf";
        push @graph_array,"GPRINT:$driveName:AVERAGE: Avg\\: %4.1lf";
        push @graph_array,"GPRINT:$driveName:LAST: Current\\: %2.lf degrees C\\n";        
    }    
    
    RRDs::graph(@graph_array);
	if ($ERROR = RRDs::error) { print "$0: unable to generate $_[1] graph: $ERROR\n"; }
}
