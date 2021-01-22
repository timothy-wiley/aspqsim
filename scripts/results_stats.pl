#! /usr/bin/perl

#
# ASP implementation of QSIM
# Helper script
# Author: Timothy Wiley, UNSW Australia
#
# Generate result statistics for an ASP run
#   see ./results_stats -h for usage
#

use strict;
use warnings;

use Getopt::Long;

# Subs
sub command(@);
sub getDataFromFile($);
sub parseMag($);
sub help();

################################################################################
# Array of  data being collected
my @data = ();

# Data structures for choosing parts of the tests

################################################################################
# Run all of the tests

# Progress program arguments
my $help = 0;
my $directory;
my $inFile = "";
GetOptions(
           "help"           => \$help,
           "directory=s"    => \$directory,
           "in=s"           => \$inFile,
          )
  or die("Error in command line arguments\n");
if ($help) {
    help();
    exit 0;
}

# Get the list of files
my @files = ();
if ($directory) {
    print "Processing Directory: $directory\n";
    @files = glob "./$directory/*.txt";
    push @files, glob "./$directory/*.lp";
} elsif ($inFile ne "") {
    @files = ($inFile);
}
#print "@files\n";
#print scalar @files . "\n";

# Check for files
if (@files == 0) {
    print "No files to process\n\n";
    help();
    exit 0;
}

# Process each file
for my $file (@files) {
    print "Processing File: $file\n";
    getDataFromFile($file);
}

# Print Results
printf "%30s | %7s | %10s | %10s | %10s | %11s \n",
       "Name", "Time", "Grounding", "Solving", "Seq Length", "Plan Length";
print "------------------------------------------------------------------------",
      "----------------------------------------\n";
for my $d (@data) {
    my $percent = 0;
    for my $cost (sort keys %{$d->{costs}}) {
        $percent = $d->{costs}->{$cost} / $d->{expanded} * 100;
    }

    if ($d->{finished}) {
        printf "%30s | %7.2f | %10.2f | %10.2f | %10d | %11d\n",
               $d->{name},
               $d->{time},
               $d->{time} - $d->{solving},
               $d->{solving},
               $d->{seq_length},
               $d->{plan_length}
               ;
    } else {
        printf "%30s | %7s | %10s | %10s | %10s | %11s   (unfinished)\n",
               $d->{name},
               "----",
               "----",
               "----",
               "----",
               "----"
               ;
    }
}

exit 0;

sub command(@) {
    my $command = shift;
    my $run = 1;

    if (@_ > 0) {
        $run = shift;
    }

    print "Executing: $command\n";
    if ($run) {
        system($command) == 0
            or die "\n\nSystem Command failed\n";
    } else {
        print "\tExecution withheld\n";
    }
}

sub getDataFromFile($) {
    my $inFile = shift;

    my $fileData  = {
        costs           => {},
        finished        => 0,
        plan_length     => 0,
        seq_length      => 0,
        time            => 0,
        grounding       => 0,
    };

    # Add data name
    if ($inFile =~ /^.*\/(.*)[.]txt$/) {
        $fileData->{name} = $1;
    } elsif ($inFile =~ /^.*\/(.*)[.]lp$/) {
        $fileData->{name} = $1;
    } else {
        $fileData->{name} = "unknown";
    }

    # Open the file
    open(IN, $inFile);

    my $line;
    my $done = 0;
    while (!$done && ($line = <IN>)) {
        # Read until the results table
        if ($line =~ /^SATISFIABLE/) {
            $done = 1;
            $fileData->{finished} = 1;
            next;
        }

        # Check for model
        my $parseModel = 0;
        if ($line =~ /^Model/) {
            $parseModel = 1;
        } elsif ($line =~ /^Answer/) {
            $parseModel = 1;
            $line = <IN>;
        }

        # Otherwise find holds constraints
        if ($parseModel) {
            my @preds = split / /, $line;
            for my $p (@preds) {
                if ($p =~ /holds\(p\(([0-9]+)\)/) {
                    my $planLength = $1;
                    if ($planLength > $fileData->{seq_length}) {
                        $fileData->{seq_length} = $planLength;
                    }
                }
            }
        }
     }

    # Process the Results
    my $doneSeq = 0;
    while (!$doneSeq && ($line = <IN>)) {
        # Get Time
        if ($line =~ /^Time\s*:\s*([0-9.]+)s.*\(Solving:\s*([0-9.]+)s.*\)/) {
            $fileData->{time} = $1;
            $fileData->{solving} = $2;
        }
    }

    # Process the plan/action table
    # TODO
    my $donePlan = 0;
    while (!$donePlan && ($line = <IN>)) {
    }

    # Close and done
    close(IN);

    # Insert file data into collection
    push @data, $fileData;
}

sub parseMag($) {
    my $mag = shift;

    $mag =~ s/zero/0/;
    $mag =~ s/minf/-inf/;
    $mag =~ s/inf/\\infty/;
    $mag =~ s/pi2/\\frac{pi}{2}/;
    $mag =~ s/pi/\\pi/;
    $mag =~ s/^n(.*)/-$1/;
    $mag =~ s/(.*)_(.*)/$1_{$2}/;

    return $mag;
}

sub help() {
    print "$0 <options>\n";
    print "\t--help\t\tShow this help\n";
    print "\t--directory\tInput directory of files\n";
    print "\t--in\t\tSingle Input file\n";
}


