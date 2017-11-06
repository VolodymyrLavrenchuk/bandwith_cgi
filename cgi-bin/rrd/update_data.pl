#! /opt/csw/bin/perl
use RRDs;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
my ($data_dir) = "$cur_dir/data";

my $scorpionws_dir = '/mnt/dbs/monitoring/scorpion-ws';

opendir my $dir, $data_dir or die "Cannot open directory: $!";
my @modules = readdir $dir;
closedir $dir;

foreach (@modules){
    if (-f $data_dir . "/" . $_ ){
        require "$data_dir/$_";
    }
}

opendir my $xml_dir, "$scorpionws_dir/xmls" or die "Cannot open directory: $!";
my @xmls = readdir $xml_dir;
closedir $xml_dir;
foreach (@xmls){
    if (-f "$scorpionws_dir/xmls" . "/" . $_ ){
      my ($filename) = $_ =~ m{^(.*)\.};
      print "processing: $scorpionws_dir/xmls/$_\n";
      RRDs::restore "$scorpionws_dir/xmls/$_", "$scorpionws_dir/$filename.rrd", "-f";
    }
}