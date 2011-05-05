#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use Forward::Routes;

use Test::More tests => 7;


#############################################################################
### to method

my $r = Forward::Routes->new;

# default singularize
is $r->singularize->('users'), 'user';
is $r->singularize->('queries'), 'query';

# overwrite singularize
my $code_ref = sub {return shift;};
is ref $r->singularize($code_ref), 'Forward::Routes';

is $r->singularize, $code_ref;
is $r->singularize->('users'), 'users';

# works for child routes
my $child = $r->add_route;

is $child->singularize, $code_ref;
is $child->singularize->('users'), 'users';