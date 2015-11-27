package Class;

use lib qw{lib ../lib};
use Mew;
# has  _foo  => PositiveNum;
# has -_bar  => Bool;  # note the minus: it means attribute is not `required`
# has  _type => Str, (default => 'text/html');
has  _cust => ( is => 'ro', isa => sub{ 42 } ); # standard Moo `has`

1;

package main;

my $c = Class->new;

say $c->_cust;


