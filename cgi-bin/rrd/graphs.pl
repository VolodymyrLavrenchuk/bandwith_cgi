#! /opt/csw/bin/perl
use warnings;

use Sys::Hostname;
$hostname = hostname;

use FindBin;
use File::Spec::Functions;
use lib catdir($FindBin::Bin, 'common');

require "file_helpers.pl";

my $host_graphs_dir = catdir($FindBin::Bin, 'graph', hostname);

my @modules = GetDirModules($host_graphs_dir);
foreach (@modules)
{
  next if (-d $_);
  
  my $graph_module = catdir($host_graphs_dir,$_);
  require $graph_module;
}

1;