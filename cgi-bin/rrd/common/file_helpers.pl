#! /opt/csw/bin/perl
use warnings;

sub GetDirModules
{
  ($data_dir) = @_;
  
  opendir my $dir, $data_dir or die "Cannot open directory: $!";
  my @modules = readdir $dir;
  closedir $dir;
  
  return @modules;
}

1;

