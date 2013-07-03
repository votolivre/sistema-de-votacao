#!/usr/bin/perl -I/home/votolivre/perl5/lib/perl5
require('lib-cic.pl');
# require('lib-captcha.pl');
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

# primeira coisa, testar se o usuário já não está registrado (pelo email ou pelo CPF)

$input_email = param(email);
$input_cpf = param(cpf);

$query = "SELECT COUNT(*) FROM `cadastro_eleitores` WHERE `email` LIKE '$input_email' OR `cpf` LIKE '$input_cpf'";
$q = $conn->prepare ($query);
$q->execute();
$ja_cadastrado = $q->fetchrow_array;
$q->finish();

if ($ja_cadastrado) {
  $causa = "&bull\; Voc&ecirc\; <strong>j&aacute\; votou</strong>. (o CPF ou EMAIL j\&aacute\; foi utilizado)";
  print "$causa";
  exit;
}

# agora, faço a veificaração (validação) dos dados entrados no formulário

# filtrando todos os caracteres que podem ser perigosos (testar em todos os campos do form)

if  ( (param(email_novamente) =~ /[%;<>`|&]/) || (param(email) =~ /[%;<>`|&]/) || (param(cidade) =~ /[%;<>`|&]/) || (param(end_complemento) =~ /[%;<>`|&]/) || (param(end_numero) =~ /[%;<>`|&]/) || (param(endereco) =~ /[%;<>`|&]/) || (param(cep) =~ /[%;<>`|&]/) || (param(cpf) =~ /[%;<>`|&]/) || (param(nome) =~ /[%;<>`|&]/) ) {
  $problemas = 1;
  $causa = "&bull\; Voc&ecirc\; digitou um caractere que n&atilde\;o &eacute\; permitido: $&";
  push(@tudo,$causa);
}

# verificando se o nome é completo
$var = param(nome);
if ($var !~ m/ /) { # se não tiver espaço no nome, é pq não digitou o nome completo
  $problemas = 1;
  $causa = "&bull\; Digite o seu nome completo.";
  push(@tudo,$causa);
}

# verificando se o cpf é válido
$var = param(cpf);
if (!test_cpf($var)) {
  $problemas = 1;
  $causa = "&bull\; O CPF n&atilde\;o &eacute\; v&aacute\;lido.";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou o CEP
$var = param(cep);
if (!$var) {
  $problemas = 1;
  $causa = "&bull\; Digite o CEP de sua cidade.";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou o endereço
$var = param(endereco);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Digite seu endere&ccedil\;o residencial.";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou o número do endereço
$var = param(end_numero);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Digite o n&uacute\;mero do seu endere&ccedil\;o residencial.";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou o email
$var = param(email);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Digite seu email.";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou o email2 (email de comparação)
$var = param(email_novamente);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Digite o email novamente no campo informado.";
  push(@tudo,$causa);
}

# verificando se o email é igual ao email2
$var1 = param(email);
$var2 = param(email_novamente);
if ($var1 ne $var2) { #
  $problemas = 1;
  $causa = "&bull\; As entradas de emails s&atilde\;o diferentes.";
  push(@tudo,$causa);
}

if ($problemas) {
#  $qts_elementos = scalar(@tudo);
#  print "$tudo[0]<br>ERROS ENCONTRADOS: $qts_elementos";exit;
  print "$tudo[0]";exit;
}

else { # se caiu aqui, todos os dados do form estão corretos, então é só inserir no BD o novo usuário cadastrado, computar o voto no BD, e informar uma msg no email dele que ele votou com sucesso.


  # vou armazenar esses dados em uma tabela temporária, aí caso a próxima etapa ocorre ok, jogo tudo junto pra tabela correta.

  $input_nome = param(nome);
  $input_cpf = param(cpf);
  $input_cep = param(cep);
  $input_endereco = param(endereco);
  $input_end_numero = param(end_numero);
  $input_end_complemento = param(end_complemento);
  $input_cidade = param(cidade);
  
  $input_email = param(email);
  $input_email = lc($input_email); # só pra garantir que o email vá pro DB com tudo em minúsculo
  $input_email_novamente = param(email_novamente);
  $input_email_novamente = lc($input_email_novamente); # só pra garantir que o email vá pro DB com tudo em minúsculo
  $email_digest = md5_hex($input_email);

  # caso o usuário clique em voltar, na segunda tela do cadastro, ele volta pra tela inicial de cadstro
  # com isso, ao acertar os dados, tenho que remover a entrada anterior referenciado ao email dele.
  $query = "DELETE FROM `cadastro_eleitores_temp` WHERE `email_digest` = '$email_digest'";
  $q = $conn->do($query);

  $query = "INSERT INTO `cadastro_eleitores_temp` VALUES ('0','$datacad','$input_nome','$input_cpf','$input_cep','$input_endereco','$input_end_numero','$input_end_complemento','$input_email','$email_digest','n')";

  # pra funcionar acentuação em ajax (se não tiver isso cadastra no bd "C&iacute;cero Liz" em vez de "Cícero")
  $query =~ s/([\xC0-\xDF])([\x80-\xBF])/chr(ord($1)<<6&0xC0|ord($2)&0x3F)/eg;

  $q = $conn->prepare ($query);
  $q->execute();
  $q->finish();

print "<script>document.location.href = \"https://www.votolivre.org/cgi-local/votolivre/novosite/cadastro_02.pl?c=$email_digest\"\;</script>"; exit;

# print "voto ok"; exit;

# print $q->header( -Refresh => "1; URL=https://www.leismunicipais.com.br");

# print $q->redirect("https://www.votolivre.org/cgi-local/lock.pl?yd=$mala&id=$sessionid");

#  print "<html><head><META HTTP-EQUIV=\"Refresh\" CONTENT=\"1\; URL=https://www.leismunicipais.com.br\"></head><body>VOTO OK</body></html>";exit;



}

$conn->disconnect();
