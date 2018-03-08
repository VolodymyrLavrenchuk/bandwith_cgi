#! /opt/csw/bin/perl
use warnings;

require "build_graphs.pl";
require "gpu_colors_list.pl";
require "file_helpers.pl";

sub BuildGPUGraphs
{
  ($title, $y_title, $file_prefix, $data_field, $prec, @opt) = @_;

  our @gpu_colors;
  our $rrd_dbs_dir;

  my @graphs_data = ();
  # my ($host_dbs_dir) = "$rrd_dbs_dir/$host";
  my @modules = GetDirModules($rrd_dbs_dir);

  foreach (@modules)
  {
    next if (-d $_);
    next unless ($_ =~ m/^gpu/);

    # if (-f $host_dbs_dir . "/" . $_ )
    # {
      my ($idx) = $_ =~ /^gpu(\w*)\.rrd/;
      push @graphs_data,["gpu$idx",$data_field,"1",$gpu_colors[$idx],"GPU$idx",$prec];
    # }
  }

  BuildPeriodsGraphs($title, $file_prefix, $y_title, \@opt, @graphs_data);
}

1;