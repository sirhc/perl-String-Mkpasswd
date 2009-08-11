%define module      String-MkPasswd
%define query       String%3A%3AMkPasswd
%define perldir     %{_libdir}/perl5
%define perlversion %(perl -V:version | cut -d\\' -f2)

# Provide perl-specific find-{provides,requires}.
%define __find_provides /usr/lib/rpm/find-provides.perl
%define __find_requires /usr/lib/rpm/find-requires.perl

Summary: A random password generator for Perl 5.
Name: perl-%{module}
Version: 0.02
Release: 1
URL: http://search.cpan.org/search?query=%{query}
License: Artistic
Group: Applications/CPAN
Source: %{module}-%{version}.tar.gz
Requires: perl >= 5.6.1
Requires: perl(File::Basename)
Requires: perl(Getopt::Long)
Requires: perl(Text::Wrap)
BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-%{version}-buildroot
BuildRequires: perl >= 5.6.1
BuildRequires: perl(Test::More)
BuildPrereq: perl(File::Basename)
BuildPrereq: perl(Getopt::Long)
BuildPrereq: perl(Text::Wrap)

%description
The String::MkPasswd module provides the mkpasswd() function which, by
default, will return a fairly secure password.  The number of letters,
numbers and special characters in the password can be customized.

The mkpasswd.pl program is also included as a front-end to the
mkpasswd() function.

%prep
%setup -q -n %{module}-%{version} 

%build
%{__perl} Makefile.PL PREFIX=%{buildroot}/usr INSTALLDIRS=vendor
%{__make}

%install
[ -n "%{buildroot}" -a "%{buildroot}" != "/" ] && rm -rf %{buildroot}
%makeinstall

# We install everything into `vendor_perl' so the `$version' dir isn't needed.
%{__rm} -rf %{buildroot}%{perldir}/%{perlversion}

%clean
[ -n "%{buildroot}" -a "%{buildroot}" != "/" ] && rm -rf %{buildroot}

%files
%defattr(-,root,root)
%doc Changes README
%{_bindir}/*
%{_libdir}/perl5/*
%{_mandir}/*/*

%changelog
* Wed Mar 17 2004 Chris Grau <cgrau@cpan.org> 0.02-1
- Applied changes from Adrian Gee <adrian.gee@anu.edu.au> allowing
  -minnum, -minlower, -minupper and -minspecial to be zero in the call
  to mkpasswd().
- Added --no{num,lower,upper,special} options to mkpasswd.pl as
  alternatives to --min{num,lower,upper,special}=0.

* Thu Nov 13 2003 Chris Grau <cgrau@cpan.org> 0.01-1
- Initial .spec file generation.
