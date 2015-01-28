#!perl

use strict;
use warnings;
use Test::More 0.96;

use String::MkPasswd 'mkpasswd';

my $passwd;

$passwd = mkpasswd();

subtest "Testing password $passwd", sub {
    is +( length $passwd ),    9, 'length';
    is count_digits($passwd),  2, 'digits';
    is count_lower($passwd),   4, 'lower';
    is count_upper($passwd),   2, 'upper';
    is count_special($passwd), 1, 'special';
};

$passwd = mkpasswd(
	-length		=> 20,
	-minnum		=> 4,
	-minlower	=> 7,
	-minupper	=> 6,
	-minspecial	=> 3,
);

subtest "Testing password $passwd", sub {
    is +( length $passwd ),   20, 'length';
    is count_digits($passwd),  4, 'digits';
    is count_lower($passwd),   7, 'lower';
    is count_upper($passwd),   6, 'upper';
    is count_special($passwd), 3, 'special';
};

$passwd = mkpasswd(
	-minnum	=> 0,
);

subtest "Testing password $passwd", sub {
    is +( length $passwd ),    9, 'length';
    is count_digits($passwd),  0, 'digits';
    is count_lower($passwd),   6, 'lower';
    is count_upper($passwd),   2, 'upper';
    is count_special($passwd), 1, 'special';
};

$passwd = mkpasswd(
	-minlower	=> 0,
);

subtest "Testing password $passwd", sub {
    is +( length $passwd ),    9, 'length';
    is count_digits($passwd),  2, 'digits';
    is count_lower($passwd),   4, 'lower';
    is count_upper($passwd),   2, 'upper';
    is count_special($passwd), 1, 'special';
};

$passwd = mkpasswd(
	-minupper	=> 0,
);

subtest "Testing password $passwd", sub {
    is +( length $passwd ),    9, 'length';
    is count_digits($passwd),  2, 'digits';
    is count_lower($passwd),   6, 'lower';
    is count_upper($passwd),   0, 'upper';
    is count_special($passwd), 1, 'special';
};

$passwd = mkpasswd(
	-minspecial	=> 0,
);

subtest "Testing password $passwd", sub {
    is +( length $passwd ),    9, 'length';
    is count_digits($passwd),  2, 'digits';
    is count_lower($passwd),   5, 'lower';
    is count_upper($passwd),   2, 'upper';
    is count_special($passwd), 0, 'special';
};

$passwd = mkpasswd(
	-minnum		=> 0,
	-minlower	=> 0,
	-minupper	=> 0,
	-minspecial	=> 0,
);

subtest "Testing password $passwd", sub {
    is +( length $passwd ),    9, 'length';
    is count_digits($passwd),  0, 'digits';
    is count_lower($passwd),   9, 'lower';
    is count_upper($passwd),   0, 'upper';
    is count_special($passwd), 0, 'special';
};

$passwd = mkpasswd(
	-length		=> 3,
	-minnum		=> 3,
	-minlower	=> 0,
	-minupper	=> 0,
	-minspecial	=> 0,
);

subtest "Testing password $passwd", sub {
    is +( length $passwd ),    3, 'length';
    is count_digits($passwd),  3, 'digits';
    is count_lower($passwd),   0, 'lower';
    is count_upper($passwd),   0, 'upper';
    is count_special($passwd), 0, 'special';
};

done_testing;

sub count_digits {
	my $re = qr/([0-9])/;
	my $count = 0;
	$count++ while $_[0] =~ /$re/g;
	return $count;
}

sub count_lower {
	my $re = qr/([a-z])/;
	my $count = 0;
	$count++ while $_[0] =~ /$re/g;
	return $count;
}

sub count_special {
	my $re = qr/([!@#\$%~^&*()=_+\[\]{}\\|;:'"<>,.?\/-])/;
	my $count = 0;
	$count++ while $_[0] =~ /$re/g;
	return $count;
}

sub count_upper {
	my $re = qr/([A-Z])/;
	my $count = 0;
	$count++ while $_[0] =~ /$re/g;
	return $count;
}
