use strict;
use warnings;
use Polynomial;
use Math::Prime::Util qw(binomial znprimroot is_primitive_root);
use Test::More tests => 12;
use Data::Printer;

# NOTE Begin Vector
Vector: do {
    # TEX
    is(Polynomial->new(k => 3, str => 'x^2+2*x+2')->to_tex, '$x^2+2x+2$',
        'tex, all summands, k = 3');
    is(Polynomial->new(k => 5, str => 'x^4+4*x^3+2*x^2+x+3')->to_tex,
        '$x^4+4x^3+2x^2+x+3$', 'tex, all summands, k = 5');

    is(Polynomial->new(k => 3, str => '2*x^2+1')->to_tex, '$2x^2+1$',
        'tex, not all summands, k = 3');
    is(Polynomial->new(k => 5, str => '2*x^3+3*x^2+4')->to_tex,
        '$2x^3+3x^2+4$', 'tex, not all summands, k = 5');

    # CSV
    is(Polynomial->new(k => 3, str => 'x^2+2*x+2')->to_csv, 'x^2;2*x;2',
        'csv, all summands, k = 3');
    is(Polynomial->new(k => 5, str => 'x^4+4*x^3+2*x^2+x+3')->to_csv,
        'x^4;4*x^3;2*x^2;x;3', 'csv, all summands, k = 5');

    is(Polynomial->new(k => 3, str => '2*x^2+1')->to_csv, '2*x^2;;1',
        'csv, not all summands, k = 3');
    is(Polynomial->new(k => 5, str => '2*x^3+3*x^2+4')->to_csv,
        ';2*x^3;3*x^2;;4', 'csv, not all summands, k = 5');
};

# NOTE Begin Symbolic
Symbolic: do {
    is(Polynomial->new(k => 5, d => 3, str =>
    '(g+3*h)*(x+3)^4+4*g*(x+3)^3+(g+h)*(x+3)^2+(4*g+h)*(x+3)+(g+3*h)')->to_tex,
    '$(g + 3h)(x+3)^4+4g(x+3)^3+(g + h)(x+3)^2+(4g + h)(x+3)+(g + 3h)$');

    is(Polynomial->new(k => 5, d => 3, str =>
    '(g+3*h)*(x+3)^4+(4*g+h)*(x+3)')->to_tex,
    '$(g + 3h)(x+3)^4+(4g + h)(x+3)$');

    is(Polynomial->new(k => 5, d => 3, str =>
    '(g+3*h)*(x+3)^4+4*g*(x+3)^3+(g+h)*(x+3)^2+(4*g+h)*(x+3)+(g+3*h)')->to_csv,
    '(g + 3*h)*(x+3)^4;4*g*(x+3)^3;(g + h)*(x+3)^2;(4*g + h)*(x+3);(g + 3*h)');

    is(Polynomial->new(k => 5, d => 3, str =>
    '4*g*(x+3)^3+(g+h)*(x+3)^2')->to_csv,
    ';4*g*(x+3)^3;(g + h)*(x+3)^2;;');
};
