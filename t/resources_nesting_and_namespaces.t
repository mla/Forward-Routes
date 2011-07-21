#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 4;

use Forward::Routes;



#############################################################################
### nested resources and namespaces

# magazine routes
my $r = Forward::Routes->new;
my $ads = $r->add_resources('magazines' => -namespace => 'Admin')
  ->add_resources('ads');

my $m = $r->match(get => 'magazines');
is $m->[0]->name, 'admin_magazines_index';

$m = $r->match(get => 'magazines/4/ads/new');
is $m->[0]->name, 'admin_magazines_ads_create_form';



# nested routes also has namespace
$r = Forward::Routes->new;
$ads = $r->add_resources('magazines' => -namespace => 'Admin')
  ->add_resources('ads' => -namespace => 'Admin');

$m = $r->match(get => 'magazines/4/ads/new');
is $m->[0]->name, 'admin_magazines_admin_ads_create_form';



# controller namespace organized exactly as resource nesting
$r = Forward::Routes->new;
$ads = $r->add_resources('magazines' => -namespace => 'Admin')
  ->add_resources('ads' => -namespace => 'Admin::Magazines');

$m = $r->match(get => 'magazines/4/ads/new');
is $m->[0]->name, 'admin_magazines_admin_magazines_ads_create_form';
