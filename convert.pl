#! /usr/bin/perl -Ilib

my $description = <<EOF;
Program to convert vector of function to vector of polarized polynomial of the
function and vice versa.
EOF

use strict;
use warnings;
use feature qw(say);

use Polynomial;
use AOP;
use Math::Prime::Util qw(binomial znprimroot is_primitive_root);
use Getopt::Long;

sub function_to_polynomial {
    my $k = shift;
    my @f = split //, (shift @_);
    my $d = shift // 0;
    my @p;

    $p[0] = $f[(0-$d) % $k];
    for my $j (1..$k-1) {
        my $c = 0;
        for my $i (0..$k-1) {
            $c += $i**($k-1-$j) * $f[($i-$d) % $k];
        }

        ($p[$j] = -$c) %= $k;
    }

    return join '', @p;
}

# NOTE This is simple copy of function_to_polynomial and doesn't work correctly
sub polynomial_to_function {
    my $k = shift;
    my @f = split //, (shift @_);
    my $d = shift // 0;
    my @p;

    $p[0] = $f[(0-$d) % $k];
    for my $j (1..$k-1) {
        my $c = 0;
        for my $i (0..$k-1) {
            $c += $i**($k-1-$j) * $f[($i-$d) % $k];
        }

        ($p[$j] = -$c) %= $k;
    }

    return join '', @p;
}

my $k;
my $polarization = 0;
my $polynomial;
my $function;
my $help;

Getopt::Long::Configure ("bundling");
GetOptions (
    'k=i'              => \$k,
    'd|polarization=i' => \$polarization,
    'p|polynomial=s'   => \$polynomial,
    'f|function=s'     => \$function,
    'h|help'           => \$help
);

if ($help) {
    say "Usage: $0 [OPTION]";
    say "-k                    value of the logic";
    say "-f, --function        vector of function";
    say "-d, --polynomial      vector of polarized polynomial";
    say "-p, --polarization    polarization, 0 by default";
    say '';

    print $description;
    exit 0;
}

say function_to_polynomial($k, $function, $polarization) if $function;
say polynomial_to_function($k, $polynomial, $polarization) if $polynomial;
