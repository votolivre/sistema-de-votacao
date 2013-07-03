#!/usr/bin/perl -I/home/votolivre/perl5/lib/perl5
require('lib-cic.pl');
require('lib-captcha.pl');
use CGI qw(:standard);
use Business::BR::CPF;
use Digest::MD5 qw(md5 md5_hex md5_base64);

use DBI;

require ('db-config.pl');

$atr = "DBI:$driver:database=$meudb;host=$host";
$conn = DBI->connect ($atr, $user, $pass);

&data;
&data_pra_bd;

sleep(1);

print "Content-type:text/html\n\n";

$form_hidden_c = param(form_hidden_c);

# verifica��o (valida��o) dos dados entrados no formul�rio

# verificando se a pessoa digitou o t�tulo
$var = param(titulo);
if (!$var) {
  $problemas = 1;
  $causa = "&bull\; Digite seu <strong>T&Iacute\;TULO DE ELEITOR</strong>.";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou a zona
$var = param(zona);
if (!$var) {
  $problemas = 1;
  $causa = "&bull\; Digite sua <strong>ZONA ELEITORAL</strong>.";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou a se��o eleitoral
$var = param(secao);
if (!$var) {
  $problemas = 1;
  $causa = "&bull\; Digite sua <strong>SE&Ccedil\;&Atilde\;O ELEITORAL</strong>.";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou a data de nascimento
$var = param(nascimento);
if (!$var) {
  $problemas = 1;
  $causa = "&bull\; Digite sua <strong>DATA DE NASCIMENTO</strong>.";
  push(@tudo,$causa);
}
# verificando se a data digitado corresponde a uma data v�lida
($dia_data, $mes_data, $ano_data) = split(/\//, $var);
if ( ($dia_data >= 1 && $dia_data <= 31) && ($mes_data >= 1 && $mes_data <= 12) && ($ano_data >= 1910 && $ano_data <= 2050) ) {
  $nada = "nada";
}
else {
  $problemas = 1;
  $causa = "&bull\; Sua data de nascimento n&atilde\;o &eacute\; uma data v&aacute\;lida\;<br />";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou o captcha
$var = param(entercod);
if (!$var) {
  $problemas = 1;
  $causa = "&bull\; Digite os <strong>N&Uacute\;MEROS</strong> que est&atilde\;o na imagem.";
  push(@tudo,$causa);
}

# verificando se o captcha foi digitado corretamente
$entercod = param(entercod);
$valida_captcha = &verifica_captcha($entercod);
if (!$valida_captcha) {
  # se entrou aqui � pq o captcha foi digitado ERRADO
  $problemas = 1;
  $causa = "&bull\; Entre com os n�meros corretos da imagem.<br />";
  push(@tudo,$causa);
}

# verificando se a pessoa marcou o checkbox da DECLARA��O
$var = param(veracidade);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Marque: <strong>Declaro a veracidade dos dados</strong>.";
  push(@tudo,$causa);
}

# verificando se a pessoa marcou o checkbox da ASSINATURA DE ADES�O
$var = param(adesao);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Marque: <strong>Declaro minha assinatura de ades&atilde\;o</strong>.<br />";
  push(@tudo,$causa);
}

if ($problemas) {
#  $qts_elementos = scalar(@tudo);
#  print "$tudo[0]<br>ERROS ENCONTRADOS: $qts_elementos";exit;
  print "$tudo[0]";exit;
}

else { # se caiu aqui, todos os dados do form est�o corretos, ent�o � s� inserir no BD o novo usu�rio cadastrado, computar o voto no BD, e informar uma msg no email dele que ele votou com sucesso.

  # isso aqui � pra garantir que o usu�rio n�o deu um voltar no navegador ou atualizar, pra n�o dar 2 ou mais votos
  $query = "SELECT COUNT(*) FROM `cadastro_eleitores_temp` WHERE `email_digest` = '$form_hidden_c'";
  $q = $conn->prepare ($query);
  $q->execute();
  $achei_email = $q->fetchrow_array;
  $q->finish();
  
  if (!$achei_email) {
    print "<script>document.location.href = \"https://www.votolivre.org/votolivre/novosite/erro.html\"\;</script>"; exit;
  }

  # atrav�s do email_digest que veio por param(form_hidden_c) pego todos os dados do cadastro1 desta pessoa que est� na tabela tempor�ria `cadastro_eleitores_temp`

  $query = "SELECT `id`,`mespub`,`nome`,`cpf`,`cep`,`endereco`,`end_numero`,`end_complemento`,`email`,`email_digest`,`cadastro_concluido` FROM `cadastro_eleitores_temp` WHERE `email_digest` = '$form_hidden_c' LIMIT 1";
  $q = $conn->prepare ($query);
  $q->execute();
  ($id,$mespub,$nome,$cpf,$cep,$endereco,$end_numero,$end_complemento,$email,$email_digest,$cadastro_concluido) = $q->fetchrow_array;
  $q->finish();

  $input_titulo = param(titulo);
  $input_zona = param(zona);
  $input_secao = param(secao);
  $input_nascimento = param(nascimento);
  
  # arrumando os dados para ent�o inserir o usu�rio na tabela `cadastro_eleitores`
  
  # pegando a data de nascimento no padr�o para banco de dados
  $datanascimento_pra_bd = &data_pra_bd($input_nascimento);

  # inserindo o usu�rio no BD
  $query = "INSERT INTO `cadastro_eleitores` VALUES ('0','$datacad','$nome','$cpf','','$datanascimento_pra_bd','$endereco','$end_numero','$end_complemento','$cep','$email','$email_digest','','','$input_titulo','$input_zona','$input_secao','','s','s')";

  # pra funcionar acentua��o em ajax (se n�o tiver isso cadastra no bd "C&iacute;cero Liz" em vez de "C�cero")
  $query =~ s/([\xC0-\xDF])([\x80-\xBF])/chr(ord($1)<<6&0xC0|ord($2)&0x3F)/eg;

  $q = $conn->do($query);

  # BEGIN - computando o atual voto

  # pegando a lei do momento: o id da �ltima Lei que est� no BD (a �ltima � a que est� no ar SEMPRE)
  $query = "SELECT MAX(`id`) FROM `leis_publicadas` WHERE 1";
  $q = $conn->prepare ($query);
  $q->execute();
  ($leidomomento) = $q->fetchrow_array;
  $q->finish();

  # pegando o id deste eleitor que acabou de se cadastrar
  $query = "SELECT `id` FROM `cadastro_eleitores` WHERE `cpf` = '$cpf'";
  $q = $conn->prepare ($query);
  $q->execute();
  ($id_eleitor) = $q->fetchrow_array;
  $q->finish();

  $query = "INSERT INTO `votos` VALUES ('0','$id_eleitor','$leidomomento','$datacad')";
  $q = $conn->prepare ($query);
  $q->execute();
  $q->finish();

  # pegar o n�mero de votos que a Lei j� recebeu (incluindo o atual voto)
  $query = "SELECT COUNT(*) FROM `votos` WHERE `id_lei` = '$leidomomento'";
  $q = $conn->prepare ($query);
  $q->execute();
  $qts_votos = $q->fetchrow_array;
  $qts_votos = $qts_votos + 554; # isso � pra chegar nos 11.111 votos
  $q->finish();

  # END - computando o atual voto

# deletar este usu�rio da tabela tempor�ria, j� que os dados j� foram jogados pra tabela fixa `cadastro_eleitores`
  $query = "DELETE FROM `cadastro_eleitores_temp` WHERE `id` = '$id' LIMIT 1";
  $q = $conn->do($query);
  
  # os que ficarm no bd como `cadastro_concluido` = 'n', n�o conclu�ram o cadastro a partir do segundo formul�rio.

  # enviando o email de confirma��o do voto
  $email = "$email";
  $ip = $ENV{'REMOTE_ADDR'};

  open (MAIL, "|/usr/sbin/sendmail -t -r webmaster\@leismunicipais.com.br") 
  or die "can't open mail program" ;
  select MAIL;

  print "X-Originating-IP: $ip\n";
  print "To: \"$email\" <$email>\n";
  print "From: \"VOTOLIVRE.ORG\" <webmaster\@leismunicipais.com.br>\n";
  print "Return-Path: webmaster\@leismunicipais.com.br\n";
  print "Reply-To: webmaster\@leismunicipais.com.br\n";
  print "Subject: Obrigado por votar!\n";

  print "\n";
  print "Obrigado por votar!\n";
  print "\n";
  print "SEU VOTO � O DE N�MERO: $qts_votos.\n";
  print "\n";
  print "Quanto mais pessoas participarem e divulgarem, maiores ser�o as nossas chances de aprovar o Projeto de Lei da Mobilidade Urbana Sustent�vel - a Lei da Bicicleta, fazendo de Curitiba um exemplo de Cidadania!\n";
  print "\n";
  print "Cada pessoa que participa aumenta a nossa for�a.\n";
  print "\n";
  print "https://www.votolivre.org\n";
  print "\n";
  print "Ao redor do mundo, a Internet vem se mostrando uma nova forma de democratizar a pol�tica e criar novos canais de participa��o para a popula��o. Se soubermos utilizar esta ferramenta, nossos pol�ticos entender�o que n�s os elegemos e eles devem trabalhar em parceria com a sociedade.\n";
  print "\n";
  print "N�s possu�mos um grande poder coletivo para transformar nossa cidade.\n";
  print "\n";
  print "Ajude a divulgar. Curitiba agradece a sua participa��o!\n";
  print "Nosso muito obrigado!\n";
  print "\n";
  print "Prepare Curitiba para a Copa 2014!\n";
  print "\n";
  print "https://www.votolivre.org\n";

  select STDOUT;
  close MAIL;

  print "<script>document.location.href = \"https://www.votolivre.org/cgi-local/votolivre/novosite/cadastro_03.pl?q=$qts_votos\"\;</script>"; exit;

}

$conn->disconnect();
