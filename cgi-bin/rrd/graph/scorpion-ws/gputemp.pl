#! /opt/csw/bin/perl
use warnings;
require "build_gpu_graphs.pl";

BuildGPUGraphs("GPU temperature :: MSI GeForce GTX 1060", "degrees C", "gputemp", "gputemp", "%2.1lf", ());

1;
