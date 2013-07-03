#!/usr/bin/perl
require('cgi-lib.pl');
&ReadParse(*input);

print "Content-type:text/html\n\n";

$qts_votos = $input{q};

print <<"imprime";

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta property="og:image" content="https://www.votolivre.org/img/icon_votolivre.png"/>
<meta property="og:site_name" content="Votolivre.org - Vote já"/>
<meta property="og:description" content=",Eu já votei. Precisamos de 65.000 votos. Faça a sua parte e vote também!"/>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="https://www.votolivre.org/votolivre/novosite/estilo.css" />

<title>VotoLivre.org | A democracia exercida de forma livre e direta.</title>
</head>

<body>
<div id="cadastro_01" style="padding:20px 40px 50px 40px;">
<h1 class="confirma_voto">Seu voto foi computado. Voto n&uacute;mero $qts_votos</p>
<p class="confirma_voto">Em alguns instantes voc&ecirc; receber&aacute; um email que confirma seu voto.<br/>
O email pode cair em sua pasta de lixo eletr&ocirc;nico,<br/> por favor confira ela tamb&eacute;m.</p>

<a target="_blank" href="https://www.facebook.com/sharer.php?u=https://www.votolivre.org/"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_facebook.png" border="0" style="float:left; margin:5px 0 0 20px; border:0;" /></a>

<a target="_blank" href="https://twitter.com/share?url=https%3A%2F%2Fwww.votolivre.org&text=.Eu%20fiz%20minha%20 %20e%20confirmei%20o%20voto.%20Precisamos%20de%2065.000%20votos.%20Participe.&via=votolivre_org"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_twitter.png" border="0" style="float:left; margin:5px 0 0 20px; border:0;" /></a>

<a href="https://www.votolivre.org/" target="_parent"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_confirma.png" style="float:left; margin:20px 0 0 70px; border:0;" /></a>

</div><!-- /cadastro_01 -->

</body>
</html>


imprime

$conn->disconnect();