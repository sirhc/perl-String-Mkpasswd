#!/usr/bin/env perl

use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'String::MkPasswd',
    license           => 'perl',
    dist_author       => 'Chris Grau <cgrau@cpan.org>',
    dist_version_from => 'lib/String/MkPasswd.pm',
    add_to_cleanup => [ 'String-MkPasswd-*' ],
);

$builder->create_build_script;
