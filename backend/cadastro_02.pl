#!/usr/bin/perl
require('cgi-lib.pl');
require('lib-captcha.pl');
&ReadParse(*input);

use DBI;

require ('db-config.pl');

$atr = "DBI:$driver:database=$meudb;host=$host";
$conn = DBI->connect ($atr, $user, $pass);

# chamando a rotina "cria_captcha" que est� no lib-captcha.pl
&cria_captcha;

$imgsrc_cod =~ s/>/ style=\"float:left\; margin:-5px 10px 0 0\;\" \/>/;

print "Content-type:text/html\n\n";

$email_digest = $input{c};

$email_digest = substr($email_digest,0,32);

print <<"imprime";

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="https://www.votolivre.org/votolivre/novosite/estilo.css" />

<title>VotoLivre.org | A democracia exercida de forma livre e direta.</title>
<!-- for ajax -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script> 
<script src="https://www.votolivre.org/votolivre/novosite/script_u.js" type="text/javascript"></script>
<script src="https://www.votolivre.org/votolivre/novosite/script_d.js" type="text/javascript"></script>
 

</head>

<body>
<div id="cadastro_01">

<div id="search_indicator" style="position:absolute;top:177px;left:220px;"><img src="https://www.votolivre.org/votolivre/novosite/imagens/loader1.gif" alt="carregando" /></div>

<form id="form_dois" method="post">
<input type="text" name="titulo" class="form_2titulo form_esq" value="" onkeypress="mascara(this,validartitulo)" style="background-image: url(https://www.votolivre.org/votolivre/novosite/imagens/titulo_bg.gif); background-repeat:no-repeat; background-position: 10px 10px;" maxlength="13" id="form_titulo"/>

<a href="http://www.tse.gov.br/internet/servicos_eleitor/consultaNome.htm" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/titulo_naosabe.png" style="margin:0 0 0 2px; border:0;" /></a>
<div class="clear"></div>

<input type="text" name="zona" class="form_2titulo form_esq" value="" onkeypress="mascara(this,soNumeros)" style="background-image: url(https://www.votolivre.org/votolivre/novosite/imagens/zona_bg.gif); background-repeat:no-repeat; background-position: 10px 10px;" maxlength="3" id="form_zona"/>

<input type="text" name="secao" class="form_2titulo" value="" onkeypress="mascara(this,soNumeros)" style="background-image: url(https://www.votolivre.org/votolivre/novosite/imagens/secao_bg.gif); background-repeat:no-repeat; background-position: 10px 10px;" maxlength="4" id="form_secao" />

<input type="text" name="nascimento" class="form_2nasc form_esq" value="" onkeypress="mascara(this,validarnascimento)" style="background-image: url(https://www.votolivre.org/votolivre/novosite/imagens/nascimento_bg.gif); background-repeat:no-repeat; background-position: 10px 10px;" maxlength="10" id="form_nascimento" />

$imgsrc_cod

<input type="text" name="entercod" class="form_5digite" value="" onkeypress="mascara(this,soNumeros)" style="background-image: url(https://www.votolivre.org/votolivre/novosite/imagens/digite_bg.gif); background-repeat:no-repeat; background-position: 10px 10px;" maxlength="4" id="form_entercod" />

<div class="clear"></div>

<input type="checkbox" name="veracidade" value="1" class="form_check" /> <p class="form">Declaro a veracidade dos dados preenchidos.</p>

<div class="clear"></div>

<input type="checkbox" name="adesao" value="1" class="form_check" /> <p class="form">Declaro a minha assinatura de ades&atilde\;o na Lei da Bicicleta<br/> <i>(Lei da Mobilidade Urbana Sustent&aacute;vel - <u><a href="https://www.votolivre.org/lei-municipal.html" target="_blank">conhe&ccedil;a a lei na &iacute;ntegra</a></u>)</i>.</p>

<div class="clear"></div>

<p class="form" style="margin-bottom:20px;"><u>

<script language='javascript'>function vopenw() {	tbar='location=no,status=yes,resizable=yes,scrollbars=yes,width=560,height=535';	sw =  window.open('https://www.certisign.com.br/seal/splashcerti.htm','CRSN_Splash',tbar);	sw.focus();}</script>

<a href="https://www.votolivre.org/politica-de-privacidade.html" target="blank_"><span style="font-weight:bold">Votolivre.org</span> proteger&aacute; seus dados.</a><br />


</u></p>

<div class="clear"></div>

<!-- ########################### ERROS DIV OCULTA ########################### -->

<!-- retorno  -->
<div class="erro2" id="mostrar_isto">
</div>

<!-- ERRO TITULO 
<div class="erro2" id="errotitulo" style="display:block">
<p>Desculpe, o <strong>T&Iacute;TULO DE ELEITOR</strong> n&atilde;o &eacute; v&aacute;lido.</p>
<a href="#" onclick="document.getElementById('errotitulo').style.display='none';"><img src="https://www.votolivre.org/votolivre/novosite/imagens/fechardiv.gif" /></a>
</div>

<!-- ERRO ZONA
<div class="erro2" id="errozona">
<p>Desculpe, a <strong>ZONA ELEITORAL</strong> n&atilde;o &eacute; v&aacute;lida.</p>
<a href="#" onclick="document.getElementById('errozona').style.display='none';"><img src="https://www.votolivre.org/votolivre/novosite/imagens/fechardiv.gif" /></a>
</div>

<!-- ERRO SECAO
<div class="erro2" id="errosecao">
<p>Desculpe, a <strong>SEÇÂO ELEITORAL</strong> n&atilde;o &eacute; v&aacute;lida.</p>
<a href="#" onclick="document.getElementById('errosecao').style.display='none';"><img src="https://www.votolivre.org/votolivre/novosite/imagens/fechardiv.gif" /></a>
</div>
-->

<!-- ###########################  ########################### -->
<a href="javascript:history.go(-1)"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_corrigir.png" style="float:left; margin:5px 0 0 0; border:0;" /></a>

<!-- Bot&atilde;o original que leva para a confirma&ccedil;&atilde;o do cadastro: -->
<a href="#"><input type="submit" class="form_botao2" value=""  /></a>


<!-- ########################### BOTOES VALIDACAO EXEMPLO ########################### -->

<!-- Bot&atilde;o com exemplo de erro no TITULO: -->
<!-- <a onclick="document.getElementById('errotitulo').style.display='block';document.getElementById('titulo').style.borderColor='#ffb5b5'"><input type="button" class="form_botao2" value=""  /></a> -->

<!-- Bot&atilde;o com exemplo de erro no ZONA: -->
<!-- <a onclick="document.getElementById('errozona').style.display='block';document.getElementById('zona').style.borderColor='#ffb5b5'"><input type="button" class="form_botao2" value=""  /></a> -->

<!-- Bot&atilde;o com exemplo de erro no SECAO: -->
<!-- <a onclick="document.getElementById('errosecao').style.display='block';document.getElementById('secao').style.borderColor='#ffb5b5'"><input type="button" class="form_botao2" value=""  /></a> -->

<input type="hidden" name="name" value="$nome_hidden">
<input type="hidden" name="$nome_hidden" value="$nome_lei_fig">
<input type="hidden" name="img" value="$nome_cod_fig">
<input type="hidden" name="form_hidden_c" value="$email_digest">

</form>
</div><!-- /cadastro_01 -->

</body>
</html>

imprime

$conn->disconnect();
