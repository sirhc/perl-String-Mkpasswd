#!/usr/bin/env perl

use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'String::MkPasswd',
    AUTHOR        => 'Chris Grau <cgrau@cpan.org>',
    VERSION_FROM  => 'lib/String/MkPasswd.pm',
    ABSTRACT_FROM => "lib/String/MkPasswd.pm",
    EXE_FILES     => [ 'bin/mkpasswd.pl' ],
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz' },
    clean         => { FILES => 'String-MkPasswd-*' },
);
