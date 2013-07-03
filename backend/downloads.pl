#!/usr/bin/perl
require('cgi-lib.pl');
&ReadParse(*input);

use DBI;

require ('db-config.pl');

$atr = "DBI:$driver:database=$meudb;host=$host";
$conn = DBI->connect ($atr, $user, $pass);

print "Content-type:text/html\n\n";

$ativo = " class=\"ativo\"";

$cabecalho = "
    <div id =\"topo\">
		<div class=\"marca\"><a href=\"https://www.votolivre.org\" title=\"VotoLivre.org\"><img src=\"https://www.votolivre.org/votolivre/novosite/imagens/votolivre.gif\" width=\"300\" height=\"60\" /></a></div><!-- marca -->
		<div class=\"menu\">
            
<ul><!-- geral -->
        	<li class=\"nav\"><a href=\"#\"><h1>Saiba Mais</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/quem-somos.html\"><h2>Quem somos</h2></a></li>
                <li><a href=\"https://www.votolivre.org/movimento.html\"><h2>O Movimento</h2></a></li>
                <li><a href=\"https://www.votolivre.org/lei-municipal.html\"><h2>Lei Municipal</h2></a></li>
                <li class=\"ultimo\"><a href=\"https://www.votolivre.org/validade-juridica.html\"><h2>Validade Jur&iacute\;dica</h2></a></li>
				</ul>
            </li>
            <img src=\"https://www.votolivre.org/votolivre/novosite/imagens/menu-spacer.gif\" width=\"20\" height=\"33\" />
          <li class=\"nav\"><a href=\"#\"><h1>M&iacute\;dia</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/clipping.html\"><h2>Clipping</h2></a></li>
                <li><a href=\"https://www.votolivre.org/press-release.html\"><h2>Press Release</h2></a></li>
                <li class=\"ultimo\"><h2>Apoio</h2></li>
                </ul>
            </li>
            <img src=\"https://www.votolivre.org/votolivre/novosite/imagens/menu-spacer.gif\" width=\"20\" height=\"33\" />
          <li class=\"nav\"><a href=\"#\"><h1$ativo>Na rede</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/downloads.html\"><h2$ativo>Downloads</h2></a></li>
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

# pegando o id da último Lei que está no BD (a última é a que está no ar SEMPRE)
$query = "SELECT MAX(`id`) FROM `leis_publicadas` WHERE 1";
$q = $conn->prepare ($query);
$q->execute();
($ultimo_id) = $q->fetchrow_array;
$q->finish();

# puxando o CABEÇALHO e RODAP&Eacute; do site
$query = "SELECT `rodape` FROM `leis_publicadas` WHERE `id` = '$ultimo_id'";
$q = $conn->prepare ($query);
$q->execute();
($rodape) = $q->fetchrow_array;
$q->finish();

print <<"imprime";

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">

<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>VotoLivre.org | Downloads</title>

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
		<div class="imagem-downloads">
        </div><!--imagem-->
	</div><!-- cabeca-interna -->
	
	<div id="wrapper">
    	<div id="sidebar-esquerda">
        	
      <div class="submenu">
        <h1>MATERIAIS</h1>
        <ul>
          <a href="#1">
          <li>Contador</li>
          </a> <a href="#2">
          <li>Banner Info</li>
          </a> <a href="#3">
          <li>Banner Verde</li>
          </a> <a href="#4">
          <li>Banner Branco</li>
          </a>
        </ul>
      </div>
      <!-- submenu -->
            
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
	<a name="1"><h1>Contador</h1></a>
      <div style="text-align:center"> <a href="https://www.votolivre.org/"><img src="https://www.votolivre.org/contador/img.php"></a><br>
        <p>Copie o contador para o seu site:</p>
        <input id="contador_selector" type="text" style="width:200px" onClick="
            var obj = document.getElementById(&#39;contador_selector&#39;);
            obj.focus();
            obj.select();
        " value="&lt;div style=&quot;text-align:center&quot;&gt;&lt;a href=&quot;https://www.votolivre.org&quot;&gt;&lt;img src=&quot;https://www.votolivre.org/contador/img.php&quot;&gt;&lt;/a&gt;&lt;/div&gt;">
      </div>
      <br/>
      <a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a> <a name="2">
      <h1>Banner Info</h1>
      </a>
      <p>Clique na imagem para fazer o download<br/>
        <br/>
        <a href="https://www.votolivre.org/votolivre/novosite/downloads/banner_votolivre_info.zip" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/banner_votolivre_info.jpg" style="margin-bottom:10px;" /></a> </p>
      <a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a> <a name="3">
      <h1>Banner Verde</h1>
      </a>
      <p>Clique na imagem para fazer o download<br/>
        <br/>
        <a href="https://www.votolivre.org/votolivre/novosite/downloads/banner_votolivre_verde.zip" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/banner_votolivre_verde.jpg" style="margin-right:10px;"" /></a> </p>
      <a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a> <a name="4">
      <h1>Banner Branco</h1>
      </a>
      <p>Clique na imagem para fazer o download<br/>
        <br/>
        <a href="https://www.votolivre.org/votolivre/novosite/downloads/banner_votolivre_branco.zip" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/banner_votolivre_branco.jpg" style="margin-bottom:10px;" /></a> </p>
      <a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a> </div>
    <!-- coluna_internas --> 
    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
