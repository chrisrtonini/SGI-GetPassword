#
# SGI::GetPassword
#
# Copyright 2015 Chris Robert Tonini <chrisrtonini@gmail.com>
#
package SGI::GetPassword;

use 5.008000;
use strict;
use warnings FATAL => 'all';

use Term::ReadKey;
use FileHandle;

=encoding cp850

=head1 NOME

SGI::GetPassword - Utilitario para coleta de senhas via prompt (caracter).

=head1 VERSAE<Atilde>O

VersE<atilde>o 0.01

=cut

our $VERSION = '0.01';


=head1 SINOPSE

Classe estE<aacute>tica que implementa mecanismo para coleta de senhas, 
ignorando caracteres especiais, processando apenas BACKSPACE e ENTER. 
Retorna a senha digitada em formato texto, no entanto, durante a coleta, 
exibe apenas "*" na tela.

O canal de I<echo> e coleta e B<I<STDERR>>, e a tecla ENTER finaliza a leitura.

    use SGI::GetPassword;
    
    my $password = SGI::GetPassword::Get();
    
    ...
    
ou
    
    my $password = SGI::GetPassword::Get("Informe a senha: ");
    ...
    

=head1 ME<Eacute>TODOS

=cut

=head2 Get()

ME<eacute>todo que efetua a coleta da senha obscurecida, na linha de comando.

Adaptado de: 

	L<http://stackoverflow.com/questions/701078/how-can-i-enter-a-password-using-perl-and-replace-the-characters-with>

Autor:

	L<Pierre-Luc Simard|http://stackoverflow.com/users/68554/pierre-luc-simard>.

=cut

sub Get	{
	my $prompt		= shift;
	my $key			= 0;
	my $password	= "";
	
	# Exibir o prompt, caso definido
	STDERR->autoflush(1);
	print STDERR "$prompt" if ($prompt);
	
	# Desabilitar teclas de controle
	ReadMode(4);
	
	# O laço de leitura continua até que a tecla ENTER seja pressionada
	# (identificada pelo valor ASCII "10")
	while (ord($key = ReadKey(0)) != 10)	{
		# Consulte valores para ord($key) em http://www.asciitable.com/
		if (ord($key) == 127 || ord($key) == 8)	{
			# DEL/BACKSPACE pressionado
			# 1) remove o último caracter da senha
			# Obs.: "if" abaixo acrescentado por Chris
			chop($password) if (length($password) > 0);
			# 2) retroceder o cursor em uma posição, imprimir um espaço em 
			#		branco, e novamente retroceder o cursor uma posição
			print STDERR "\b \b";
		}
		elsif (ord($key) < 32)	{
			# Ignorar cacteres de controle
		}
		else	{
			$password .= $key;
			print STDERR "*";
		}
	}
	
	# Concluída a coleta, resetar o terminal
	ReadMode(0);
	print STDERR "\n";
	
	return ($password);
}


=head1 AUTOR

Chris Robert Tonini, C<< <chrisrtonini at gmail.com> >>


=head1 BUGS

Favor reportar qualquer bug ou necessidade de modificaE<ccedil>E<atilde>o a
C<chrisrtonini at gmail.com>, ou pela interface do ServiE<ccedil>o de
Atendimento ao Cliente (SAC) no endereE<ccedil>o 
L<http://sac.sgisistemas.com.br>. Eu serei notificado e retornarei 
informaE<ccedil>E<otilde>es sobre o andamento das 
modificaE<ccedil>E<otilde>es realizadas.


=head1 SUPORTE

E<Eacute> possE<iacute>vel encontrar documentaE<ccedil>E<atilde>o para este
mE<oacute>dulo com o comando perldoc.

    perldoc SGI::GetPassword


VocE<ecirc> pode tambE<eacute>m buscar informaE<ccedil>E<otilde>es em:

=over 4

=item * RepositE<oacute>rio de fontes do projeto

L<https://github.com/chrisrtonini/SGI-GetPassword>

=back


=head1 DECLARAE<Ccedil>E<Otilde>ES


=head1 LICENE<Ccedil>A E COPYRIGHT

Copyright 2015 Chris Robert Tonini.

Este programa e' software livre; voce pode redistribui-lo e/ou
modifica-lo sob os termos da GNU Lesser General Public License,
publicada pela Free Software Foundation; em sua versao 2.1

Este programa e' distribuido na esperanca de que lhe seja util,
mas SEM QUALQUER GARANTIA; nem mesmo a garantia implicita de
COMERCIALIZACAO ou ADAPTACAO A UM PROPOSITO PARTICULAR.  Veja
a GNU Lesser General Public License para mais detalhes.

Caso voce nao tenha recebido uma copia da GNU Lesser General
Public License juntamente com este programa, e' possivel obte-la
no endereco: http://www.gnu.org/copyleft/lesser.html.

=cut


1; # End of SGI::GetPassword
