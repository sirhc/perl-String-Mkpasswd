#!perl

use strict;
use warnings;
use Test::More 0.96;

use String::MkPasswd 'mkpasswd';

my $ITERATIONS = 100;                            # sufficiently large to overcome probability
my $AMBIGUOUS  = qr/[o01ilvwc|_\-.,:;\[\](){}]/; # keys of String::MkPasswd::IS_AMBIGUOUS in regex form

subtest 'Test distributed passwords with "-noambiguous" enabled' => sub {
	for ( 1 .. $ITERATIONS ) {
		unlike mkpasswd( -dist => 1, -noambiguous => 1 ), $AMBIGUOUS, 'Distributed password contains no ambiguous characters';
	}
};

subtest 'Test non-distributed passwords with "-noambiguous" enabled' => sub {
	for ( 1 .. $ITERATIONS ) {
		unlike mkpasswd( -dist => 0, -noambiguous => 1 ), $AMBIGUOUS, 'Non-distributed password contains no ambiguous characters';
	}
};

done_testing;
