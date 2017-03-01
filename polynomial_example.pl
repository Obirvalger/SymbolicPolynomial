#! /usr/bin/perl -Ilib

use strict;
use warnings;
use feature "say";
use Polynomial;
# use Data::Printer;
use Math::Prime::Util qw(binomial znprimroot is_primitive_root);
use Getopt::Long;

my $k = 5;
my $c;
my $e;
my $d = 0;
my $str;

# Pasring command line arguments
Getopt::Long::Configure ("bundling");
GetOptions (
    'k=i'   => \$k,   # value of the logic
    'c=i'   => \$c,   # some constant
    'e=i'   => \$e,   # some constant
    'd=i'   => \$d,   # polarization
    'str=s' => \$str, # string, representing polynomial
);

my $k_1 = $k-1;

$c //= znprimroot($k);
$e //= -znprimroot($k) % $k;
$str //= "-t*x^$k_1";


say 'Symbolic polynomials in 3-valued logic:';
my $p1 = Polynomial->new(k => 3, str => "h*x^2 + 2t*x + t");
my $p2 = Polynomial->new(k => 3, str => "2t*x^2 + t*x + h");

# Print them
say "p1 = $p1";
say "p2 = $p2";
say '';

# Print polarizations
say "p1 polarization 1 -- ", $p1->polarize(1);
say "p2 polarization 2 -- ", $p2->polarize(2);
say '';

# Print arithmetic operations
say "sum of the polynomials -- ", $p1 + $p2;
say "p1 multiplied by 2 -- ", 2*$p1;
say '';

# Print as tex and scv
say "p1 in tex format -- ", $p1->to_tex;
say "p2 in csv format -- ", $p2->to_csv;
say '';

say '"Simple" polynomials in 5-valued logic:';
my $p3 = Polynomial->new(k => 5, str => "x^4 + 3x^2 + 2");
my $p4 = Polynomial->new(k => 5, str => "2x^3 + x^2 + 4x + 3");

# Print them
say "p3 = $p3";
say "p4 = $p4";
say '';

# Print polarizations
say "p3 polarization 4 -- ", $p1->polarize(4);
say "p4 polarization 3 -- ", $p2->polarize(3);
say '';

# Print arithmetic operations
say "sum of the polynomials -- ", $p3 + $p4;
say "p4 multiplied by 3 -- ", 3*$p4;
say '';

# Print as tex and scv
say "p3 in tex format -- ", $p3->to_tex;
say "p4 in csv format -- ", $p4->to_csv;
say '';
