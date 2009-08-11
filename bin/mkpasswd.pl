#!/usr/bin/perl

use 5.006001;
use strict;

use File::Basename qw(basename);
use Getopt::Long qw(GetOptions);
use String::MkPasswd qw(mkpasswd);
use Text::Wrap qw(wrap);

# Defaults.
use constant LENGTH		=> 9;
use constant MINNUM		=> 2;
use constant MINLOWER	=> 2;
use constant MINUPPER	=> 2;
use constant MINSPECIAL	=> 1;
use constant DISTRIBUTE	=> "";
#use constant VERBOSE	=> "";
#use constant PASSWD		=> "/bin/passwd";

# Configuration.
my $length		= LENGTH;
my $minnum		= MINNUM;
my $minlower	= MINLOWER;
my $minupper	= MINUPPER;
my $minspecial	= MINSPECIAL;
my $distribute	= DISTRIBUTE;
#my $verbose	= VERBOSE;
#my $passwd		= PASSWD;
my $help		= "";

Getopt::Long::Configure("bundling");
my $getopt = GetOptions(
	"length|l=i"	=> \$length,
	"digits|d=i"	=> \$minnum,
	"lower|c=i"		=> \$minlower,
	"upper|C=i"		=> \$minupper,
	"special|s=i"	=> \$minspecial,
	"distribute|2"	=> \$distribute,
	#"verbose|v"		=> \$verbose,
	#"passwd|p"		=> \$passwd,
	"help|h"		=> \$help,
);

if ( $help ) {
	&usage();
	exit 0;
}

if ( !$getopt ) {
	&usage();
	exit 1;
}

my $pass = mkpasswd(
	-length		=> $length,
	-digits		=> $minnum,
	-lower		=> $minlower,
	-upper		=> $minupper,
	-special	=> $minspecial,
	-distribute	=> $distribute,
);

if ( !$pass ) {
	$Text::Wrap::columns = 72;
	print STDERR wrap("", "",
		"Impossible to generate $length-character password with $minnum "
		. "numbers, $minlower lowercase letters, $minupper uppercase letters "
		. "and $minspecial special characters.\n"
	);
	exit 1;
}

print "$pass\n";
exit 0;

sub usage {
	print <<EOF;
Usage: @{[ basename $0 ]} [-options]
    -l # | --length=#   length of password (default = @{[ LENGTH ]})
    -d # | --digits=#   min # of digits (default = @{[ MINNUM ]})
    -c # | --lower=#    min # of lowercase chars (default = @{[ MINLOWER ]})
    -C # | --upper=#    min # of uppercase chars (default = @{[ MINUPPER ]})
    -s # | --special=#  min # of special chars (default = @{[ MINSPECIAL ]})
    -2 | --distribute   alternate hands
EOF
}

__END__

=head1 NAME

mkpasswd.pl - example to generate new password with String::MkPasswd

=head1 SYNOPSIS

  mkpasswd.pl [-options]

  #!/bin/sh
  NEW_PASSWD=`mkpasswd.pl`

=head1 DESCRIPTION

This program generates a random password, allowing for some tuning of
character distribution.  The password is sent to standard output.

=head2 OPTIONS

=over 4

=item -l # | --length=#

The total length of the password.  The default is 9.

=item -d # | --digits=#

The minimum number of digits that will appear in the final password.
The default is 2.

=item -c # | --lower=#

The minimum number of lower-case characters that will appear in the
final password.  The default is 2.

=item -C # | --upper=#

The minimum number of upper-case characters that will appear in the
final password.  The default is 2.

=item -s # | --special=#

The minimum number of non-alphanumeric characters that will appear in
the final password.  The default is 1.

=item -2 | --distribute

If specified, password characters will be distributed between the left-
and right-hand sides of the keyboard.  This makes it more difficult for
an onlooker to see the password as it is typed.

=back

=head1 BUGS

=over 4

=item *

The .pl extension has been added to avoid conflict with the program of
the same name distributed with Expect.

=back

=head1 TODO

=over 4

=item *

For completeness, add user password setting functionality as found in
Expect's L<mkpasswd(1)> example.

=back

=head1 SEE ALSO

L<http://expect.nist.gov/#examples>,
L<mkpasswd(1)>,
L<String::MkPasswd>

=head1 AKNOWLEDGEMENTS

Don Libes of the National Institute of Standards and Technology, who
wrote the Expect example, L<mkpasswd(1)>.

=head1 AUTHOR

Chris Grau E<lt>cgrau@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2003 by Chris Grau

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself, either Perl version 5.8.1 or, at
your option, any later version of Perl 5 you may have available.

=cut
