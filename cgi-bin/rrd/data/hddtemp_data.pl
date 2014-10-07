#! /opt/csw/bin/perl
use warnings;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};

require "$cur_dir/../common/update_table.pl";
require "$cur_dir/../common/disk_list.pl";

for $drive (@drives){
    &ProcessHDD($drive->{name}, $drive->{sn});
}

sub ProcessHDD
{
	my $temp = `smartctl -i -c -A -l error -d sat,12 /dev/rdsk/$_[0]d0s0 | grep Temperature_Celsius | awk '{print \$10}'`;

	# remove eol chars and white space
	$temp =~ s/[\n ]//g;
	
	&ProcessTable($_[0],$temp);
}

1;