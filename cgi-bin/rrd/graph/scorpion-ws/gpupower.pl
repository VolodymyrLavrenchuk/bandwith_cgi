#! /opt/csw/bin/perl
use warnings;
require "build_gpu_graphs.pl";

BuildGPUGraphs("GPU power usage :: MSI GeForce GTX 1060", "Watts", "gpupower", "gpupower", "%2.1lf", ("-l 0"));

1;
