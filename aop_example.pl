#! /usr/bin/perl -Ilib

use strict;
use warnings;
use feature qw(say);

use Polynomial;
use AOP;

# AOP is system or array of polynomials
# Create system, containing all linear combinations of two polynomials,
# consructed from strings, passed to gens
my $asimple = AOP->new(
    k => 5,
    gens => ["3*x^4 + (x+1)^4","x^4 + 3*(x+1)^4"]
);

my $hs =  "h*x^4 + 4*t*x^4 + t*(x+4)^4";
my $ts = "t*x^4 + -2*h*x^4 + 2*h*(x+4)^4";

my $asymbolic = AOP->new(k => 5, gens => [$hs, $ts]);
say "asymbolic is complex" if $asymbolic->is_all_complex;

say "Print asimple system with all polarizations in csv format to tmp.csv";
open (my $csv_fh, '>', "tmp.csv");
say $csv_fh $asimple->to_csv;

say "Print asymbolic system with all polarizations in tex format to tmp.tex";
open (my $tex_fh, '>', "tmp.tex");
say $tex_fh $asymbolic->to_tex_table;
