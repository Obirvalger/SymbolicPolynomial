use strict;
use warnings;
use Polynomial;
use AOP;
use Math::Prime::Util qw(binomial znprimroot is_primitive_root);
use Test::More tests => 13;
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

# NOTE Begin AOP
AOP: do {
    my $k = 5;
    my $k_1 = $k - 1;
    my $c //= znprimroot($k);

    my $hs =  "h*x^$k_1 + $k_1*t*x^$k_1 + t*(x+$k_1)^$k_1";
    my $ts = "t*x^$k_1 + -$c*h*x^$k_1 + $c*h*(x+$k_1)^$k_1";

    my $as = AOP->new(k => $k, gens => [$hs, $ts]);

    #NOTE Be aware of blank symbols
    my $res = <<'EOF';
\documentclass[a4paper, 12pt]{extarticle}
\begin{document}
$$\begin{array}{l}
f_0x^4 + f_1x^3 + f_1x^2 + f_1x + f_1\\  
f_1x^4 + 2f_0x^3 + 2f_0x^2 + 2f_0x + 2f_0\\  
f_2x^4 + 2f_4x^3 + 2f_4x^2 + 2f_4x + 2f_4\\  
f_3x^4 + 4f_5x^3 + 4f_5x^2 + 4f_5x + 4f_5\\  
f_4x^4 + f_2x^3 + f_2x^2 + f_2x + f_2\\  
f_5x^4 + 3f_3x^3 + 3f_3x^2 + 3f_3x + 3f_3\\  
\end{array}$$
$$\begin{array}{l}
f_0(x+1)^4 + f_2(x+1)^3 + f_4(x+1)^2 + f_3(x+1) + f_0\\  
f_1(x+1)^4 + 2f_4(x+1)^3 + f_2(x+1)^2 + 4f_5(x+1) + f_1\\  
f_2(x+1)^4 + 3f_5(x+1)^3 + 2f_3(x+1)^2 + 3f_1(x+1) + f_2\\  
f_3(x+1)^4 + 3f_1(x+1)^3 + 3f_0(x+1)^2 + 4f_2(x+1) + f_3\\  
f_4(x+1)^4 + 2f_3(x+1)^3 + 4f_5(x+1)^2 + 3f_0(x+1) + f_4\\  
f_5(x+1)^4 + 4f_0(x+1)^3 + 2f_1(x+1)^2 + 2f_4(x+1) + f_5\\  
\end{array}$$
$$\begin{array}{l}
f_0(x+2)^4 + 2f_4(x+2)^3 + 4f_0(x+2)^2 + 3f_4(x+2) + f_0\\  
f_1(x+2)^4 + 2f_2(x+2)^3 + 4f_1(x+2)^2 + 3f_2(x+2) + f_1\\  
f_2(x+2)^4 + 4f_3(x+2)^3 + 4f_2(x+2)^2 + f_3(x+2) + f_2\\  
f_3(x+2)^4 + f_0(x+2)^3 + 4f_3(x+2)^2 + 4f_0(x+2) + f_3\\  
f_4(x+2)^4 + 3f_5(x+2)^3 + 4f_4(x+2)^2 + 2f_5(x+2) + f_4\\  
f_5(x+2)^4 + 4f_1(x+2)^3 + 4f_5(x+2)^2 + f_1(x+2) + f_5\\  
\end{array}$$
$$\begin{array}{l}
f_0(x+3)^4 + 3f_3(x+3)^3 + 4f_4(x+3)^2 + 2f_2(x+3) + f_0\\  
f_1(x+3)^4 + 2f_5(x+3)^3 + 4f_2(x+3)^2 + 4f_4(x+3) + f_1\\  
f_2(x+3)^4 + 4f_1(x+3)^3 + 3f_3(x+3)^2 + f_5(x+3) + f_2\\  
f_3(x+3)^4 + 2f_2(x+3)^3 + 2f_0(x+3)^2 + f_1(x+3) + f_3\\  
f_4(x+3)^4 + 4f_0(x+3)^3 + f_5(x+3)^2 + 4f_3(x+3) + f_4\\  
f_5(x+3)^4 + f_4(x+3)^3 + 3f_1(x+3)^2 + 3f_0(x+3) + f_5\\  
\end{array}$$
$$\begin{array}{l}
f_0(x+4)^4 + 4f_5(x+4)^3 + f_5(x+4)^2 + 4f_5(x+4) + f_5\\  
f_1(x+4)^4 + 2f_3(x+4)^3 + 3f_3(x+4)^2 + 2f_3(x+4) + 3f_3\\  
f_2(x+4)^4 + f_0(x+4)^3 + 4f_0(x+4)^2 + f_0(x+4) + 4f_0\\  
f_3(x+4)^4 + 3f_4(x+4)^3 + 2f_4(x+4)^2 + 3f_4(x+4) + 2f_4\\  
f_4(x+4)^4 + 3f_1(x+4)^3 + 2f_1(x+4)^2 + 3f_1(x+4) + 2f_1\\  
f_5(x+4)^4 + 2f_2(x+4)^3 + 3f_2(x+4)^2 + 2f_2(x+4) + 3f_2\\  
\end{array}$$
\end{document}
EOF
    chomp($res);
    is($as->to_tex_array(one_function => 'f'), $res);
};
