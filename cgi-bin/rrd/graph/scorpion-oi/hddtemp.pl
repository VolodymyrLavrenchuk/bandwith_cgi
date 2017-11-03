#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";
require "$cur_dir/../../common/disk_list.pl";

our @drives;

my @graphs_data = ();
for $drive (@drives){
    push @graphs_data,[
        basename($cur_dir),
        $drive->{name},
        $drive->{name},
        "1",
        $drive->{color},
        $drive->{sn},
        "%2.lf"];
}
my @opt = ();
BuildGraphs("hdd temperature :: hard disk drives", "hddtemp", "degrees C",\@opt,@graphs_data);

1;