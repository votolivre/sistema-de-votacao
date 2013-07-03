#!/usr/bin/perl
require('cgi-lib.pl');
&ReadParse(*input);

use DBI;

require ('db-config.pl');

$atr = "DBI:$driver:database=$meudb;host=$host";
$conn = DBI->connect ($atr, $user, $pass);

print "Content-type:text/html\n\n";

$ativo_saibamais = " class=\"ativo\"";
$ativo_quemsomos = " class=\"ativo\"";

$cabecalho = "
    <div id =\"topo\">
		<div class=\"marca\"><a href=\"https://www.votolivre.org\" title=\"VotoLivre.org\"><img src=\"https://www.votolivre.org/votolivre/novosite/imagens/votolivre.gif\" width=\"300\" height=\"60\" /></a></div><!-- marca -->
		<div class=\"menu\">
            
<ul><!-- geral -->
        	<li class=\"nav\"><a href=\"#\"><h1$ativo_saibamais>Saiba Mais</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/quem-somos.html\"><h2$ativo_quemsomos>Quem somos</h2></a></li>
                <li><a href=\"https://www.votolivre.org/movimento.html\"><h2>O Movimento</h2></a></li>
                <li><a href=\"https://www.votolivre.org/lei-municipal.html\"><h2>Lei Municipal</h2></a></li>
                <li class=\"ultimo\"><a href=\"https://www.votolivre.org/validade-juridica.html\"><h2>Validade Jur&iacute\;dica</h2></a></li>
				</ul>
            </li>
            <img src=\"https://www.votolivre.org/votolivre/novosite/imagens/menu-spacer.gif\" width=\"20\" height=\"33\" />
          <li class=\"nav\"><a href=\"#\"><h1 class=\"ativo\">M&iacute\;dia</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/clipping.html\"><h2>Clipping</h2></a></li>
                <li><a href=\"https://www.votolivre.org/press-release.html\"><h2>Press Release</h2></a></li>
                <li class=\"ultimo\"><h2>Apoio</h2></li>
                </ul>
            </li>
            <img src=\"https://www.votolivre.org/votolivre/novosite/imagens/menu-spacer.gif\" width=\"20\" height=\"33\" />
          <li class=\"nav\"><a href=\"#\"><h1>Na rede</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/downloads.html\"><h2>Downloads</h2></a></li>
                <!-- li><a href=\"https://votolivre.org/blog\" target=\"_blank\"><h2>Blog</h2></a></li -->
                <li><a href=\"https://twitter.com/votolivre_org\" target=\"_blank\"><h2>Twitter</h2></a></li>
                <li class=\"ultimo\"><a href=\"https://www.votolivre.org/links.html\"><h2>Links</h2></a></li>
                </ul>
            </li>
            <img src=\"https://www.votolivre.org/votolivre/novosite/imagens/menu-spacer.gif\" width=\"20\" height=\"33\" />
          <li class=\"nav\"><a href=\"#\"><h1>Contato</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/fale-conosco.html\"><h2>Fale Conosco</h2></a></li>
                <li><a href=\"https://www.votolivre.org/como-ajudar.html\"><h2>Como Ajudar</h2></a></li>
                <li class=\"ultimo\"><a href=\"https://www.votolivre.org/faq.html\"><h2>FAQ</h2></a></li>
                </ul>
            </li>
        </ul><!-- geral -->
        
        
        </div><!-- menu -->
	</div><!-- topo -->
";

# pegando o id da &uacute;ltimo Lei que est&aacute; no BD (a &uacute;ltima &eacute; a que est&aacute; no ar SEMPRE)
$query = "SELECT MAX(`id`) FROM `leis_publicadas` WHERE 1";
$q = $conn->prepare ($query);
$q->execute();
($ultimo_id) = $q->fetchrow_array;
$q->finish();

# puxando o CABE&ccedil;ALHO e RODAP&eacute; do site
$query = "SELECT `rodape` FROM `leis_publicadas` WHERE `id` = '$ultimo_id'";
$q = $conn->prepare ($query);
$q->execute();
($rodape) = $q->fetchrow_array;
$q->finish();

print <<"imprime";

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">

<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>VotoLivre.org | Quem somos</title>

<link rel="stylesheet" type="text/css" href="https://www.votolivre.org/votolivre/novosite/estilo.css" />

<!-- Update your browser -->
<!-- script type="text/javascript" src="https://updateyourbrowser.net/asn.js"> </script>

<!-- Fancybox -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript" src="https://www.votolivre.org/votolivre/novosite/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="https://www.votolivre.org/votolivre/novosite/fancybox/jquery.easing-1.4.pack.js"></script>
<script type="text/javascript" src="https://www.votolivre.org/votolivre/novosite/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
<link rel="stylesheet" href="https://www.votolivre.org/votolivre/novosite/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

<script>
\$(document).ready(function() {

	/* This is basic - uses default settings */
	
	\$("a.cadastro_iframe").fancybox({
				'autoScale'			: false,
				'transitionIn'		: 'none',
				'transitionOut'		: 'none',
				'type'				: 'iframe',
				'scrolling'			: 'no',
				'width'				: 560,
				'height'			: 362
			});
	
});
</script>

<!-- Facebook like thumbnail -->
<meta property="og:image" content="https://www.eldermartins.com/clientes/votolivre/imagens/facebook_thumb.gif" />

</head>

<body>

<div id="conteudo">
	
$cabecalho
	
    <div id="cabeca-interna">
		<div class="imagem-bicicletabranca">
        </div><!--imagem-->
	</div><!-- cabeca-interna -->
	
	<div id="wrapper">
    	<div id="sidebar-esquerda">
        	
        	<div class="submenu">
            <h1>SUBT&Oacute;PICOS</h1>
            <ul>
            	<a href="#1"><li>Bicicleta Branca</li></a>
                <a href="#2"><li>V&iacute;deo</li></a>
                <a href="#3"><li>Cr&eacute;ditos</li></a>
			</ul>
            </div><!-- submenu -->
            
           <div class="box-voteja">
       <a class="cadastro_iframe" href="https://www.votolivre.org/votolivre/novosite/cadastro_01.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_voteja.gif" width="192" height="32"  /></a>
        </div><!-- box-voteja -->
        
        <div class="banners-internas">
        
        <a href="http://www.pedaleporummundolivre.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/parceiros_gif.gif" /></a>
        
        <!-- certificação digital -->
        <div style="margin:5px 0 0 50px">
<script language='javascript'>function vopenw() {	tbar='location=no,status=yes,resizable=yes,scrollbars=yes,width=560,height=535';	sw =  window.open('https://www.certisign.com.br/seal/splashcerti.htm','CRSN_Splash',tbar);	sw.focus();}</script><table width='135' border='0' cellpadding='2' cellspacing='0'>
<tr>
<td width='135' align='center' valign='middle'><a href='javascript:vopenw()'><img src='/100x46_fundo_branco.gif' border=0 align=center alt='Um site validado pela Certisign indica que nossa empresa concluiu satisfatoriamente todos os procedimentos para determinar que o domínio validado é de propriedade ou se encontra registrado por uma empresa ou organização autorizada a negociar por ela ou exercer qualquer atividade lícita em seu nome.'></a><br />
<script src=https://seal.verisign.com/getseal?host_name=www.votolivre.org&size=S&use_flash=NO&use_transparent=getsealjs_b.js&lang=pt></script></td>
</tr>
</table>
        </div>
        </div><!-- banners-internas -->
        
        </div><!-- sidebar_esq -->
<div id="coluna-internas">

        	<a name="1"><h1>Bicicleta Branca</h1></a>
            <p>Na d&eacute;cada de 60 na Holanda , um grupo de artistas chamado Provos, apresentou ao p&uacute;blico na Pra&iacute;&ccedil;a Lieverdje, em Amsterdam , a primeira "Bicicleta Branca" de propriedade comum. A id&eacute;ia era que ela sempre tivesse pronta para o pr&oacute;ximo usu&aacute;rio.</p>
<p>O primeiro transporte coletivo e gratuito questionava a propriedade privada e estava aberta a qualquer um que dela necessitasse, uma vez utilizada era deixada para o pr&oacute;ximo usu&aacute;rio. Esta a&ccedil;&atilde;o inspirou v&aacute;rios programas de bicicletas comunit&aacute;rias espalhados pelo mundo.</p>
<p>Em Curitiba a primeira Bicicleta Branca comunit&aacute;ria foi apresentada em 12 de setembro de 2007, no Museu de Arte Contempor&acirc;nea do Paran&aacute;, na vernissage da Mostra de Arte Latino Americana Vento Sul. Surgiu como uma proposta art&iacute;stica do Coletivo Interlux, essa bicicleta fez a ponte entre os trabalhos urbanos mapeados virtualmente dentro do museu, com os s&iacute;tios urbanos expostos a c&eacute;u aberto, o visitante poderia, a qualquer momento, montar na bicicleta branca que ficava estacionada na entrada do museu, sair e desvendar a cidade com outro olhos.</p>
<p>Em 2010, uma turma de talentos curitibanos, voltam nosso olhar novamente para esse s&iacute;­mbolo de import&acirc;ncia hist&oacute;rica, num belo v&iacute;deo feito com o prop&oacute;sito de incentivar a popula&ccedil;&atilde;o a votar na Lei da Mobilidade Urbana Sustentada (Lei da Bicicleta), iniciativa popular que foi colocada em vota&ccedil;&atilde;o no site <strong>votolivre.org</strong>, mostrando que a pr&oacute;pria popula&ccedil;&atilde;o pode apresentar suas propostas de lei, votando em id&eacute;ias e n&atilde;o em pessoas, atrav&eacute;s da internet.</p>
<p>Com belas imagens, o v&iacute;deo mostra v&aacute;rios cidad&atilde;os fazendo uso da "Bike Branca", a qual todos tem direito, como tamb&eacute;m todos n&oacute;s podemos valer nossos direitos atrav&eacute;s do voto livre.</p>
<p>Melhorar a mobilidade e a vida de nossa Cidade &eacute; nosso direito, &eacute; a democracia sendo exercida de forma livre e direta. E para isso acontecer precisamos votar.</p>
            
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
            <a name="2"><h1>V&iacute;deo</h1></a>
            <object width="540" height="334">
        <param name="movie" value="https://www.youtube.com/v/Pg4uikZnx5I?fs=1&amp;hl=pt_BR"></param>
        <param name="allowFullScreen" value="true"></param>
        <param name="allowscriptaccess" value="always"></param>
        <param name="wmode" value="opaque"></param>
        <embed src="https://www.youtube.com/v/Pg4uikZnx5I?fs=1&amp;hl=pt_BR" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="540" height="334" wmode="opaque"></embed></object>
        	<br/><br/>
            <p><a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a></p>
            
            <a name="3"><h1>Cr&eacute;ditos</h1></a>
            <p><strong>Roteiro e Dire&ccedil;&atilde;o:</strong> Thiago Prestes<br/>
<strong>Fotografia:</strong> Fernando Aguiar (Fefeco)<br/>
<strong>Produ&ccedil;&atilde;o Executiva:</strong> P.A. Nogueira<br/>
<strong>Coordena&ccedil;&atilde;o de Produ&ccedil;&atilde;o:</strong> Mari Zanicotti e Muga<br/>
<strong>Loca&ccedil;&atilde;o:</strong> P.A Nogueira e Thiago Prestes<br/>
<strong>Figurino:</strong> Adri Vaini<br/>
<strong>Produ&ccedil;&atilde;o:</strong> Paula Saltini, Flavia Budola, Leonardo Albano<br/>
<strong>Trilha Original:</strong> Fabio Abujamra<br/>
<strong>Sound Design:</strong> Rodrigo Janizewski (Audio Nuclear)<br/>
<strong>Maquin&aacute;ria:</strong> P.A. Nogueira<br/>
<strong>Assis. de Fotografia:</strong> Gliciara<br/>
<strong>Montagem e imagens adicionais:</strong> Beto Varella<br/>
<strong>Color:</strong> Ricardo Jug<br/>
<strong>Elenco:</strong> Fernando Oliva, Muga e Thompson (the dog), Mari Zanicotti, Leonardo Albano, Thiago Prestes, Dilene Rodrigues Prestes, Beto Varella, Eduardo Bernardi, Moises Prestes, Antenor Prestes<br/>
<strong>Agradecimentos:</strong> votolivre.org, Movimento Cinematografia Digital, Temple Frame, Rafael Budolla, Costa Rebelo, Junior Baggio</p>
            <a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
            
      </div><!-- coluna_internas -->
    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
