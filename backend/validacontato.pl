#!/usr/bin/perl
use CGI qw(:standard);

print "Content-type:text/html\n\n";

$problemas = 0;

# filtrando todos os caracteres que podem ser perigosos (testar em todos os campos do form)
if  ( (param(nome) =~ /[%;<>*`|&]/) || (param(cidade) =~ /[%;<>*`|&]/) || (param(email) =~ /[%;<>*`|&]/) || (param(email2) =~ /[%;<>*`|&]/) || (param(assunto) =~ /[%;<>*`|&]/) || (param(mensagem) =~ /[%;<>*`|&]/) ) {
  $problemas = 1;
  $causa = "&bull\; Por quest&atilde\;o de seguran&ccedil\;a, nenhum desse caracteres s&atilde\;o permitidos: , \%, \;, \<, \>, \*, \`, \|, \&. Remova onde foi inserido..<br />";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou o nome
$var = param(nome);
if (!$var) {
  $problemas = 1;
  $causa = "&bull\; Digite seu nome.<br />";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou a cidade
$var = param(cidade);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Digite o nome de sua cidade.<br />";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou o email
$var = param(email);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Digite seu email.<br />";
  push(@tudo,$causa);
}
else {
  $email_login = $var;
}

# verificando se a pessoa digitou o email2 (email de comparação)
$var = param(email2);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Digite novamente o email.<br />";
  push(@tudo,$causa);
}

# verificando se o email é igual ao email2
$var1 = param(email);
$var2 = param(email2);
if ($var1 ne $var2) { #
  $problemas = 1;
  $causa = "&bull\; Os emails digitados s&atilde\;o distintos.<br />";
  push(@tudo,$causa);
}

# verificando se a pessoa o assunto
$var = param(assunto);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Digite o assunto.<br />";
  push(@tudo,$causa);
}

# verificando se a pessoa digitou a mensagem
$var = param(mensagem);
if (!$var) { #
  $problemas = 1;
  $causa = "&bull\; Digite uma mensagem.<br />";
  push(@tudo,$causa);
}

sleep(1);

if ($problemas) {
  print "$tudo[0]";exit;
}

else { # se caiu aqui, todos os dados do form estão corretos. Então mandar esse dados para um email.

  $input_nome = param(nome);
  $input_nome =~ s/([\xC0-\xDF])([\x80-\xBF])/chr(ord($1)<<6&0xC0|ord($2)&0x3F)/eg; # pra funcionar acentuação em ajax (se não tiver isso: fica "CÃ­cero Liz" em vez de "Cícero Liz")

  $input_cidade = param(cidade);
  $input_cidade =~ s/([\xC0-\xDF])([\x80-\xBF])/chr(ord($1)<<6&0xC0|ord($2)&0x3F)/eg; # pra funcionar acentuação em ajax (se não tiver isso: fica "CÃ­cero Liz" em vez de "Cícero Liz")

  $input_email = param(email);
  $input_email =~ s/([\xC0-\xDF])([\x80-\xBF])/chr(ord($1)<<6&0xC0|ord($2)&0x3F)/eg; # pra funcionar acentuação em ajax (se não tiver isso: fica "CÃ­cero Liz" em vez de "Cícero Liz")

  $input_assunto = param(assunto);
  $input_assunto =~ s/([\xC0-\xDF])([\x80-\xBF])/chr(ord($1)<<6&0xC0|ord($2)&0x3F)/eg; # pra funcionar acentuação em ajax (se não tiver isso: fica "CÃ­cero Liz" em vez de "Cícero Liz")

  $input_mensagem = param(mensagem);
  $input_mensagem =~ s/([\xC0-\xDF])([\x80-\xBF])/chr(ord($1)<<6&0xC0|ord($2)&0x3F)/eg; # pra funcionar acentuação em ajax (se não tiver isso: fica "CÃ­cero Liz" em vez de "Cícero Liz")

  print "<strong>Obrigado por entrar em contato!</strong>";

  # enviando o email com os dados do contato
  # para: marcosjuliano@footsack.com.br
  $email_para = "marcosjuliano\@futsac.com";
  $ip = $ENV{'REMOTE_ADDR'};

  open (MAIL, "|/usr/sbin/sendmail -t -r webmaster\@leismunicipais.com.br") 
  or die "can't open mail program" ;
  select MAIL;

  print "X-Originating-IP: $ip\n";
  print "To: \"$email_para\" <$email_para>\n";
  print "From: \"VOTOLIVRE.ORG\" <webmaster\@leismunicipais.com.br>\n";
  print "Return-Path: webmaster\@leismunicipais.com.br\n";
  print "Reply-To: webmaster\@leismunicipais.com.br\n";
  print "Subject: VOTOLIVRE - Contato\n";

  print "\n";
  print "Nome: $input_nome\n\n";
  print "Cidade: $input_cidade\n\n";
  print "Email: $input_email\n\n";
  print "Assunto: $input_assunto\n\n";
  print "Mensagem: $input_mensagem\n\n";
  print "\n";

  select STDOUT;
  close MAIL;

  # enviando o email com os dados do contato
  # para: henriquedacostaressel@hotmail.com
  $email_para = "henriquedacostaressel\@hotmail.com";
  $ip = $ENV{'REMOTE_ADDR'};

  open (MAIL, "|/usr/sbin/sendmail -t -r webmaster\@leismunicipais.com.br") 
  or die "can't open mail program" ;
  select MAIL;

  print "X-Originating-IP: $ip\n";
  print "To: \"$email_para\" <$email_para>\n";
  print "From: \"VOTOLIVRE.ORG\" <webmaster\@leismunicipais.com.br>\n";
  print "Return-Path: webmaster\@leismunicipais.com.br\n";
  print "Reply-To: webmaster\@leismunicipais.com.br\n";
  print "Subject: VOTOLIVRE - Contato\n";

  print "\n";
  print "Nome: $input_nome\n\n";
  print "Cidade: $input_cidade\n\n";
  print "Email: $input_email\n\n";
  print "Assunto: $input_assunto\n\n";
  print "Mensagem: $input_mensagem\n\n";
  print "\n";

  select STDOUT;
  close MAIL;

  # enviando o email com os dados do contato
  # para: votolivre.org@gmail.com
  $email_para = "votolivre.org\@gmail.com";
  $ip = $ENV{'REMOTE_ADDR'};

  open (MAIL, "|/usr/sbin/sendmail -t -r webmaster\@leismunicipais.com.br") 
  or die "can't open mail program" ;
  select MAIL;

  print "X-Originating-IP: $ip\n";
  print "To: \"$email_para\" <$email_para>\n";
  print "From: \"VOTOLIVRE.ORG\" <webmaster\@leismunicipais.com.br>\n";
  print "Return-Path: webmaster\@leismunicipais.com.br\n";
  print "Reply-To: webmaster\@leismunicipais.com.br\n";
  print "Subject: VOTOLIVRE - Contato\n";

  print "\n";
  print "Nome: $input_nome\n\n";
  print "Cidade: $input_cidade\n\n";
  print "Email: $input_email\n\n";
  print "Assunto: $input_assunto\n\n";
  print "Mensagem: $input_mensagem\n\n";
  print "\n";

  select STDOUT;
  close MAIL;

}

