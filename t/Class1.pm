package t::Class1;

use Mew;

has  _num  => PositiveNum;
has -_bool => Bool;
has  _type => Str, (default => 'text/html');
has  _cust => ( is => 'rw', default => 'Zoffix' );

1;