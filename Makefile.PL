use 5.008;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME				=> 'SGI::GetPassword',
    AUTHOR				=> q{Chris Robert Tonini <chrisrtonini@gmail.com>},
    VERSION_FROM		=> 'lib/SGI/GetPassword.pm',
    ABSTRACT_FROM		=> 'lib/SGI/GetPassword.pm',
    LICENSE				=> 'lgpl',
    NO_META				=> 1,
    NO_MYMETA			=> 1,
    PL_FILES			=> {},
    MIN_PERL_VERSION	=> '5.008',
    CONFIGURE_REQUIRES	=> {
        'ExtUtils::MakeMaker'	=> '0',
    },
    BUILD_REQUIRES		=> {
        'Test::More'			=> '0',
    },
    PREREQ_PM			=> {
		'Term::ReadKey'			=> '0',
		'FileHandle'			=> '0',
    },
    dist				=> {
		COMPRESS				=> 'gzip -9f', SUFFIX => 'gz',
	},
    clean				=> {
		FILES					=> 'SGI-GetPassword-*'
	},
);
