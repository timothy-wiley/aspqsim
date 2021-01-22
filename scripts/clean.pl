#! /usr/bin/perl

#
# ASP implementation of QSIM
# Helper script
# Author: Timothy Wiley, UNSW Australia
#
# "Clean" the ASP output for unwanted variables to
# make the display more concise
#   see ./clean -h for usage
#

use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;

# Subs
sub help();

my $help;
my $infile;
my $outfile;
my @remove;
my $timeAdjust = 0;
GetOptions(
           "help"           => \$help,
           "infile=s"       => \$infile,
           "outfile=s"      => \$outfile,
           "remove=s"       => \@remove,
           "time=i"   => \$timeAdjust,
          )
  or die("Error in command line arguments\n");
if ($help) {
    help();
    exit 0;
}
if (!$infile) {
    print "Input log file missing\n";
    help();
    exit 0;
}
if (!$outfile) {
    print "Output log file missing\n";
    help();
    exit 0;
}

print "In file: $infile\n";
print "Out file: $outfile\n";
print "Vars to remove: @remove\n";
print "Time Adjust: $timeAdjust\n";

# Convert remove arrays to hash
my %removeHash = map {$_ => 1 } @remove;
#print Dumper(\%removeHash);

# Track location of "Answer" string
my $answer;

#print "Reading from file: $file\n";
open(IN_FILE, "<", $infile);
open(OUT_FILE, ">", $outfile);

# Input
while (my $line = <IN_FILE>) {
    chomp $line;

    if ($line =~ /^Answer: ([0-9]+)/) {
        $answer = $1;
    }
    if (!$answer) { next; }

    if ($line !~ /holds/) { next; }

    # Data structure
    my %states;
    my $maxTime = 0;

    # Split line by spaces
    my @preds = split /\s/, $line;

    # Load each predicate into the data structures
    #print "Answer: $answer\n";
    print OUT_FILE "#program base.\n";
    for my $pred (@preds) {
        if ($pred =~ /^holds\(/) {
            $pred =~ /^holds\(([pi]\(.*\)),(.*),((interval|land)\(.*\)),(.*)\)$/;
            my $time = $1;
            my $qvar = $2;
            my $mag = $3;
            my $dir = $5;
            
            if (not exists $removeHash{$qvar}) {
                if ($time =~ /p\((.*)\)/) {
                    my $newp = $1 + $timeAdjust;
                    $time = "p($newp)";
                } elsif ($time =~ /i\((.*),(.*)\)/) {
                    my $newi1 = $1 + $timeAdjust;
                    my $newi2 = $2 + $timeAdjust;
                    $time = "i($newi1,$newi2)";
                }
                print OUT_FILE "holds($time,$qvar,$mag,$dir).\n";
            }
        }
    }
#    print Dumper(\%states);
}

close(IN_FILE);
close(OUT_FILE);

exit 0;



sub help() {
    print "$0 <options>\n";
    print "\t--help\t\tShow this help\n";
    print "\t--infile\tInput log file\n";
    print "\t--outfile\tOutput log file\n";
    print "\t--remove\tVariables to remove\n";
    print "\t--timeAdjust\tAdjust time points by constant amount\n";
}




