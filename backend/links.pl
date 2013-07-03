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
                <li><a href=\"https://www.votolivre.org/downloads.html\"><h2>Downloads</h2></a></li>
                <!-- li><a href=\"https://votolivre.org/blog\" target=\"_blank\"><h2>Blog</h2></a></li -->
                <li><a href=\"https://twitter.com/votolivre_org\" target=\"_blank\"><h2>Twitter</h2></a></li>
                <li class=\"ultimo\"><a href=\"https://www.votolivre.org/links.html\"><h2$ativo>Links</h2></a></li>
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

<title>VotoLivre.org | Links</title>

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
		<div class="imagem-links">
        </div><!--imagem-->
	</div><!-- cabeca-interna -->
	
	<div id="wrapper">
    	<div id="sidebar-esquerda">
        	
        	<div class="submenu">
            <h1>SUBT&Oacute;PICOS</h1>
            <ul>
            	<a href="#1"><li>Links locais</li></a>
                <a href="#2"><li>ONGs no Brasil</li></a>
                <a href="#3"><li>ONGs no Exterior</li></a>
                <a href="#4"><li>Informa&ccedil;&otilde;es Gerais</li></a>
                <a href="#5"><li>Mais links</li></a>
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

        	<a name="1"><h1>Links locais</h1></a>
        	<p>"Mais importante que o ve&iacute;culo que voc&ecirc; usa, &eacute; a mensagem que voc&ecirc; veicula."</p>
        	<p><a href="http://www.gazetadopovo.com.br/blog/irevirdebike" target="_blank">Ir e Vir de Bike</a></p>
        	<p><a href="http://bicicletadacuritiba.wordpress.com" target="_blank">Bicicletada Curitiba</a></p>
			<p><a href="http://sociedadpeatonal.blogspot.com" target="_blank">Sociedad Peatonal</a></p>
			<p><a href="http://curitibacyclechic.blogspot.com" target="_blank">Curitiba Cycle Chic</a></p>
			<p><a href="http://transportehumano.wordpress.com" target="_blank">Transporte Humano</a></p>
			<p><a href="http://artebicicletamobilidade.wordpress.com" target="_blank">Arte Bicicleta Mobilidade</a></p>
			<p><a href="http://www.bicicleteiros.com.br" target="_blank">Bicicleteiros</a></p>
			<p><a href="http://pedaleiro.com.br" target="_blank">Pedaleiro</a></p>
            
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
			
			<a name="2"><h1>ongs no brasil</h1></a>
			<p><a href="http://www.uniaodeciclistas.org.br" target="_blank">Uni&atilde;o de Ciclistas do Brasil</a></p>
			<p><a href="http://www.abciclovias.com.br" target="_blank">Associa&ccedil;&atilde;o Blumenauense pr&oacute;-Ciclovias</a></p>
			<p><a href="http://www.bicicletada.org" target="_blank">Bicicletada</a><br/>Site brasileiro - Massa Cr&iacute;tica - do movimento internacional a favor da bicicleta como meio de transporte</p>
			<p><a href="http://www.ta.org.br" target="_blank">Associa&ccedil;&atilde;o Transporte Ativo</a></p>
			<p><a href="http://www.ruaviva.org.br" target="_blank">Rua Viva - Instituto de Mobilidade Sustent&aacute;vel</a></p>
			<p><a href="http://www.pedalabrasil.com.br" target="_blank">Instituto Pedala Brasil</a></p>
			<p><a href="http://www.bikebrasil.com.br" target="_blank">Associa&ccedil;&atilde;o Bike Brasil</a></p>
			<p><a href="http://www.ufsm.br/gepec" target="_blank">Grupo de Estudo e Pesquisa em Ciclismo - UFSM</a></p>
			<p><a href="http://www.udesc.br/ciclo" target="_blank">Grupo CicloBrasil - UDESC</a></p>
			<p><a href="http://www.viaciclo.org.br" target="_blank">Associa&ccedil;&atilde;o dos Ciclousu&aacute;rios da Grande Florian&oacute;polis</a></p>
			<p><a href="http://www.abradibi.com.br" target="_blank">ABRADIBI</a><br/>Associa&ccedil;&atilde;o Brasileira dos Fabricantes, Distribuidores, Exportadores e Importadores de Bicicletas, Pe&ccedil;as e Acess&oacute;rios</p>
			<p><a href="http://www.abraciclo.com.br" target="_blank">ABRACICLO</a><br/>Associa&ccedil;&atilde;o Brasileira dos Fabricantes de Motocicletas, Ciclomotores, Motonetas, Bicicletas e Similares</p>
			<p><a href="http://www.antp.org.br" target="_blank">Associa&ccedil;&atilde;o Nacional de Transportes P&uacute;blicos</a></p>
			<p><a href="http://www.cbc.esp.br" target="_blank">Confedera&ccedil;&atilde;o Brasileira de Ciclismo</a></p>
			<p><a href="http://www.sampabikers.com.br" target="_blank">Sampabikers</a><br/>Grupo de ciclistas</p>
			<p><a href="http://www.amigosdebike.com.br" target="_blank">Amigos de Bike</a><br/>Grupo de ciclistas</p>
			<p><a href="http://www.mobilciclo.org" target="_blank">ONG Mobilciclo</a></p>
			<p><a href="http://www.nightbikers.com" target="_blank">Night Bikers Club do Brasil</a></p>
			<p><a href="http://www.rodasdapaz.org.br" target="_blank">ONG Rodas da Paz</a></p>
			<p><a href="http://www.anpet.org.br" target="_blank">Associa&ccedil;&atilde;o Nacional de Pesquisa e Ensino em Transportes</a></p>
			
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
			
			<a name="3"><h1>ongs no exterior</h1></a>
			<p><a href="http://www.sutp.org" target="_blank">Sustainable Urban Transport Project - GTZ</a></p>
			<p><a href="http://www.cycling.nl" target="_blank">I-ce, Interface for Cycling Expertise</a></p>
			<p><a href="http://www.mobilityweek-europe.org" target="_blank">European Mobility Week</a></p>
			<p><a href="http://www.itdp.org" target="_blank">Institute for Transportation & Development Policy</a></p>
			<p><a href="http://www.movilization.org" target="_blank">Movilization - Towards Acessible Cities</a></p>
			<p><a href="http://www.velomondial.net" target="_blank">Funda&ccedil;&atilde;o Holandesa</a></p>
			<p><a href="http://www.ibike.org" target="_blank">International Bicycle Fund</a></p>
			<p><a href="http://www.transalt.org" target="_blank">Transportation Alternatives</a></p>
			<p><a href="http://www.worldcarfree.net" target="_blank">World Carfree Network</a></p>
			<p><a href="http://www.bikewalk.org" target="_blank">National Center for Bicycling & Walking</a></p>
			<p><a href="http://www.bicyclinginfo.org" target="_blank">Pedestrian and Bicycle Information Center</a></p>
			
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
			
			<a name="4"><h1>Informa&ccedil;&otilde;es gerais</h1></a>
			<p><a href="http://www.freeride.blig.ig.com.br" target="_blank">V&aacute; de Bike! Site sobre bicicletas</a></p>
			<p><a href="http://www.escoladebicicleta.com.br" target="_blank">Escola de Bicicleta - cole&ccedil;&atilde;o de textos, artigos e informa&ccedil;&otilde;es sobre bicicletas</a></p>
			<p><a href="http://www.bikemagazine.com.br" target="_blank">Bikemagazine - revista eletr&ocirc;nica</a></p>
			<p><a href="http://www.pedalandoeeducando.com.br" target="_blank">Volta ao mundo de bicicleta</a></p>
			<p><a href="http://www.apocalipsemotorizado.blogspot.com" target="_blank">Blog sobre mobilidade urbana</a></p>
			
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
			
			<a name="5"><h1>Mais links</h1></a>
			<p><a href="http://www.viaciclo.org.br/portal/informacoes/bicicletario-adequado" target="_blank">Biciclet&aacute;rios adequados</a></p>
			<p><a href="http://www.youtube.com/watch?v=wE4fvwTBtno&feature=related" target="_blank">V&iacute;deo: Tokyo Bicycle Parking Tower</a></p>
			<p><a href="http://www.youtube.com/watch?v=Oq3gIVGFTk4" target="_blank">V&iacute;deo: Amsterdam, City of Bikes</a></p>
			
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>

            
      </div><!-- coluna_internas -->
    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
