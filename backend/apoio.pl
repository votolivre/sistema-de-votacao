#!/usr/bin/perl
require('cgi-lib.pl');
&ReadParse(*input);

use DBI;

require ('db-config.pl');

$atr = "DBI:$driver:database=$meudb;host=$host";
$conn = DBI->connect ($atr, $user, $pass);

print "Content-type:text/html\n\n";

$ativo_midia = " class=\"ativo\"";
$ativo_apoio = " class=\"ativo\"";

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
          <li class=\"nav\"><a href=\"#\"><h1$ativo_midia>M&iacute\;dia</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/clipping.html\"><h2>Clipping</h2></a></li>
                <li><a href=\"https://www.votolivre.org/press-release.html\"><h2>Press Release</h2></a></li>
                <li class=\"ultimo\"><a href=\"https://www.votolivre.org/apoio.html\"><h2$ativo_apoio>Apoio</h2></a></li>
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
		<div class="imagem-apoio">
        </div><!--imagem-->
	</div><!-- cabeca-interna -->
	
	<div id="wrapper">
    	<div id="sidebar-esquerda">
        	
        	<div class="submenu">
            <h1>SUBT&Oacute;PICOS</h1>
            <ul>
              <a href="#1"><li>Pol&iacute;tica de Apoio</li></a>
              <a href="#2"><li>Apoio</li></a>
            </ul>
            </div><!-- submenu -->
            
           <div class="box-voteja">
       <a class="cadastro_iframe" href="https://www.votolivre.org/votolivre/novosite/cadastro_01.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_voteja.gif" width="192" height="32"  /></a>
        </div><!-- box-voteja -->
        
        <div class="banners-internas">
        
        <a href="http://www.pedaleporummundolivre.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bn_mundolivre02.jpg" /></a>
        
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
 
        	<a name="1"><h1>Pol&iacute;tica de Apoio</h1></a>
            <p>A Pol&iacute;tica de Apoio do votolivre.org foi criada para ajudar a divulgar o movimento e permitir que a sociedade participe apoiando a ideia de exercer a democracia de forma livre e direta.</p>
<p>Para apoiar:</p>
<p><strong>1.</strong> Envie a logomarca (em alta resolu&ccedil&atilde;o) da sua associa&ccedil&atilde;o/empresa/entidade para o email votolivre\@votolivre.org , com o endere&ccedilo do seu site e o n&uacute;mero de pessoas da sua lista de emails.</p>
<p><strong>2.</strong> Sua logomarca ser&aacute; inclu&iacute;da nesta p&aacute;gina de apoio com o hiperlink para o seu site (caso exista) e voc&ecirc; vai receber um email-marketing do votolivre.org para envio.</p>
<p><strong>3.</strong> Envie o email-marketing do votolivre.org para sua lista de emails, lembrando de incluir o endere&ccedilo votolivre\@votolivre.org  na sua lista de emails.</p>
<p>O votolivre.org manter&aacute; &iacute;ntegras as informa&ccedilões que forem fornecidas pelos apoiadores.</p>
            
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
            <a href="xxx" target="_blank">
            
            <a name="2"><h1>Apoio</h1></a>
            <a href="http://www.mundolivrefm.com.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/01_mundolivre.gif" style="margin:0 5px;" /></a>
            <a href="http://www.gusbenke.com.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/02_gusbenke.gif" style="margin:0 5px;" /></a>
            <a href="http://www.aypar.org.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/03_aypar.gif" style="margin:0 5px;" /></a>
            <a href="http://www.dlab.com.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/04_dlab.gif" style="margin:0 5px;" /></a>
            <a href="http://www.footsack.com/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/05_footsack.gif" style="margin:0 5px;" /></a>
            <a href="http://www.movingmagazine.com.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/06_movingmag.gif" style="margin:0 5px;" /></a>
            <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/07_munozressel.gif" style="margin:0 5px;" />
            <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/08_muqifo.gif" style="margin:0 5px;" />
            <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/09_lys.gif" style="margin:0 5px;" />
            <a href="http://jornale.com.br/horasonora/" target="_blank"> <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/10_jornale.gif" style="margin:0 5px;" /></a>
            <a href="http://www.sadhanayoga.com.br/shiva-hara-studio-curitiba/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/11_shivahara.gif" style="margin:0 5px;" /></a>
            <a href="http://www.granderodadetambores.com.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/12_granderoda.gif" style="margin:0 5px;" /></a>
            <a href="http://www.brunogalvani.com/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/13_bgdesign.gif" style="margin:0 5px;" /></a>
            <a href="http://www.favaroarquitetos.com.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/14_favaro.gif" style="margin:0 5px;" /></a>
            <a href="http://www.centraldeprojetos.net/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/15_centralprojetos.gif" style="margin:0 5px;" /></a>
            <a href="http://www.dacstudio.com.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/16_dac.gif" style="margin:0 5px;" /></a>
            <a href="http://www.leismunicipais.com.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/17_leismunicipais.gif" style="margin:0 5px;" /></a>
            <a href="http://www.futebolderua.org/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/18_fdr.gif" style="margin:0 5px;" /></a>
            <a href="http://duplagamma.com/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/19_duplagamma.gif" style="margin:0 5px;" /></a>
            <a href="http://www.nucleop3.com/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/20_nucleop3.gif" style="margin:0 5px;" /></a>
            <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/21_ambiental.gif" style="margin:0 5px;" />
            <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/22_cultivo.gif" style="margin:0 5px;" />
            <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/23_kiro.gif" style="margin:0 5px;" />
            <a href="http://www.beehouse.com.br/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/24_beehouse.gif" style="margin:0 5px;" /></a>
            <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/25_keiko.gif" style="margin:0 5px;" />
            <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/26_varau.gif" style="margin:0 5px;" />
            <a href="http://www.sabonetes.net" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/27_sabonetes.gif" style="margin:0 5px;" /></a>
            <a href="http://www.roerich.org.br/site/bandeiradapaz.html" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/28_paz.gif" style="margin:0 5px;" /></a>
            <a href="http://www.universomistico.org/" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/29_mistico.gif" style="margin:0 5px;" /></a>
            <a href="http://www.galerialudica.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/30_ludica.gif" style="margin:0 5px;" /></a>
            <a href="http://www.alevelup.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/31_levelup.gif" style="margin:0 5px;" /></a>
            <a href="http://www.agenciabicicleta.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/32_agenciabicicleta.gif" style="margin:0 5px;" /></a>
            <a href="http://www.decorpedras.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/33_decorpedras.gif" style="margin:0 5px;" /></a>
            <a href="http://www.acampar.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/34_acampar.gif" style="margin:0 5px;" /></a>
            <img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/35_dpr.jpg" style="margin:0 5px;" />
            <a href="http://www.ecobikecourier.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/36_ecobike.gif" style="margin:0 5px;" /></a> 
            <a href="http://www.aldeiaco.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/logos/37_aldeia.gif" style="margin:0 5px;" /></a> 


            
            <p><a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a></p>
            
            
      </div><!-- coluna_internas -->
    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
