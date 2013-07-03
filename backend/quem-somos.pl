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
          <li class=\"nav\"><a href=\"#\"><h1>M&iacute\;dia</h1></a>
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
		<div class="imagem-quemsomos">
        </div><!--imagem-->
	</div><!-- cabeca-interna -->
	
	<div id="wrapper">
    	<div id="sidebar-esquerda">
        	
        	<div class="submenu">
            <h1>SUBT&Oacute;PICOS</h1>
            <ul>
            	<a href="#1"><li>Quem Somos</li></a>
                <a href="#2"><li>Objetivo</li></a>
                <a href="#3"><li>A&ccedil;&atilde;o Inicial</li></a>
                <a href="#4"><li>Do que se trata</li></a>
                <a href="#5"><li>Como funciona</li></a>
                <a href="#6"><li>Isto &eacute; poss&iacute;vel?</li></a>
                <a href="#7"><li>Como votar?</li></a>
                <a href="#8"><li>Isso vale?</li></a>
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
            <div style="float:right"><p><a href="https://www.votolivre.org/politica-de-privacidade.html">&bull; pol&iacute;tica de privacidade</a></p></div>
        	<a name="1"><h1>Quem somos?</h1></a>
            <p>N&oacute;s somos a sociedade civil organizada (sem fins lucrativos e sem Partidos Pol&iacute;ticos envolvidos). N&atilde;o somos pol&iacute;ticos, somos curitibanos, pessoas como
voc&ecirc;, arquitetos, engenheiros, m&eacute;dicos, estudantes, funcion&aacute;rios p&uacute;blicos, publicit&aacute;rios, advogados, aposentados, administradores, farmac&ecirc;uticos, empres&aacute;rios, psic&oacute;logos, professores, enfermeiros, dentistas, contadores, fisioterapeutas, ju&iacute;zes, desempregados, bombeiros, policiais, donas de casa, trabalhadores em geral, jornalistas, historiadores, ge&oacute;logos, matem&aacute;ticos, veterin&aacute;rios, astr&ocirc;nomos, pedagogos, soci&oacute;logos, antrop&oacute;logos, fil&oacute;sofos, cientistas, atletas, apresentadores de televis&atilde;o, m&uacute;sicos, artistas, fot&oacute;grafos, bi&oacute;logos, economistas, cozinheiros, secret&aacute;rias, designers, pesquisadores. Somos o povo brasileiro.</p>
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
            <a name="2"><h1>Objetivo</h1></a>
            <p>Encaminhar proposta de lei municipal por iniciativa popular.<br/>
"Artigo 1&ordm; da Constitui&ccedil;&atilde;o Federal/88:- Todo poder emana do povo que o exerce por meio de representantes eleitos, ou <strong>diretamente</strong>."</p>
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
            <a name="3"><h1>A&ccedil;&atilde;o Inicial</h1></a>
            <p>A Lei da Mobilidade Urbana Sustent&aacute;vel (<strong>Lei da Bicicleta</strong>).</p>
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
      	<a name="4"><h1>Do que se trata</h1></a>
        <p>A Lei da Bicicleta institui a bicicleta como modal de transporte regular e estabelece:</p>
            <p>&bull; <strong>5% das vias urbanas</strong> destinadas a constru&ccedil;&atilde;o de <strong>ciclo-faixas</strong> e ciclovias - no modelo funcional, interconectando o centro da Cidade (em Curitiba as ciclovias ligam os parques em modelo tur&iacute;stico).</p>
            <p>&bull; Biciclet&aacute;rios em pontos <strong>estrat&eacute;gicos</strong> da cidade:<br />
              - Terminais de transporte coletivo.<br />
              - Pr&eacute;dios p&uacute;blicos (municipal, estadual e federal).<br />
              - Estabelecimentos de ensino.<br />
              - Estabelecimentos comerciais.<br />
              - Pra&ccedil;as P&uacute;blicas de grande circula&ccedil;&atilde;o do centro da cidade.</p>
            <p>&bull; <strong>Cultura / Educa&ccedil;&atilde;o</strong> - sensibiliza&ccedil;&atilde;o para <strong>cultura do uso da bicicleta</strong> como meio de transporte.</p>
            <p>&bull; <strong>Turismo consciente</strong> - Roteiro tur&iacute;stico para conhecer Curitiba de bicicleta e a implementa&ccedil;&atilde;o de sistema de loca&ccedil;&atilde;o de bicicletas a exemplo do SAMBA (<a href="http://www.zae.com.br/zaerio/sobre.asp" target="_blank">Solu&ccedil;&atilde;o Alternativa para a Mobilidade por Bicicletas de Aluguel</a>), a exemplo das cidades do Rio de Janeiro, Blumenau e Jo&atilde;o Pessoa.</p>
		<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
        
        	<a name="5"><h1>Como funciona</h1></a>
            <p>Para a iniciativa popular propor uma Lei Municipal &eacute; preciso de 5% de votos do eleitorado - em Curitiba isto representa cerca de 65 mil assinaturas</p>
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
      		<a name="6"><h1>Isto &eacute; poss&iacute;vel?</h1></a>
            <p>Sim. Esse procedimento &eacute; previsto na pr&oacute;pria Lei Org&acirc;nica do Munic&iacute;pio de Curitiba*, no seu artigo 7&ordm; e 55, e na Constitui&ccedil;&atilde;o Federal (art. 1&ordm;. e art. 61).</p>
            <p>*Art. 7&ordm; - Todo Poder emana do povo, que o exerce por meio de representantes eleitos, ou <strong>diretamente</strong>.<br />
              Par&aacute;grafo &uacute;nico - A soberania popular ser&aacute; exercida:<br />
              I - Indiretamente, pelo Prefeito e pelos Vereadores eleitos para a C&acirc;mara Municipal, por sufr&aacute;gio universal e pelo voto direto e secreto.<br />
              II - <strong>Diretamente</strong>, nos termos da lei, <strong>em especial, mediante</strong>:<br />
              <strong>a) iniciativa popular;</strong><br />
              b) referendo;<br />
              c) plebiscito.</p>
            <p>Art. 55 - <strong>A iniciativa popular de projetos de lei</strong> de interesse espec&iacute;fico do Munic&iacute;pio, da cidade ou de bairros <strong>poder&aacute; ser exercida por cinco por cento</strong>, pelo menos, <strong>do eleitorado</strong>.</p>
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
      		<a name="7"><h1>Como votar?</h1></a>
            <p>Preenchendo seu cadastro com o nome completo, email, endere&ccedil;o, CPF e t&iacute;tulo de eleitor, em um sistema no site votolivre.org.</p>
            <p><strong>N&atilde;o sabe o n&uacute;mero do seu t&iacute;tulo?</strong><br />
              <a href="http://www.tse.gov.br/internet/servicos_eleitor/consultaNome.htm" target="_blank">Clique aqui e consulte a base de dados do TSE.</a></p>
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
      		<a name="8"><h1>Isso vale?</h1></a>
            <p>Sim, voc&ecirc; est&aacute; manifestando a sua ades&atilde;o ao projeto de lei e o seu voto &eacute; computado por t&iacute;tulo de eleitor mediante verifica&ccedil;&atilde;o do CPF v&aacute;lido.</p>
            <p>A listagem com os dados dos eleitores (t&iacute;tulo eleitoral e endere&ccedil;o) que assinarem a proposta, ser&aacute; entregue na Comiss&atilde;o de Participa&ccedil;&atilde;o Legislativa da C&acirc;mara Municipal de Curitiba (com c&oacute;pia para o Tribunal Regional Eleitoral - TRE/PR), que, em caso de d&uacute;vida, poder&aacute; fazer a respectiva confer&ecirc;ncia da ades&atilde;o do eleitor.<br />
            </p>
            <p><strong>&Eacute; a democracia sendo exercida de forma livre e direta.</strong></p>
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
      </div><!-- coluna_internas -->
    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
