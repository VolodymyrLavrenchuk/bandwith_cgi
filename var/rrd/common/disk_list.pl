#! /opt/csw/bin/perl

@drives  = (
            ["c4t0d0s0","System drive  ","FF0000"],
            ["c4t1d0s0","ML0230FA14Y5LD","CC00CC"],
            ["c7t5000CCA36ACF86ABd0s0","ML4230FA134U2K","00FF00"],
            ["c7t5000CCA369C3D656d0s0","MN1220F308EP6D","0000FF"],
            ["c7t5000CCA369E4CFE2d0s0","ML4220F32LZE1K","00FFFF"],
            ["c7t5000CCA369D1D0ABd0s0","ML4220F3185X9K","FFFF00"]
            );

our $eDriveName=0;
our $eDriveSN=1;
our $eDriveColor=2;
