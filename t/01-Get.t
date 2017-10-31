#!perl -T
use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 2;

diag( "\nTestando invocacao de metodo 'Get'" );

require_ok('SGI::GetPassword') or
	BAIL_OUT "O modulo 'SGI::GetPassword' nao pode ser carregado!";

diag( "\nVerificando metodo (estatico)." );

can_ok('SGI::GetPassword', qw(Get));
