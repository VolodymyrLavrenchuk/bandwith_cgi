#! /opt/csw/bin/perl

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
my ($data_dir) = "$cur_dir/data";

opendir my $dir, $data_dir or die "Cannot open directory: $!";
my @modules = readdir $dir;
closedir $dir;

foreach (@modules){
    if (-f $data_dir . "/" . $_ ){
        require "$data_dir/$_";
    }
}