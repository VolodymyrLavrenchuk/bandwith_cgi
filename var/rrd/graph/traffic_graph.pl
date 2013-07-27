#! /opt/csw/bin/perl
use warnings;
use RRDs;

require "/var/rrd/common/network_list.pl";

# define location of rrdtool databases
my $rrd = '/var/lib/rrd';

# define location of images
my $img = '/www/rrd';

	# create traffic graphs
	&CreateGraph("day");
	&CreateGraph("week");
	&CreateGraph("month"); 
	&CreateGraph("year");
    
sub CreateGraph
{
	my @graph_array   = ();
    
    push @graph_array,"$img/traffic-$_[0].png";
    push @graph_array,"-s -1$_[0]";
    push @graph_array,"-t traffic on Tiera";
    push @graph_array,"--lazy";
	push @graph_array,"-h";
    push @graph_array,"80";
    push @graph_array,"-w";
    push @graph_array,"600";    
    push @graph_array,"-l 0";
    push @graph_array,"-aPNG";
    push @graph_array,"-v bytes/sec";
    push @graph_array,"HRULE:0#000000";
    
    our ($eIfaceName, $eColorIn, $eColorOut);
    
    for ($iIface = 0; $iIface < (int @ifaces); $iIface++)
    {
        my $ifaceName = $ifaces[$iIface][$eIfaceName];
        my $ifaceColorIn = $ifaces[$iIface][$eColorIn];
        my $ifaceColorOut = $ifaces[$iIface][$eColorOut];
        
        push @graph_array,"DEF:in$ifaceName=$rrd/$ifaceName.rrd:in:AVERAGE";
        push @graph_array,"LINE2:in$ifaceName#$ifaceColorIn:$ifaceName in ";
        push @graph_array,"GPRINT:in$ifaceName:MAX: Max\\: %5.1lf %s";
        push @graph_array,"GPRINT:in$ifaceName:AVERAGE: Avg\\: %5.1lf %S";
        push @graph_array,"GPRINT:in$ifaceName:LAST: Current\\: %5.1lf %Sbytes/sec\\n";
        push @graph_array,"DEF:out$ifaceName=$rrd/$ifaceName.rrd:out:AVERAGE";
        push @graph_array,"LINE2:out$ifaceName#$ifaceColorOut:$ifaceName out";
        push @graph_array,"GPRINT:out$ifaceName:MAX: Max\\: %5.1lf %s";
        push @graph_array,"GPRINT:out$ifaceName:AVERAGE: Avg\\: %5.1lf %S";
        push @graph_array,"GPRINT:out$ifaceName:LAST: Current\\: %5.1lf %Sbytes/sec\\n";        
    }
    
    RRDs::graph(@graph_array);


	if ($ERROR = RRDs::error) { print "$0: unable to generate $_[0] traffic graph: $ERROR\n"; }
}
