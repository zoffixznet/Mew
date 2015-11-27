# NAME

Mew - Moo with sugar on top

# SYNOPSIS

<div>
    <div style="display: table; height: 91px; background: url(http://zoffix.com/CPAN/Dist-Zilla-Plugin-Pod-Spiffy/icons/section-code.png) no-repeat left; padding-left: 120px;" ><div style="display: table-cell; vertical-align: middle;">
</div>

    # This:
    use Mew;
    has  _foo  => PositiveNum;
    has -_bar  => Bool;  # note the minus: it means attribute is not `required`
    has  _type => Str, (default => 'text/html');
    has  _cust => ( is => 'ro', isa => sub{ 42 } ); # standard Moo `has`

    # Is same as:
    use strictures 2;
    use Types::Standard qw/:all/;
    use Types::Common::Numeric qw/:all/;
    use Moo;
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

<div>
    </div></div>
</div>

# DESCRIPTION

This module is just like regular [Moo](https://metacpan.org/pod/Moo), except it also imports
[strictures](https://metacpan.org/pod/strictures) and [namespace::clean](https://metacpan.org/pod/namespace::clean), along with
a couple of standard types modules. In addition, it sweetens the
[Moo's has subroutine](https://metacpan.org/pod/Moo#has) to allow for more concise attribute
declarations.

# READ FIRST

Virtually all of the functionality is described in [Moo](https://metacpan.org/pod/Moo).

# IMPORTED MODULES

    use Mew;

Automatically imports the following modules: [Moo](https://metacpan.org/pod/Moo), [strictures](https://metacpan.org/pod/strictures),
[Types::Standard](https://metacpan.org/pod/Types::Standard), [Types::Common::Numeric](https://metacpan.org/pod/Types::Common::Numeric),
and [namespace::clean](https://metacpan.org/pod/namespace::clean). **NOTE: in particular the last one.** It'll scrub
your namespace, thus if you're using things like [experimental](https://metacpan.org/pod/experimental), you should
declare them **after** you `use Mew`.

# `has` SUGAR

## Call it like if it were Moo

    has _cust => ( is => 'ro' );

First, you can call `has` just like you'd call ["has" in Moo](https://metacpan.org/pod/Moo#has) and it'll work
exactly as it used to. The sugar won't be enabled in that case.

## Specify `isa` type to get sugar

    has _cust => Str;
    has _cust => Str, ( default => "foo" ); # Note: can't use "=>" after Str

To get the sugar, you need to specify one of the imported types from either
[Types::Standard](https://metacpan.org/pod/Types::Standard) or [Types::Common::Numeric](https://metacpan.org/pod/Types::Common::Numeric) as the second argument. Once
that is done, `Mew` will add some default settings, which are:

    1) Set `isa` to the type you gave
    2) Set `is` to 'ro'
    3) Set `require` to 1
    4) Set `init_arg` to the name of the attribute, removing
        the leading underscore, if it's present

Thus, `has _cust => Str;` is equivalent to

    use Types::Standard qw/Str/;
    has _cust => (
        init_arg => 'cust',
        is       => 'ro'
        isa      => Str,
        required => 1,
    );

<div>
    <div style="display: table; height: 91px; background: url(http://zoffix.com/CPAN/Dist-Zilla-Plugin-Pod-Spiffy/icons/section-warning.png) no-repeat left; padding-left: 120px;" ><div style="display: table-cell; vertical-align: middle;">
</div>

**IMPORTANT NOTE:** because Perl's fat comma (`=>`) quotes the argument
on the left side, using it after the type won't work:

    has _cust => Str => ( default => "BROKEN" ); # WRONG!!!!
    has _cust => Str, ( default => "WORKS" ); # Correct!
    has _cust => ( Str, default => "WORKS" ); # This is fine too

<div>
    </div></div>
</div>

### Modify the sugar

It's possible to alter the defaults created by `Mew`:

#### Remove `required`

    has -_cust => Str;

Simply prefix the attribute's name with a minus sign to avoid setting
`required => 1`.

#### Modify other options

    has  _cust => Str, ( init arg => "bar" );
    has -_cust => Str, ( is => "lazy" );

You can explicitly provide values for options set by `Mew`, in which case
the values you provide will be used instead of the defaults.

# SEE ALSO

[Moo](https://metacpan.org/pod/Moo), [Type::Tiny](https://metacpan.org/pod/Type::Tiny)

<div>
    <div style="background: url(http://zoffix.com/CPAN/Dist-Zilla-Plugin-Pod-Spiffy/icons/hr.png);height: 18px;"></div>
</div>

# REPOSITORY

<div>
    <div style="display: table; height: 91px; background: url(http://zoffix.com/CPAN/Dist-Zilla-Plugin-Pod-Spiffy/icons/section-github.png) no-repeat left; padding-left: 120px;" ><div style="display: table-cell; vertical-align: middle;">
</div>

Fork this module on GitHub:
[https://github.com/zoffixznet/Mew](https://github.com/zoffixznet/Mew)

<div>
    </div></div>
</div>

# BUGS

<div>
    <div style="display: table; height: 91px; background: url(http://zoffix.com/CPAN/Dist-Zilla-Plugin-Pod-Spiffy/icons/section-bugs.png) no-repeat left; padding-left: 120px;" ><div style="display: table-cell; vertical-align: middle;">
</div>

To report bugs or request features, please use
[https://github.com/zoffixznet/Mew/issues](https://github.com/zoffixznet/Mew/issues)

If you can't access GitHub, you can email your request
to `bug-Mew at rt.cpan.org`

<div>
    </div></div>
</div>

# AUTHOR

Part of the code was borrowed from [Moo](https://metacpan.org/pod/Moo)'s innards. [ew](https://metacpan.org/pod/ew) module is an
almost-verbatim copy of [oo](https://metacpan.org/pod/oo) module. Props to _Altreus_ for coming up with
the name for the module.

The rest is:

<div>
    <div style="display: table; height: 91px; background: url(http://zoffix.com/CPAN/Dist-Zilla-Plugin-Pod-Spiffy/icons/section-author.png) no-repeat left; padding-left: 120px;" ><div style="display: table-cell; vertical-align: middle;">
</div>

<div>
    <span style="display: inline-block; text-align: center;"> <a href="http://metacpan.org/author/ZOFFIX"> <img src="http://www.gravatar.com/avatar/328e658ab6b08dfb5c106266a4a5d065?d=http%3A%2F%2Fwww.gravatar.com%2Favatar%2F627d83ef9879f31bdabf448e666a32d5" alt="ZOFFIX" style="display: block; margin: 0 3px 5px 0!important; border: 1px solid #666; border-radius: 3px; "> <span style="color: #333; font-weight: bold;">ZOFFIX</span> </a> </span>
</div>

<div>
    </div></div>
</div>

# LICENSE

You can use and distribute this module under the same terms as Perl itself.
See the `LICENSE` file included in this distribution for complete
details.
