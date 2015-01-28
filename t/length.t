#!perl

use strict;
use warnings;
use Test::More 0.96;

use String::MkPasswd 'mkpasswd';

is +( length mkpasswd( -length => 0 ) ), 9, '-length => 0';

for ( 1 .. 6 ) {
	ok +( !defined mkpasswd( -length => $_ ) ), "-length => $_";
}

for ( 7 .. 20 ) {
	is +( length mkpasswd( -length => $_ ) ), $_, "-length => $_";
}

done_testing;
