#! /opt/csw/bin/perl
use warnings;
use File::Basename;

my ($cur_dir) = __FILE__ =~ m{^(.*)/};
require "$cur_dir/../../common/build_graphs.pl";
require "$cur_dir/gpu_colors_list.pl";

our @gpu_colors;

sub BuildJSGraph
{
  ($title, $y_title, $file_prefix, $prec, @opt) = @_;

  my @graphs_data = ();

  for my $index (0 .. $#gpu_colors) {
    push @graphs_data,["gpu$index",$file_prefix,"1",$gpu_colors[$index],"GPU$index",$prec]
  }

  BuildGraphs(basename($cur_dir), "$title :: Palit JetStream GeForce GTX 1070ti", $file_prefix, $y_title, \@opt, @graphs_data); 
}

1;