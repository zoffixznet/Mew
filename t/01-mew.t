#!perl

use strict;
use warnings FATAL => 'all';
use Test::Most;

BEGIN { use_ok 't::Class1' };

throws_ok { t::Class1->new } qr/Missing required arguments: num/,
    'required args checked';

throws_ok { t::Class1->new( num => "zof" ) } qr/Must be a positive number/,
    'type is checked';

{
    my $c = t::Class1->new( num => 42 );
    is $c->_num,  42,          '->_num is correct';
    is $c->_type, 'text/html', '->_type is correct';
    is $c->_cust, 'Zoffix',    '->_cust is correct';
    ok ! defined $c->_bool,    '->_bool is correct (undefined)';

    isa_ok $c->chained("foo")->chained2( 45 ), 't::Class1',
        'chained attributes return invocants';

    is $c->chained, "foo", 'chained attributes update values';
    is $c->chained2, 45,   'chained attributes update values';
}

{
    my $c = t::Class1->new(num => 43, bool => 1, _cust => 'Bar', type => 'fo');
    is $c->_num,  43,    '->_num is correct';
    is $c->_type, 'fo',  '->_type is correct';
    is $c->_cust, 'Bar', '->_cust is correct';
    is $c->_bool, 1,     '->_bool is correct';
}

done_testing;