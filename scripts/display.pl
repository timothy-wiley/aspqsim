#! /usr/bin/perl

#
# ASP implementation of QSIM
# Helper script
# Author: Timothy Wiley, UNSW Australia
#
# Display the output of ASP in a human friendly format
#   see ./display -h for usage
#

use strict;
use warnings;
use Data::Dumper;

sub printState($$);

my $file = $ARGV[0];
my $answer;

print "Reading from file: $file\n";
open(FILE, "<", $file);

# Input
while (my $line = <FILE>) {
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
    print "Answer: $answer\n";
    for my $pred (@preds) {
        if ($pred =~ /^holds\(/) {
            $pred =~ /^holds\(([pi]\(.*\)),(.*),((interval|land)\(.*\)),(.*)\)$/;
            my $time = $1;
            my $qvar = $2;
            my $mag = $3;
            my $dir = $5;

            # Get max time
            if ($time =~ /p\((.*)\)/) {
                $maxTime = $1 if $1 > $maxTime;
            } elsif ($time =~ /i\(.*,(.*)\)/) {
                $maxTime = $1 if $1 > $maxTime;
            }

            # Perform subs
            $time =~ s/,/.../;
            $mag =~ s/land\((.*)\)/$1/;
            $mag =~ s/interval\((.*)\)/$1/;
            $mag =~ s/,/.../;

            $states{$time}->{qvar}->{$qvar} ="$mag/$dir";
        } elsif ($pred =~ /^holds_constraint/) {
            $pred =~ /^holds_constraint\(([pi]\(.*\)),(.*?),(.*)\)/;
            my $time = $1;
            my $con = $2;
#            print "$time - $con\n";

            # Perform subs
            $time =~ s/,/.../;

            # Add constraint
            $states{$time}->{con}->{$con} = 1;
        } elsif ($pred =~ /^action/) {
            $pred =~ /^action\(([pi]\(.*\)),(.*),((interval|land)\(.*\)),(.*)\)$/;
            my $time = $1;
            my $qvar = $2;
            my $mag = $3;
            my $dir = $5;

            # Perform subs
            $time =~ s/,/.../;
            $mag =~ s/land\((.*)\)/$1/;
            $mag =~ s/interval\((.*)\)/$1/;
            $mag =~ s/,/.../;
            
            $states{$time}->{action}->{$qvar} = "$mag/$dir";
        }
    }

    # Print data
    for my $t (0..$maxTime) {
        # Print p
        my $tStr = "p($t)";
        printState($tStr, $states{$tStr}) if exists $states{$tStr};

        # Print i
        $tStr = "i($t..." . ($t+1) . ")";
        printState($tStr, $states{$tStr}) if exists $states{$tStr};
    }

#    print Dumper(\%states);
}

close(FILE);

exit 0;

sub printState($$) {
    my $time = shift;
    my $state = shift;

    # Print QVars
    print "$time = {\n";
    for my $var (sort keys %{$state->{qvar}}) {
        print "\t$var: $state->{qvar}->{$var}\n";
    }
    print "\t}";

    # Print Actions
    print "\nAction = {\n";
    for my $var (sort keys %{$state->{action}}) {
        print "\t$var: $state->{action}->{$var}\n";
    }
    print "\t}";

    # Print constraints
    print "\n";
    my $con = join ", ", (sort keys %{$state->{con}});
    print "Constraints: $con\n";

    # Separator
    print "\n";
}

