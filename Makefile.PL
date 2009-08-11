use 5.006001;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME			=> "String::MkPasswd",
	VERSION_FROM	=> "lib/String/MkPasswd.pm",
	PREREQ_PM		=> {
		"File::Basename"	=>  0,
		"Getopt::Long"		=>  0,
		"Test::More"		=>  0,
		"Text::Wrap"		=>  0,
	},
	EXE_FILES		=> [ "bin/mkpasswd.pl" ],
	($] >= 5.005
		? (
			ABSTRACT_FROM	=> "lib/String/MkPasswd.pm",
			AUTHOR			=> "Chris Grau <cgrau\@cpan.org>",
		)
		: ()
	),
);
