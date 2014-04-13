#! /opt/csw/bin/perl
use warnings;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};

require "$cur_dir/../common/update_table.pl";
require "$cur_dir/../common/traffic_list.pl";

my (@field_options) = (
    "DS:in:DERIVE:600:0:12500000",
    "DS:out:DERIVE:600:0:12500000"
);

for $iface(@ifaces){
    &ProcessInterface($iface->{name}, $iface->{number});
}

sub ProcessInterface
{
	my $in = `snmpget -v 1 -c public -Oqv localhost IF-MIB::ifInOctets.$_[1]`;
	my $out = `snmpget -v 1 -c public -Oqv localhost IF-MIB::ifOutOctets.$_[1]`;

	# remove eol chars
	chomp($in);
	chomp($out);

	&ProcessTable($_[0],"$in:$out","in:out", @field_options);
}

1;
