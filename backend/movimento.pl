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
        	<li class=\"nav\"><a href=\"#\"><h1$ativo>Saiba Mais</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/quem-somos.html\"><h2>Quem somos</h2></a></li>
                <li><a href=\"https://www.votolivre.org/movimento.html\"><h2$ativo>O Movimento</h2></a></li>
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
		<div class="imagem-movimento">
        </div><!--imagem-->
	</div><!-- cabeca-interna -->
	
	<div id="wrapper">
    	<div id="sidebar-esquerda">
        	
        	<div class="submenu">
            <h1>SUBT&Oacute;PICOS</h1>
            <ul>
            	<a href="#1"><li>O Movimento</li></a>
                <a href="#2"><li>Votando na Internet</li></a>
                <a href="#3"><li>Lei da Bicicleta</li></a>
             
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
            <div style="float:right"><p><a href="https://www.votolivre.org/politica-de-privacidade.html">&bull; política de privacidade</a></p></div>
        	<a name="1"><h1>O Movimento - Saiba tudo em 5 minutos</h1></a>
            <p>A Constitui&ccedil;&atilde;o de 1988 &eacute; uma constitui&ccedil;&atilde;o cidad&atilde;, citando Ulysses Guimar&atilde;es. Ela &eacute; dotada de mecanismos que permitem ao povo exercer o poder diretamente.</p>
      <p>O <a href="http://www.planalto.gov.br/ccivil_03/constituicao/constituicao.htm" target="_blank">art. 1&ordm;. da Constitui&ccedil;&atilde;o</a> diz que <em>&quot;Todo o poder emana do povo, que o exerce por meio de representantes eleitos ou <strong>diretamente</strong>&quot;</em>. (art. 1&ordm;., par&aacute;grafo &uacute;nico, da CF/88).</p>
            <p><strong>Curitiba consagra a soberania popular</strong>, estabelecendo que &quot;poder&aacute; ser exercida por <strong>cinco por cento</strong>, pelo menos, do eleitorado&quot; (Art. 7&ordm;., II, &quot;a&quot;, e art. 55 da <a href="http://www.leismunicipais.com.br/cgi-local/orglaw.pl?city=Curitiba&amp;state=pr" target="_blank">Lei Org&acirc;nica Municipal</a>).</p>
			<p> Isto representa <strong>65.000 eleitores curitibanos</strong> (isto = a um est&aacute;dio de futebol lotado)</p>
			<p>Para isso &eacute; <strong>necess&aacute;rio</strong> o n&uacute;mero do <strong>t&iacute;tulo do eleitor</strong> (<a href="http://www.leismunicipais.com.br/legislacao-de-curitiba/56805/lei-complementar-2-1991-curitiba-pr.html" target="_blank">Lei Complementar n&ordm; 2/1991</a>), pois n&atilde;o se trata de um abaixo-assinado, mas sim de projeto de lei apresentado pela pr&oacute;pria sociedade.</p>
            <p>Estamos (mal)acostumados a usar o nosso t&iacute;tulo de eleitor apenas nas elei&ccedil;&otilde;es, a cada dois anos e de forma obrigat&oacute;ria. Votamos em pessoas e n&atilde;o em id&eacute;ias.</p>
              <p>Perceba, que n&atilde;o sabemos o n&uacute;mero do nosso t&iacute;tulo de eleitor (e muitas vezes nem sabemos onde ele est&aacute; guardado). Na maioria, sabemos o n&uacute;mero do RG e do CPF, mas n&atilde;o sabemos o n&uacute;mero do documento que nos possibilita exercer a verdadeira cidadania - a <strong>nossa participa&ccedil;&atilde;o na democracia</strong>.</p>
              
              <p><a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a></p>
              
              <a name="2"></a><p><strong>N&atilde;o sabe o n&uacute;mero do seu t&iacute;tulo?</strong> <br/> <a href="http://www.tse.gov.br/internet/servicos_eleitor/consultaNome.htm" target="_blank">Clique aqui e consulte a base de dados do TSE;</a></p>
              <p>E hoje em dia <strong>&eacute; poss&iacute;vel usar a internet</strong> para captar essas assinaturas/informa&ccedil;&otilde;es/votos.</p>
              <p>Inclusive, o Instituto Nacional de Tecnologia da Informa&ccedil;&atilde;o - ITI, prev&ecirc; a possibilidade de usar a informa&ccedil;&atilde;o digital para<em> &quot;facilitar a iniciativa popular na apresenta&ccedil;&atilde;o de projetos de lei, uma vez que os cidad&atilde;os poder&atilde;o assinar digitalmente sua ades&atilde;o &agrave;s propostas&quot;</em>, por meio de <a href="http://www.iti.gov.br/twiki/bin/view/Certificacao/PerguntaDoze" target="_blank">Certifica&ccedil;&atilde;o Digital</a>.</p>
              <p>E tem mais, segundo frisa o pr&oacute;prio ITI, o &sect; 2&ordm; do art. 10 da Medida Provis&oacute;ria n&ordm; 2.200-2 disp&otilde;e que outros <a href="http://www.iti.gov.br/twiki/bin/view/Certificacao/PerguntaDezenove" target="_blank">&quot;documentos eletr&ocirc;nicos assinados digitalmente&quot; &quot;tamb&eacute;m t&ecirc;m validade jur&iacute;dica, mas esta depender&aacute; da aceita&ccedil;&atilde;o de ambas as partes, emitente e destinat&aacute;rio&quot;</a>. (mesmo sem a Certifica&ccedil;&atilde;o Digital, que ainda tenho custo muito alto no pa&iacute;s)</p>
              <p>Isto tem validade da mesma forma que voc&ecirc; faz compras e assina contratos via internet. Inclusive a Internet j&aacute; &eacute; usada em processos como prova documental, sendo que alguns tribunais brasileiros come&ccedil;aram a aceitar peti&ccedil;&otilde;es eletr&ocirc;nicas, em lugar de processos de papel. Por isso que voc&ecirc; preenche um cadastro declarando a veracidade de suas informa&ccedil;&otilde;es, mediante apresenta&ccedil;&atilde;o de CPF v&aacute;lido.</p>
      <p>A listagem com os dados dos eleitores (t&iacute;tulo eleitoral e endere&ccedil;o), que assinarem a proposta, ser&aacute; entregue na Comiss&atilde;o de Participa&ccedil;&atilde;o Legislativa da C&acirc;mara Municipal de Curitiba (com c&oacute;pia para o Tribunal Regional Eleitoral - TRE/PR), que, em caso de d&uacute;vida, poder&aacute; fazer a respectiva confer&ecirc;ncia da ades&atilde;o do eleitor.</p>
            
            
			<p>Justamente para demonstrar a viabilidade dessa id&eacute;ia que o site <strong>votolivre.org</strong> foi criado.</p>
			
			<p><a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a></p>
			
			  <a name="3"><p>Escolhemos como projeto piloto para Curitiba a <strong>Lei da Bicicleta</strong> (Lei da Mobilidade Urbana Sustent&aacute;vel), que institui a bicicleta como modal de transporte regular estabelece:</p></a>
			  <p>- <strong>5% das vias urbanas</strong> destinadas a constru&ccedil;&atilde;o de <strong>ciclo-faixas e ciclovias</strong> no <strong>modelo funcional</strong>, interconectando o Centro da Cidade (em Curitiba as ciclovias ligam os parques em modelo tur&iacute;stico)<br />
			  - <strong>Bibiclet&aacute;rios</strong> em pontos <strong>estrat&eacute;gicos</strong> da cidade:<br />
			  - Terminais de transporte coletivo<br />
			  - Pr&eacute;dios p&uacute;blicos (municipal, estadual e federal)<br />
			  - Estabelecimentos de ensino<br />
			  - Estabelecimentos comerciais<br />
			  - Pra&ccedil;as P&uacute;blicas de grande circula&ccedil;&atilde;o do centro da cidade<br />
			  - <strong>Cultura/Educa&ccedil;&atilde;o</strong> - Sensibiliza&ccedil;&atilde;o para <strong>cultura do uso da bicicleta</strong> como meio de transporte<br />
			  - <strong>Turismo consciente</strong> - Roteiro tur&iacute;stico para conhecer Curitiba de bicicleta e a implementa&ccedil;&atilde;o de sistema de loca&ccedil;&atilde;o de bicicletas a exemplo do SAMBA (<a href="http://www.zae.com.br/zaerio/sobre.asp" target="_blank">Solu&ccedil;&atilde;o Alternativa para a Mobilidade por Bicicletas de Aluguel</a>), a exemplo das cidades do Rio de Janeiro, Blumenau e Jo&atilde;o Pessoa.</p>
              <p><a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a></p>
              
			  <p><strong>Por que come&ccedil;ar com a Lei da Bicicleta?</strong></p>
			  <p>Porque &eacute; um tema necess&aacute;rio e o transporte ciclovi&aacute;rio &eacute; algo poss&iacute;vel, sustent&aacute;vel, real e de baixo custo de implanta&ccedil;&atilde;o. E nossa Capital Ecol&oacute;gica n&atilde;o trata a bicicleta como meio de transporte modal. <strong>Vamos melhorar o transporte e o tr&acirc;nsito de</strong> <a href="http://www.curitibanacopa.com.br/" target="_blank">Curitiba para Copa 2014</a>.</p>
			  <p>Al&eacute;m disso, o governo j&aacute; tem todo estudo e percurso sobre a Mobilidade Urbana Sustent&aacute;vel, sendo consenso governamental a necessidade do fomento do uso da bicicleta como meio de transporte urbano, conforme o Programa Brasileiro de Mobilidade por Bicicleta (<a href="http://www.cidades.gov.br/images/stories/ArquivosSEMOB/Biblioteca/LivroBicicletaBrasil.pdf" target="_blank">Programa Bicicleta Brasil</a>), do Minist&eacute;rio das Cidades.</p>
			  <p>J&aacute; existem projetos equivalentes em v&aacute;rias cidades do Brasil. &Eacute; um tema necess&aacute;rio. Inclusive, a segunda vers&atilde;o do PAC prev&ecirc; investimentos de R\$ 18 bilh&otilde;es para mobilidade urbana, &aacute;rea que concentra os programas de transportes nos centros urbanos. Conforme o <a href="http://www.curitibanacopa.com.br/pac-2-inclui-estudos-para-tres-novas-linhas-de-trem-bala/" target="_blank">documento divulgado pelo governo</a>, ser&atilde;o investidos R\$ 6 bilh&otilde;es do Or&ccedil;amento Geral da Uni&atilde;o (OGU) e R\$ 12 bilh&otilde;es em financiamentos pelo prazo de 2011 a 2014 (PAC da Mobilidade Urbana da Copa do Mundo de 2014).</p>
			  <p>Mas nossos governantes ainda n&atilde;o perceberam a melhoria da mobilidade no tr&acirc;nsito de Curitiba como uma prioridade pol&iacute;tica. Exatamente por isso a <strong>sociedade</strong> pode e deve <strong>manifestar</strong> a sua <strong>vontade</strong>.</p>
			  <p>Essa &eacute; a hora da sociedade acordar e agir.<br />
			  A sua <strong>participa&ccedil;&atilde;o</strong> &eacute; fundamental para o <strong>sucesso da a&ccedil;&atilde;o</strong>.<br />
			  <strong>Prepare Curitiba para a Copa 2014!</strong></p>
		    <p>&Eacute; a <strong>democracia exercida</strong> de forma <strong>livre e direta</strong>.</p>
			<p><a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a></p>
</div><!-- coluna_internas -->
    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
