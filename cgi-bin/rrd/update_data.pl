#! /opt/csw/bin/perl
use RRDs;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
my ($data_dir) = "$cur_dir/data";

my @hosts = ('scorpion-ws','scorpion-js');

opendir my $dir, $data_dir or die "Cannot open directory: $!";
my @modules = readdir $dir;
closedir $dir;

foreach (@modules){
    if (-f $data_dir . "/" . $_ ){
        require "$data_dir/$_";
    }
}

foreach (@hosts){
  my $cur_dir = "/mnt/dbs/monitoring/$_";

  opendir my $xml_dir, "$cur_dir/xmls" or die "Cannot open directory: $!";
  my @xmls = readdir $xml_dir;
  closedir $xml_dir;
  foreach (@xmls){
      if (-f "$cur_dir/xmls" . "/" . $_ ){
        my ($filename) = $_ =~ m{^(.*)\.};
        print "processing: $cur_dir/xmls/$_\n";
        RRDs::restore "$cur_dir/xmls/$_", "$cur_dir/$filename.rrd", "-f";
      }
  }
}