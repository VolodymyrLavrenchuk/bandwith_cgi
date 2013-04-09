#! /opt/csw/bin/perl

use Net::SNMP;
use strict;
use warnings;

# SNMP Datas

# Generic with host-ressource-mib
my $base_proc = "1.3.6.1.2.1.25.3.3.1";   # oid for all proc info
my $proc_load = "1.3.6.1.2.1.25.3.3.1.2"; # %time the proc was not idle over last minute

my %ERRORS=('OK'=>0,'WARNING'=>1,'CRITICAL'=>2,'UNKNOWN'=>3,'DEPENDENT'=>4);

my ($session,$error);
($session, $error) = Net::SNMP->session(
        -hostname  => "localhost",
        -community => "public"
);

if (!defined($session)) {
   printf("ERROR opening session: %s.\n", $error);
   exit $ERRORS{"UNKNOWN"};
}

# Get desctiption table
my $resultat =  $session->get_table(Baseoid => $base_proc);

if (!defined($resultat)) {
   printf("ERROR: Description table : %s.\n", $session->error);
   $session->close;
   exit $ERRORS{"UNKNOWN"};
}

$session->close;

our ($cpu_used,$ncpu)=(0,0);
foreach my $key ( keys %$resultat) {
   if ( $key =~ /$proc_load/) {
     $cpu_used += $$resultat{$key};
     $ncpu++;
   }
}

if ($ncpu==0) {
  print "Can't find CPU usage information : UNKNOWN\n";
  exit $ERRORS{"UNKNOWN"};
}

$cpu_used /= $ncpu;


print "$ncpu CPU, ", $ncpu==1 ? "load" : "average load";
printf(" %.1f%%\n",$cpu_used);

