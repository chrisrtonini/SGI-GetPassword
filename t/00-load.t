#!perl -T
use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

require_ok('SGI::GetPassword') or
	BAIL_OUT "O modulo 'SGI::GetPassword' nao pode ser carregado!";

diag( "Testando SGI::GetPassword $SGI::GetPassword::VERSION, Perl $], $^X" );
