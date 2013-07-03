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

# verificação (validação) dos dados entrados no formulário

# verificando se a pessoa digitou o título
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

# verificando se a pessoa digitou a seção eleitoral
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
# verificando se a data digitado corresponde a uma data válida
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
  # se entrou aqui é pq o captcha foi digitado ERRADO
  $problemas = 1;
  $causa = "&bull\; Entre com os números corretos da imagem.<br />";
  push(@tudo,$causa);
}

# verificando se a pessoa marcou o checkbox da DECLARAÇÃO
$var = param(veracidade);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Marque: <strong>Declaro a veracidade dos dados</strong>.";
  push(@tudo,$causa);
}

# verificando se a pessoa marcou o checkbox da ASSINATURA DE ADESÃO
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

else { # se caiu aqui, todos os dados do form estão corretos, então é só inserir no BD o novo usuário cadastrado, computar o voto no BD, e informar uma msg no email dele que ele votou com sucesso.

  # isso aqui é pra garantir que o usuário não deu um voltar no navegador ou atualizar, pra não dar 2 ou mais votos
  $query = "SELECT COUNT(*) FROM `cadastro_eleitores_temp` WHERE `email_digest` = '$form_hidden_c'";
  $q = $conn->prepare ($query);
  $q->execute();
  $achei_email = $q->fetchrow_array;
  $q->finish();
  
  if (!$achei_email) {
    print "<script>document.location.href = \"https://www.votolivre.org/votolivre/novosite/erro.html\"\;</script>"; exit;
  }

  # através do email_digest que veio por param(form_hidden_c) pego todos os dados do cadastro1 desta pessoa que está na tabela temporária `cadastro_eleitores_temp`

  $query = "SELECT `id`,`mespub`,`nome`,`cpf`,`cep`,`endereco`,`end_numero`,`end_complemento`,`email`,`email_digest`,`cadastro_concluido` FROM `cadastro_eleitores_temp` WHERE `email_digest` = '$form_hidden_c' LIMIT 1";
  $q = $conn->prepare ($query);
  $q->execute();
  ($id,$mespub,$nome,$cpf,$cep,$endereco,$end_numero,$end_complemento,$email,$email_digest,$cadastro_concluido) = $q->fetchrow_array;
  $q->finish();

  $input_titulo = param(titulo);
  $input_zona = param(zona);
  $input_secao = param(secao);
  $input_nascimento = param(nascimento);
  
  # arrumando os dados para então inserir o usuário na tabela `cadastro_eleitores`
  
  # pegando a data de nascimento no padrão para banco de dados
  $datanascimento_pra_bd = &data_pra_bd($input_nascimento);

  # inserindo o usuário no BD
  $query = "INSERT INTO `cadastro_eleitores` VALUES ('0','$datacad','$nome','$cpf','','$datanascimento_pra_bd','$endereco','$end_numero','$end_complemento','$cep','$email','$email_digest','','','$input_titulo','$input_zona','$input_secao','','s','s')";

  # pra funcionar acentuação em ajax (se não tiver isso cadastra no bd "C&iacute;cero Liz" em vez de "Cícero")
  $query =~ s/([\xC0-\xDF])([\x80-\xBF])/chr(ord($1)<<6&0xC0|ord($2)&0x3F)/eg;

  $q = $conn->do($query);

  # BEGIN - computando o atual voto

  # pegando a lei do momento: o id da última Lei que está no BD (a última é a que está no ar SEMPRE)
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

  # pegar o número de votos que a Lei já recebeu (incluindo o atual voto)
  $query = "SELECT COUNT(*) FROM `votos` WHERE `id_lei` = '$leidomomento'";
  $q = $conn->prepare ($query);
  $q->execute();
  $qts_votos = $q->fetchrow_array;
  $qts_votos = $qts_votos + 554; # isso é pra chegar nos 11.111 votos
  $q->finish();

  # END - computando o atual voto

# deletar este usuário da tabela temporária, já que os dados já foram jogados pra tabela fixa `cadastro_eleitores`
  $query = "DELETE FROM `cadastro_eleitores_temp` WHERE `id` = '$id' LIMIT 1";
  $q = $conn->do($query);
  
  # os que ficarm no bd como `cadastro_concluido` = 'n', não concluíram o cadastro a partir do segundo formulário.

  # enviando o email de confirmação do voto
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
  print "SEU VOTO É O DE NÚMERO: $qts_votos.\n";
  print "\n";
  print "Quanto mais pessoas participarem e divulgarem, maiores serão as nossas chances de aprovar o Projeto de Lei da Mobilidade Urbana Sustentável - a Lei da Bicicleta, fazendo de Curitiba um exemplo de Cidadania!\n";
  print "\n";
  print "Cada pessoa que participa aumenta a nossa força.\n";
  print "\n";
  print "https://www.votolivre.org\n";
  print "\n";
  print "Ao redor do mundo, a Internet vem se mostrando uma nova forma de democratizar a política e criar novos canais de participação para a população. Se soubermos utilizar esta ferramenta, nossos políticos entenderão que nós os elegemos e eles devem trabalhar em parceria com a sociedade.\n";
  print "\n";
  print "Nós possuímos um grande poder coletivo para transformar nossa cidade.\n";
  print "\n";
  print "Ajude a divulgar. Curitiba agradece a sua participação!\n";
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
