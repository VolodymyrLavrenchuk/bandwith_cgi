#! /opt/csw/bin/perl
use warnings;
use RRDs;

# define location of rrdtool databases
my $rrd = '/var/lib/rrd';

sub ProcessTable
{
    ($name, $value, $field, @ext_options) = @_;

	# if rrdtool database doesn't exist, create it
	if (! -e "$rrd/$_[0].rrd")
	{
		print "creating rrd database for /var/lib/$name...\n";
		my @table_options = (
            "$rrd/$name.rrd",
			"-s 300",
			"RRA:AVERAGE:0.5:1:576",
			"RRA:AVERAGE:0.5:6:672",
			"RRA:AVERAGE:0.5:24:732",
			"RRA:AVERAGE:0.5:144:1460"
		);

		if(!@ext_options)
		{
		    push  @table_options,"DS:$name:GAUGE:600:0:100"
		}
		else
        {
            push @table_options, @ext_options;
        }

		RRDs::create(@table_options);
	}

    print "updating: $rrd/$name.rrd with value: $value\n";

    if (!$field)
    {
        $field = $name;
    }

    # insert value into rrd
	RRDs::update "$rrd/$name.rrd",
		"-t", "$field",
		"N:$value";
	
}
1;