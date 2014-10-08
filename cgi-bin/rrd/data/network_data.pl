#! /opt/csw/bin/perl
use warnings;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};

require "$cur_dir/../common/update_table.pl";
require "$cur_dir/../common/network_list.pl";

my (@field_options) = (
    "DS:in:COUNTER:600:U:U",
    "DS:out:COUNTER:600:U:U"
);

for $port(@ports){
    &ProcessPort($port->{ip_address}, $port->{number});
}

sub ProcessPort
{
	my $in = `snmpget -v 2c -c public -Oqv tp-link IF-MIB::ifHCInOctets.$_[1]`;
	my $out = `snmpget -v 2c -c public -Oqv tp-link IF-MIB::ifHCOutOctets.$_[1]`;

	# remove eol chars
	chomp($in);
	chomp($out);

	&ProcessTable($_[0],"$in:$out","in:out", @field_options);
}

1;