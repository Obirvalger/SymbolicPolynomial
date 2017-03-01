#! /usr/bin/perl -Ilib

use strict;
use warnings;
use feature "say";
use Polynomial qw(binom_mod);
use Data::Printer;
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


# Creating symbolic polynomials
my $h = Polynomial->new(k => $k,
   str => "h*x^$k_1 + $k_1*t*x^$k_1 + t*(x+$k_1)^$k_1");
my $t = Polynomial->new(k => $k,
   str => "t*x^$k_1 + -$c*h*x^$k_1 + $c*h*(x+$k_1)^$k_1");

# Creating "simple" polynomials
my $f = Polynomial->new(k => $k, str => "$e*x^$k_1 + (x+1)^$k_1");
my $g = Polynomial->new(k => $k, str => "x^$k_1 + $e*(x+1)^$k_1");



for my $d (0..$k-1) {
    say $f->polarize($d)->to_csv;
}
# say '';
#for my $d (0..$k-1) {
    #say $g->polarize($d)->to_csv;
#}
