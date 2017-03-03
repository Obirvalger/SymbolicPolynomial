#! /usr/bin/perl -Ilib

use strict;
use warnings;
use feature qw(say);

use Polynomial;
use AOP;

my $asimple = AOP->new(
    k => 5,
    gens => ["3*x^4 + (x+1)^4","x^4 + 3*(x+1)^4"]
);

my $hs =  "h*x^4 + 4*t*x^4 + t*(x+4)^4";
my $ts = "t*x^4 + -2*h*x^4 + 2*h*(x+4)^4";
my $asymbolic = AOP->new(k => 5, gens => [$hs, $ts]);

say $asimple->to_csv;
say $asymbolic->to_tex_table;
