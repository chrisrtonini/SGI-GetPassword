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

=encoding utf8

=head1 NOME

SGI::GetPassword - UtilitE<aacute>rio para coleta de senhas via prompt 
(caracter).

=head1 VERSE<Atilde>O

VersE<atilde>o 0.02

=cut

our $VERSION = '0.02';


=head1 SINOPSE

Classe estE<aacute>tica que implementa mecanismo para coleta de senhas. Onde,
a cada caracter digitado, apresenta apenas "*" na tela. Ignora caracteres
especiais, processando apenas I<backspace>/I<del> e I<enter>.
Retorna a senha digitada, em formato texto.

Exemplo de uso:

    use SGI::GetPassword;
    
    ...
    
    my $password = SGI::GetPassword::Get();
    
    ...
    
ou
    ...
    
    my $password = SGI::GetPassword::Get("Informe a senha: ");
    
    ...
    

B<IMPORTANTE>:

=over 4

=item * O canal de I<output> utilizado sempre serE<aacute> I<stderr>.

=item * O E<uacute>nicos caracteres de controle processados sE<atilde>o: 
ENTER, DEL e BACKSPACE (respectivamente, ASCII 10, 127 e 8). Demais teclas,
cujos cE<oacute>digos de varredura sejam inferiores a ASCII 32 
(espaE<ccedil>o) serE<atilde>o ignoradas.

=back
    

=head1 ME<Eacute>TODOS

=cut

=head2 Get()

Exibe o I<prompt> (opcional) e coleta a senha no terminal, obscurecendo sua 
digitaE<ccedil>E<atilde>o.

=head3 ParE<acirc>metro(s):

=over 4

=item * prompt

Texto a ser exibido na tela (via I<stderr>) imediatamente antes da 
solicitaE<ccedil>E<atilde>o da senha.

=back

=head3 CrE<eacute>ditos:

=over 4

ImplementaE<ccedil>E<atilde>o original: 
L<http://stackoverflow.com/questions/701078/how-can-i-enter-a-password-using-perl-and-replace-the-characters-with>

Autor: 
L<Pierre-Luc Simard|http://stackoverflow.com/users/68554/pierre-luc-simard>.

=back

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
			
			#           --== DEL/BACKSPACE pressionado ==--
			
			# 1) remove o último caracter da senha
			# Obs.: "if" abaixo acrescentado por Chris
			chop($password) if (length($password) > 0);
			
			# 2) retroceder o cursor em uma posição, imprimir um espaço em 
			#		branco, e novamente retroceder o cursor uma posição
			print STDERR "\b \b";
		}
		elsif (ord($key) < 32)	{
			# Ignorar cacteres de controle
			print chr(7);
			
			# TODO: substituir o 'chr(7)' (ASCII bel) pelo 
			#		módulo Audio::Beep.
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

Chris Robert Tonini, C<< <chrisrtoniniE<64>gmail.com> >>


=head1 BUGS

Qualquer necessidade de implementaE<ccedil>E<atilde>o ou registro de I<bug>
pode ser informado no repositE<oacute>rio do projeto:
L<https://github.com/chrisrtonini/SGI-GetPassword>.


=head1 SUPORTE

InformaE<ccedil>E<otilde>es sobre este mE<oacute>dulo podem ser obtidas de
duas maneiras.

=over 4

=item * Pelo comando perldoc:

    perldoc SGI::GetPassword

=item * Acessando o repositE<oacute>rio do projeto:

L<https://github.com/chrisrtonini/SGI-GetPassword>

=back


=head1 DECLARAE<Ccedil>E<Otilde>ES

=head1 LICENE<Ccedil>A E COPYRIGHT

Copyright 2015 Chris Robert Tonini.

Este programa E<eacute> I<software> livre; vocE<ecirc> pode 
redistribuE<iacute>-lo e/ou modificE<aacute>-lo sob os termos da 
B<GNU Lesser General Public License>, publicada pela 
Free Software Foundation; em sua versE<atilde>o 2.1

Este programa E<eacute> distribuE<iacute>do na esperanE<ccedil>a de que lhe 
seja E<uacute>til, mas B<SEM QUALQUER GARANTIA>; nem mesmo a garantia 
implE<iacute>cita de B<COMERCIALIZAE<Ccedil>E<Atilde>O> ou 
B<ADAPTAE<Ccedil>E<Atilde>O A UM PROPE<Oacute>SITO PARTICULAR>. Leia
a B<GNU Lesser General Public License> para mais detalhes.

Caso vocE<ecirc> nE<atilde>o tenha recebido uma cE<oacute>pia da 
B<GNU Lesser General Public License> juntamente com este programa, 
E<eacute> possE<iacute>vel obtE<ecirc>-la no endereE<ccedil>o: 
L<http://www.gnu.org/copyleft/lesser.html>.

=cut


1; # End of SGI::GetPassword
