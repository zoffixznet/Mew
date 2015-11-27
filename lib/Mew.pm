package Mew;

use strictures 2;
use Import::Into;
use utf8;
use Moo;

sub import {
    strictures->import::into(1);
    Moo->import::into(1);
    MooX::ChainedAttributes->import::into(1);
    Types::Standard->import::into(1, qw/:all/);
    Types::Common::Numeric->import::into(1, qw/:all/);
    namespace::clean->import::into(1);

    my $class = caller;
    no strict 'refs';
    no warnings 'redefine';
    *{"${class}::has"} = \&_has;
}

sub _has {
    my ( $arg, @settings ) = @_;
    # shift @settings;
    use Acme::Dump::And::Dumper;
    warn DnD [ @settings ];
    has $arg => (@settings);
}

# VERSION

q|
    To err is human -- and to blame it on a computer is even more so
|;

__END__

=encoding utf8

=for stopwords Znet Zoffix

=head1 NAME

Mew - Moo with sugar on top

=head1 SYNOPSIS

=for pod_spiffy start code section

    # This:
    use Mew;
    has  _foo  => PositiveNum;
    has -_bar  => Bool;  # note the minus: it means attribute is not `required`
    has  _type => Str, (default => 'text/html');
    has  _cust => ( is => 'ro', isa => sub{ 42 } ); # standard Moo `has`

    # Is same as:
    use strictures 2;
    use Types::Standard;
    use Types::Common::Numeric;
    use Moo;
    use MooX::ChainedAttributes;
    use namespace::clean;

    has _foo  => (
        init_arg => 'foo',
        is       => 'ro'
        isa      => PositiveNum,
        required => 1,
    );
    has _bar  => (
        init_arg => 'bar',
        is       => 'ro'
        isa      => Bool,
    );
    has _type  => (
        init_arg => 'type',
        is       => 'ro'
        isa      => Str,
        default  => 'text/html',
    );
    has _cust => (
        is  => 'ro',
        isa => sub{ 42 },
    );

=for pod_spiffy end code section

=head1 WARNING

=for pod_spiffy start warning section

This module is currently experimental. Things might change.

=for pod_spiffy end warning section

=head1 DESCRIPTION

This module is just like regular L<Moo>, except it also imports
L<strictures> and L<namespace::clean>, along with
a couple of standard types modules. In addition, it sweetens the L<Moo/has>
subroutine to allow for more concise attribute declarations.

=head1 READ FIRST

Virtually all the functionality is describe in L<Moo>.

=head1 IMPORTED MODULES

    use Mew;

Automatically imports the following modules: L<Moo>, L<strictures>,
L<Types::Standard>, L<Types::Common::Numeric>, L<MooX::ChainedAttributes>,
and L<namespace::clean>. B<NOTE: in particular the last one.> It'll scrub
your namespace, thus if you're using things like L<experimental>, you should
declare them B<after> you C<use Mew>.

=head1 C<_has> SUGAR

=head1 SEE ALSO

L<Moo>, L<Type::Tiny>

=for pod_spiffy hr

=head1 REPOSITORY

=for pod_spiffy start github section

Fork this module on GitHub:
L<https://github.com/zoffixznet/Mew>

=for pod_spiffy end github section

=head1 BUGS

=for pod_spiffy start bugs section

To report bugs or request features, please use
L<https://github.com/zoffixznet/Mew/issues>

If you can't access GitHub, you can email your request
to C<bug-Mew at rt.cpan.org>

=for pod_spiffy end bugs section

=head1 AUTHOR

=for pod_spiffy start author section

=for pod_spiffy author ZOFFIX

=for pod_spiffy end author section

=head1 LICENSE

You can use and distribute this module under the same terms as Perl itself.
See the C<LICENSE> file included in this distribution for complete
details.

=cut