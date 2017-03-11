#! /usr/bin/perl -Ilib

use strict;
use warnings;
use feature qw(say);

use Polynomial;
use AOP;
use Math::Prime::Util qw(binomial znprimroot is_primitive_root);
use Getopt::Long;

my $k = 5;
my ($c, $e, $v, $s, $f);

Getopt::Long::Configure ("bundling");
GetOptions (
    'k=i' => \$k,
    'c=i' => \$c,
    'e=i' => \$e,
    'v=s' => \$v,
    's=s' => \$s,
    'f=s' => \$f,
);

sub make_polynomial {
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

say make_polynomial(2, '01', 1);
