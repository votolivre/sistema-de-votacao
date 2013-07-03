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
                <li><a href=\"https://www.votolivre.org/movimento.html\"><h2>O Movimento</h2></a></li>
                <li><a href=\"https://www.votolivre.org/lei-municipal.html\"><h2$ativo>Lei Municipal</h2></a></li>
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
		<div class="imagem-leimunicipal">
        </div><!--imagem-->
	</div><!-- cabeca-interna -->
	
	<div id="wrapper">
    	<div id="sidebar-esquerda">
        	
        	<div class="submenu">
            <h1>SUBT&Oacute;PICOS</h1>
            <ul>
            
                <a href="#1"><li>Texto da Lei</li></a>
                <a href="#2"><li>Justificativa da Lei</li></a>
                <a href="#3"><li>Gloss&aacute;rio</li></a>
                <a href="#4"><li>Plano diretor de Curitiba</li></a>
                <a href="#5"><li>Iniciativa popular</li></a>
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

        	<a name="1"><h1>Texto da Lei</h1></a>
        	<p><strong>PROJETO DE LEI COMPLEMENTAR DE INICIATIVA POPULAR, de 25 de julho de 2010.</strong></p>
            
        	<p><strong>LEI DA MOBILIDADE URBANA SUSTENT&Aacute;VEL (LEI DA BICILETA)</strong>: institui a bicicleta como modal de transporte regular em Curitiba.<br />
              <br />
Art. 1&ordm;. Fica instituída a bicicleta como modal de transporte regular em Curitiba, determinando-se que 5% (cinco por cento) das vias urbanas serão destinadas a construção de ciclo-faixas e ciclovias, em modelo funcional, interconectando o centro da cidade, integrado ao transporte coletivo.<br />
<br />
Art. 2&ordm;. Ter&atilde;o espa&ccedil;os reservados para bicicletas, na forma de biciclet&aacute;rios e/ou estacionamentos:<br />
<br />
I - Os terminais de transporte coletivo;<br />
<br />
II - Os pr&eacute;dios p&uacute;blicos municipal, estadual e federal;<br />
<br />
III - Os estabelecimentos de ensino;<br />
<br />
IV - Os complexos comerciais tipo shopping centers e supermercados;<br />
<br />
V - Pra&ccedil;as e parques p&uacute;blicos.<br />
<br />
Art. 3&ordm;. Ser&atilde;o realizadas campanhas para educa&ccedil;&atilde;o e sensibiliza&ccedil;&atilde;o para cultura do uso da bicicleta como meio de transporte, inclusive fazendo uso continuo do mobili&aacute;rio urbano para incentivar a sua utiliza&ccedil;&atilde;o e promover seus benef&iacute;cios.<br />
<br />
Art. 4&ordm;. Ser&atilde;o implementados biciclet&aacute;rios em pontos estrat&eacute;gicos da cidade para loca&ccedil;&atilde;o de bicicletas a exemplo dos moldes do sistema SAMBA - Solu&ccedil;&atilde;o Alternativa para a Mobilidade por Bicicletas de Aluguel (a exemplo da cidade do Rio de Janeiro).<br />
<br />
Art. 5&ordm;. Esta Lei Complementar substitui todos os projetos em andamento que disponham sobre o uso da bicicleta como meio de transporte modal em Curitiba e sobre a constru&ccedil;&atilde;o de biciclet&aacute;rios.<br />
<br />
Art. 6&ordm;. O Instituto de Pesquisa e Planejamento Urbano de Curitiba - IPPUC ter&aacute; o prazo de 270 (duzentos e setenta) dias para apresentar os estudos para implementa&ccedil;&atilde;o das ciclovias, ciclo-faixas e dos biciclet&aacute;rios.<br />
<br />
Art. 7&ordm;. As despesas decorrentes da aplicação desta lei serão suportadas pelo Orçamento do Município de Curitiba, bem como de parcela do Fundo Nacional de Segurança e Educação de Trânsito de competência do Município de Curitiba, decorrente da arrecadação das infrações de trânsito urbano, que será revertida no percentual mínimo de 20% (vinte por cento) para despesas relacionadas à sustentabilidade urbana, suplementadas, se necessário.<br />
<br />
Art. 8&ordm;. O Poder Executivo regulamentar&aacute; a presente lei no prazo de 90 (noventa) dias a contar de sua publica&ccedil;&atilde;o.<br />
<br />
Art. 9&ordm;. Esta Lei Complementar entra em vigor na data de sua publica&ccedil;&atilde;o, revogadas as disposi&ccedil;&otilde;es em contr&aacute;rio.<br />
<br />
Curitiba, aos 25 de julho de 2010.<br />
<br />
INICIATIVA POPULAR</p>

		<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
        
        	<a name="2"><h1>Justificativa da Lei</h1></a>
        	  <p>Mobilidade Urbana Sustent&aacute;vel:</strong> <br />
  <br />
        	  Tem como objetivo principal instituir a bicicleta como transporte modal em Curitiba, com o escopo de redu&ccedil;&atilde;o dos impactos ambientais e sociais da mobilidade motorizada existente. <br />
  <br />
        	  a) Busca a apropria&ccedil;&atilde;o eq&uuml;itativa do espa&ccedil;o e do tempo na circula&ccedil;&atilde;o urbana, priorizando os modos de transporte coletivo, a p&eacute; e de bicicleta, em rela&ccedil;&atilde;o ao autom&oacute;vel particular.<br />
        	  b) Promove o reordenamento dos espa&ccedil;os e das atividades urbanas, de forma a reduzir as necessidades de deslocamento motorizado e seus custos.<br />
        	  c) Promove a efici&ecirc;ncia e a qualidade nos servi&ccedil;os de transporte p&uacute;blico, com apropria&ccedil;&atilde;o social dos ganhos de produtividade decorrentes.<br />
        	  d) Amplia o conceito de transporte para o de comunica&ccedil;&atilde;o, atrav&eacute;s da utiliza&ccedil;&atilde;o de novas tecnologias.<br />
        	  e) Promove o desenvolvimento das cidades com qualidade de vida, atrav&eacute;s de um conceito de transporte consciente, sustent&aacute;vel, ecol&oacute;gico e participativo.<br />
        	  f) Promove a paz e a cidadania no tr&acirc;nsito.<br />
        	  g) Contribui para a efici&ecirc;ncia energ&eacute;tica e busca reduzir a emiss&atilde;o de agentes poluidores, sonoros e atmosf&eacute;ricos <br />
        	  h) Preserva, defende e promove, nos projetos e pol&iacute;ticas p&uacute;blicas voltadas ao transporte p&uacute;blico e &agrave; circula&ccedil;&atilde;o urbana, a qualidade do ambiente natural e constru&iacute;do, e o patrim&ocirc;nio hist&oacute;rico, cultural e art&iacute;stico das cidades.<br />
  <br />
        	  Para ressaltar a <strong>relev&acirc;ncia s&oacute;cio-pol&iacute;tico-ambiental e econ&ocirc;mica</strong> da presente propositura, destacamos alguns <strong>benef&iacute;cios do uso da bicicleta</strong>.<br />
  <br />
  <strong>Para o usu&aacute;rio</strong>:<br />
        	  - melhora a sa&uacute;de e a auto-estima <br />
        	  - propicia liberdade <br />
        	  - &eacute; excelente para pequenas compras <br />
        	  - estaciona facilmente <br />
        	  - &eacute; de custo acess&iacute;vel <br />
        	  - &eacute; o mais pr&aacute;tico meio de locomo&ccedil;&atilde;o para pequenos trajetos <br />
        	  - possibilita f&aacute;cil integra&ccedil;&atilde;o ao sistema de transporte coletivo <br />
  <br />
  <strong>Para a sociedade</strong>: <br />
        	  - reaviva o bairro e a comunidade <br />
        	  - diminui custos previdenci&aacute;rios <br />
        	  - economiza espa&ccedil;o urbano <br />
        	  - diminui o n&uacute;mero de ve&iacute;culos nas ruas <br />
        	  - diminui conflitos de tr&acirc;nsito <br />
        	  - melhora todos os &iacute;ndices ambientais <br />
  <br />
  <strong>Para a Administra&ccedil;&atilde;o P&uacute;blica</strong>:<br />
        	  - humaniza e valoriza a imagem da administra&ccedil;&atilde;o<br />
        	  - &eacute; um meio de locomo&ccedil;&atilde;o simp&aacute;tico &agrave; popula&ccedil;&atilde;o e com grande demanda reprimida<br />
        	  - &eacute; ferramenta importante na educa&ccedil;&atilde;o para o tr&acirc;nsito<br />
        	  - facilita o acesso ao pequeno com&eacute;rcio e polos geradores de produtos e servi&ccedil;os<br />
        	  - apresenta interven&ccedil;&otilde;es vi&aacute;rias, na sua maioria, simples e de baixo custo, e melhoram as condi&ccedil;&otilde;es de mobilidade de todos os n&atilde;o motorizados:<br />
        	  - pedestres, crian&ccedil;as, idosos<br />
        	  - cadeirantes<br />
        	  - skates, patins e outros<br />
  <br />
  <strong>Benef&iacute;cios de uma Bicicleta:<br />
  </strong><br />
        	  - promove a liberdade<br />
        	  - faz sentir o vento no rosto<br />
        	  - n&atilde;o congestiona a cidade<br />
        	  - n&atilde;o precisa pagar gasolina e impostos<br />
        	  - colabora com a sua sa&uacute;de e a do planeta<br />
        	  - te deixa bem pr&oacute;ximo da paisagem<br />
        	  - ela carrega sua bagagem<br />
        	  - n&atilde;o polui<br />
        	  - &eacute; silenciosa </p>
            <p align="center">Trechos do<strong><br />
              PROGRAMA BRASILEIRO DE MOBILIDADE<br />
              POR BICICLETA LIVRO BICICLETA BRASIL*<br />
              que fazem parte da justificativa e fundamenta&ccedil;&atilde;o do projeto de lei e indicam fontes para os recursos financeiros</strong></p>
            <br />
<p>*Caderno de refer&ecirc;ncia para elabora&ccedil;&atilde;o de Plano de Mobilidade por Bicicleta nas Cidades. Bras&iacute;lia: Secretaria Nacional de Transporte e da Mobilidade Urbana, 2007.<br />
<br />
<br />
<strong>Apresenta&ccedil;&atilde;o</strong><br />
<br />
O Minist&eacute;rio das Cidades, no processo de implementa&ccedil;&atilde;o da Pol&iacute;tica de Mobilidade Urbana para a Constru&ccedil;&atilde;o de Cidades Sustent&aacute;veis, busca a inclus&atilde;o social, a sustentabilidade ambiental, a gest&atilde;o participativa e a eq&uuml;idade no uso do espa&ccedil;o p&uacute;blico.<br />
<br />
Analisando a realidade das cidades brasileiras, a SeMob - Secretaria Nacional de Transporte e da Mobilidade Urbana - verificou o uso crescente da bicicleta como meio de transporte n&atilde;o somente para atividades de lazer, mas por motivo de trabalho e estudo, e considera fundamental que seja dado a este modo de transporte o tratamento adequado ao papel que ele desempenha nos deslocamentos urbanos de milhares de pessoas. Isto exige pol&iacute;ticas p&uacute;blicas espec&iacute;ficas que devem ser implementadas pelas tr&ecirc;s esferas de governo.<br />
<br />
Ap&oacute;s o estabelecimento das diretrizes da Pol&iacute;tica Nacional da Mobilidade Urbana, discutidos no processo da Confer&ecirc;ncia das Cidades, a SeMob implementou um f&oacute;rum para discuss&atilde;o do Programa Brasileiro de Mobilidade por Bicicleta - Bicicleta Brasil, lan&ccedil;ado em setembro de 2004, no qual foi discutida uma pol&iacute;tica espec&iacute;fica para o transporte ciclovi&aacute;rio no Brasil.<br />
<br />
A inclus&atilde;o da bicicleta nos deslocamentos urbanos deve ser considerada elemento fundamental para a implanta&ccedil;&atilde;o do conceito de Mobilidade Urbana para constru&ccedil;&atilde;o de cidades sustent&aacute;veis, como forma de redu&ccedil;&atilde;o do custo da mobilidade das pessoas e da degrada&ccedil;&atilde;o do meio ambiente. Sua integra&ccedil;&atilde;o aos modos coletivos de transporte &eacute; poss&iacute;vel, principalmente com os sistemas de alta capacidade, o que j&aacute; tem ocorrido, mesmo que espontaneamente, em muitas grandes cidades.<br />
<br />
Este &quot;Caderno de Refer&ecirc;ncia para elabora&ccedil;&atilde;o de Plano de Mobilidade por Bicicleta nas Cidades&quot; representa um esfor&ccedil;o da SeMob em fornecer subs&iacute;dios para os munic&iacute;pios que t&ecirc;m inten&ccedil;&atilde;o de implantar um plano ciclovi&aacute;rio, integrado aos demais modos existentes, formando uma rede de transporte. Portanto, ele servir&aacute; como um importante instrumento para a formula&ccedil;&atilde;o e desenvolvimento da mobilidade urbana devendo considerar-se as caracter&iacute;sticas locais e regionais, sempre com a participa&ccedil;&atilde;o da sociedade, sobretudo das organiza&ccedil;&otilde;es de usu&aacute;rios de bicicletas.<br />
<br />
<strong>Renato Boareto<br />
Diretor de Mobilidade Urbana</strong><br />
<br />
<br />
<strong>1.1 - O Espa&ccedil;o Urbano</strong><br />
<br />
Em 1988, a Constitui&ccedil;&atilde;o Federal da Rep&uacute;blica incluiu, pela primeira vez na hist&oacute;ria, um cap&iacute;tulo espec&iacute;fico para a pol&iacute;tica urbana, que prev&ecirc; uma s&eacute;rie de instrumentos para a garantia, no &acirc;mbito de cada munic&iacute;pio, do direito &agrave; cidade, da defesa da fun&ccedil;&atilde;o social da propriedade e da democratiza&ccedil;&atilde;o da gest&atilde;o urbana. No entanto, o texto constitucional necessitava de uma legisla&ccedil;&atilde;o complementar de regulamenta&ccedil;&atilde;o desses instrumentos e, como resultado de mais de uma d&eacute;cada de negocia&ccedil;&otilde;es, foi aprovada em 2001 a Lei 10.257 - Estatuto da Cidade - que regulamentou os art. 182 e 183 da Constitui&ccedil;&atilde;o Federal e estabeleceu diretrizes gerais da pol&iacute;tica urbana. O Estatuto da Cidade garante o direito &agrave;s cidades sustent&aacute;veis, entendido como direito &agrave; terra urbana, &agrave; moradia, ao saneamento ambiental, &agrave; infra-estrutura urbana, ao transporte e aos servi&ccedil;os p&uacute;blicos, ao trabalho e ao lazer, para as presentes e futuras gera&ccedil;&otilde;es.<br />
<br />
A inclus&atilde;o social passa a ser o foco central de toda a&ccedil;&atilde;o p&uacute;blica, contemplando tamb&eacute;m a equipara&ccedil;&atilde;o de oportunidades para as pessoas com defici&ecirc;ncia e restri&ccedil;&atilde;o de mobilidade, criando um novo processo de constru&ccedil;&atilde;o voltado ao exerc&iacute;cio da cidadania para todos.<br />
<br />
<strong>1.2 - Pol&iacute;tica Nacional de Mobilidade Urbana</strong><br />
<br />
A formula&ccedil;&atilde;o da pol&iacute;tica para constru&ccedil;&atilde;o de cidades sustent&aacute;veis veio promover a participa&ccedil;&atilde;o do Governo Federal, com proposi&ccedil;&otilde;es de planejamento integrado nas quest&otilde;es de mobilidade urbana. Essa pol&iacute;tica tem foco na intersec&ccedil;&atilde;o de quatro campos de a&ccedil;&atilde;o: desenvolvimento urbano, sustentabilidade ambiental, inclus&atilde;o social e democratiza&ccedil;&atilde;o do espa&ccedil;o. Esse &uacute;ltimo inclui o acesso democr&aacute;tico &agrave; cidade e a valoriza&ccedil;&atilde;o dos deslocamentos de ciclistas.<br />
<br />
A inclus&atilde;o da bicicleta nos deslocamentos urbanos deve ser abordada como elemento para a implementa&ccedil;&atilde;o do conceito de Mobilidade Urbana para cidades sustent&aacute;veis como forma de inclus&atilde;o social, de redu&ccedil;&atilde;o e elimina&ccedil;&atilde;o de agentes poluentes e melhoria da sa&uacute;de da popula&ccedil;&atilde;o.<br />
<br />
A integra&ccedil;&atilde;o da bicicleta nos atuais sistemas de circula&ccedil;&atilde;o &eacute; poss&iacute;vel, mas ela deve ser considerada como elemento integrante de um novo desenho urbano, que contemple a implanta&ccedil;&atilde;o de infra-estruturas, bem como novas reflex&otilde;es sobre o uso e a ocupa&ccedil;&atilde;o do solo urbano.<br />
<br />
<strong>1.4 - O Planejamento da Mobilidade Urbana</strong><br />
<br />
O Plano Diretor de Transporte e da Mobilidade &eacute; um instrumento da pol&iacute;tica de desenvolvimento urbano, integrado ao Plano Diretor do munic&iacute;pio, da regi&atilde;o metropolitana ou da regi&atilde;o integrada de desenvolvimento, contendo diretrizes, instrumentos, a&ccedil;&otilde;es e projetos voltados &agrave; proporcionar o acesso amplo e democr&aacute;tico &agrave;s oportunidades que a cidade oferece, atrav&eacute;s do planejamento da infra-estrutura de mobilidade urbana, dos meios de transporte e seus servi&ccedil;os possibilitando condi&ccedil;&otilde;es adequadas ao exerc&iacute;cio da mobilidade da popula&ccedil;&atilde;o e da log&iacute;stica de distribui&ccedil;&atilde;o de bens e servi&ccedil;os.<br />
<br />
<strong>PRINC&Iacute;PIOS DA NOVA VISÃO DE MOBILIDADE URBANA</strong><br />
<br />
Diminuir a necessidade de viagens motorizadas.<br />
&bull; Posicionando melhor os equipamentos sociais, descentralizando os servi&ccedil;os p&uacute;blicos, ocupando os vazios urbanos, consolidando a multi-centralidade, como forma de aproximar as possibilidades de trabalho e a oferta de servi&ccedil;os dos locais de moradia.<br />
<br />
Repensar o desenho urbano.<br />
&bull; Planejando o sistema vi&aacute;rio como suporte da pol&iacute;tica de mobilidade, com prioridade para a seguran&ccedil;a e a qualidade de vida dos moradores em detrimento a fluidez do tr&aacute;fego de ve&iacute;culos de passagem.<br />
<br />
Repensar a circula&ccedil;&atilde;o de ve&iacute;culos.<br />
&bull; Priorizando os meios n&atilde;o motorizados e de transporte coletivo nos planos e projetos considerando que a maioria das pessoas utiliza esses modos para seus deslocamentos e n&atilde;o o transporte individual. A cidade n&atilde;o pode ser pensada como, se um dia, todas as pessoas fossem ter um autom&oacute;vel.<br />
<br />
Desenvolver meios n&atilde;o motorizados de transporte.<br />
&bull; Passando a valorizar a bicicleta como meio de transporte importante, integrando-a como os modos de transporte coletivo.<br />
<br />
Reconhecer a import&acirc;ncia do deslocamento de pedestres.<br />
&bull; Valorizando o caminhar como um modo de transporte para a realiza&ccedil;&atilde;o de viagens curtas e incorporando definitivamente a cal&ccedil;ada como parte da via p&uacute;blica, como tratamento espec&iacute;fico.<br />
<br />
Reduzir os impactos ambientais da mobilidade urbana.<br />
&bull; Uma vez que toda viagem motorizada que usa combust&iacute;vel, produz polui&ccedil;&atilde;o sonora e atmosf&eacute;rica.<br />
<br />
Proporcionar mobilidade &agrave;s pessoas com defici&ecirc;ncia e restri&ccedil;&atilde;o de mobilidade.<br />
&bull; Permitindo o acesso dessas pessoas &agrave; cidade e aos servi&ccedil;os urbanos.<br />
<br />
Priorizar o transporte coletivo no sistema vi&aacute;rio.<br />
&bull; Racionalizando os sistemas p&uacute;blicos e desestimulando o uso do transporte individual.<br />
<br />
Considerar o transporte hidrovi&aacute;rio.<br />
&bull; Nas cidades onde ele possa ser melhor aproveitado.<br />
<br />
Estruturar a gest&atilde;o local.<br />
&bull; Fortalecendo o papel regulador dos &oacute;rg&atilde;os p&uacute;blicos gestores dos servi&ccedil;os de transporte p&uacute;blico e tr&acirc;nsito.<br />
<br />
<strong>1.5 - Incentivos e financiamento ao uso da bicicleta como meio de transporte</strong><br />
<br />
A Secretaria Nacional de Transporte e da Mobilidade Urbana - SeMob - tem promovido investimentos e debates para integra&ccedil;&atilde;o da bicicleta nos demais sistemas de transportes coletivos. Nesse sentido, a SeMob atualmente &eacute; gestora de tr&ecirc;s programas que direcionam recursos para projetos e obras de desenvolvimento ciclovi&aacute;rio:<br />
<br />
1) Programa de Mobilidade Urbana, atrav&eacute;s da a&ccedil;&atilde;o Apoio a Projetos de Sistemas de Circula&ccedil;&atilde;o N&atilde;o Motorizados, com recursos do Or&ccedil;amento Geral da Uni&atilde;o - OGU;<br />
<br />
2) Programa de Infra-estrutura para Mobilidade Urbana - Pr&oacute;-Mob, atrav&eacute;s de modalidades que ap&oacute;iam a circula&ccedil;&atilde;o n&atilde;o-motorizada (bicicleta e pedestre), para financiamento com recursos do Fundo de Amparo ao Trabalhador (FAT);<br />
<br />
3) Pr&oacute;-Transporte para financiamento de infra-estrutura para o transporte coletivo urbano com recursos do FGTS que atende, al&eacute;m dos &oacute;rg&atilde;os gestores de Munic&iacute;pios e Estados, a empresas concession&aacute;rias.<br />
<br />
Nestes programas, s&atilde;o disponibilizados recursos para desenvolvimento de projetos e/ou implanta&ccedil;&atilde;o de infra-estrutura para a circula&ccedil;&atilde;o segura de bicicleta nos espa&ccedil;os urbanos, tais como ciclovias, ciclofaixas e sinaliza&ccedil;&atilde;o, preferencialmente integradas ao sistema de transporte coletivo. Ao aportar recursos neste modo de transporte, o governo enfatiza o esfor&ccedil;o em quebrar paradigmas e tratar a quest&atilde;o dos transportes de maneira integrada e sustent&aacute;vel.<br />
<br />
A implementa&ccedil;&atilde;o do Programa Bicicleta Brasil, que n&atilde;o destina recursos para projetos e obras de infra-estrutura, &eacute; poss&iacute;vel atrav&eacute;s dos recursos da a&ccedil;&atilde;o Apoio a Projetos de Sistemas de Circula&ccedil;&atilde;o N&atilde;o Motorizados, do Programa de Mobilidade Urbana.<br />
<br />
<strong>1.6 - Programas de Mobilidade por meios n&atilde;o motorizados</strong><br />
<br />
H&aacute; cada vez maior clareza no plano internacional que o transporte motorizado, apesar de suas vantagens, resulta em impactos ambientais negativos, como a polui&ccedil;&atilde;o sonora e atmosf&eacute;rica, derivada da primazia no uso de combust&iacute;veis f&oacute;sseis como fonte energ&eacute;tica, bem como de outros insumos que geram grande quantidade de res&iacute;duos, como pneus, &oacute;leos e graxas. N&atilde;o h&aacute; solu&ccedil;&atilde;o poss&iacute;vel dentro do padr&atilde;o de expans&atilde;o atual, com os custos cada vez mais crescentes de infra-estruturas para os transportes motorizados, o que compromete boa parte dos or&ccedil;amentos municipais.<br />
<br />
Nesse sentido, a SeMob reconhece a import&acirc;ncia de propor alternativas de desenvolvimento e p&otilde;e em pr&aacute;tica v&aacute;rias a&ccedil;&otilde;es em busca de cidades sustent&aacute;veis.<br />
<br />
<strong>1.6.2 - Programa Bicicleta Brasil</strong><br />
<br />
Muitas cidades brasileiras v&ecirc;m apresentando crescente uso da bicicleta como meio de transporte para o trabalho e para o estudo, al&eacute;m das atividades de lazer. Entretanto, tais usos necessitam de tratamentos adequados, al&eacute;m de exigirem pol&iacute;ticas p&uacute;blicas espec&iacute;ficas, diante do papel que a bicicleta desempenha nos deslocamentos urbanos de milh&otilde;es de pessoas.<br />
<br />
A inclus&atilde;o da bicicleta como modal de transporte regular nos deslocamentos urbanos deve ser abordada considerando o novo conceito de Mobilidade Urbana Sustent&aacute;vel, e tamb&eacute;m por representar a redu&ccedil;&atilde;o do custo da mobilidade para as pessoas. Sua integra&ccedil;&atilde;o aos modos coletivos de transporte deve ser buscada principalmente junto aos sistemas de grande capacidade.<br />
<br />
A inser&ccedil;&atilde;o da bicicleta nos atuais sistemas de transportes deve ser buscada daqui em diante respeitando o conceito de Mobilidade Urbana para constru&ccedil;&atilde;o de cidades sustent&aacute;veis. Dentro desta nova &oacute;tica, os novos sistemas devem incorporar a constru&ccedil;&atilde;o de ciclovias e ciclofaixas, principalmente nas &aacute;reas de expans&atilde;o urbana. Torna-se necess&aacute;ria tamb&eacute;m na amplia&ccedil;&atilde;o do provimento de infra-estrutura, a inclus&atilde;o do moderno conceito de vias cicl&aacute;veis, que s&atilde;o vias de tr&aacute;fego compartilhado adaptadas para o uso seguro da bicicleta.<br />
<br />
Ao desenvolver o Programa Brasileiro de Mobilidade por Bicicleta, a SeMob procura estimular os Governos Municipais, Estaduais e do Distrito Federal, a desenvolver e aprimorar a&ccedil;&otilde;es que favore&ccedil;am o uso mais seguro da bicicleta como modo de transporte.<br />
<br />
<strong>Objetivos:</strong><br />
<br />
o inserir e ampliar o transporte por bicicleta na matriz de deslocamentos urbanos;<br />
o promover sua integra&ccedil;&atilde;o aos sistemas de transportes coletivos, visando reduzir o custo de deslocamento, principalmente da popula&ccedil;&atilde;o de menor renda;<br />
o estimular os governos municipais a implantar sistemas ciclovi&aacute;rios e um conjunto de a&ccedil;&otilde;es que garantam a seguran&ccedil;a de ciclistas nos deslocamentos urbanos;<br />
o difundir o conceito de mobilidade urbana sustent&aacute;vel, estimulando os meios n&atilde;o motorizados de transporte, inserindo-os no desenho urbano.<br />
<br />
<strong>A&ccedil;&otilde;es previstas:</strong><br />
<br />
1. capacita&ccedil;&atilde;o de gestores p&uacute;blicos para a elabora&ccedil;&atilde;o e implanta&ccedil;&atilde;o de sistemas ciclovi&aacute;rios;<br />
2. integra&ccedil;&atilde;o da bicicleta no planejamento de sistemas de transportes e equipamentos p&uacute;blicos;<br />
3. est&iacute;mulo &agrave; integra&ccedil;&atilde;o das a&ccedil;&otilde;es das tr&ecirc;s esferas de Governo;<br />
4. sensibiliza&ccedil;&atilde;o da sociedade para a efetiva&ccedil;&atilde;o do Programa;<br />
5. est&iacute;mulo ao desenvolvimento tecnol&oacute;gico;<br />
6. fomento &agrave; implementa&ccedil;&atilde;o de infra-estrutura para o uso da bicicleta.<br />
<br />
<strong>Instrumentos de Implementa&ccedil;&atilde;o:</strong><br />
<br />
1. publica&ccedil;&atilde;o de material informativo e de capacita&ccedil;&atilde;o;<br />
2. realiza&ccedil;&atilde;o de cursos e semin&aacute;rios nacionais e internacionais;<br />
3. edi&ccedil;&atilde;o de normas e diretrizes;<br />
4. realiza&ccedil;&atilde;o e fomento de pesquisas;<br />
5. implanta&ccedil;&atilde;o de banco de dados;<br />
6. fomento &agrave; implementa&ccedil;&atilde;o de Programas Municipais de Mobilidade por Bicicleta;<br />
7. cria&ccedil;&atilde;o de novas fontes de financiamento;<br />
8. divulga&ccedil;&atilde;o das Boas Pol&iacute;ticas.<br />
<br />
<strong>2.4.2 - Considera&ccedil;&otilde;es sobre a Infra-estrutura Pr&oacute;-Bicicleta no Brasil</strong><br />
<br />
Historicamente tem-se investido poucos recursos em infra-estrutura para a bicicleta nas cidades brasileiras, resultado da pouca import&acirc;ncia dada a ela como alternativa de transporte. Na Europa, por exemplo, onde a bicicleta &eacute; encarada como um modo importante na matriz de transporte, encontramos exemplos de ampla rede de infra-estrutura. A Holanda tem mais de 16 mil quil&ocirc;metros de infra-estrutura ciclovi&aacute;ria, somente em estradas, e mais de 18 mil quil&ocirc;metros em suas cidades. Isto representa que um pa&iacute;s com um quinto do territ&oacute;rio do Estado de Santa Catarina, consegue ter quatorze vezes mais infra-estrutura neste campo do que o Brasil, com 8,5 milh&otilde;es de km². Este &eacute; um exemplo de um pa&iacute;s rico (16ª economia do mundo, com um PIB de US\$ 622 bilh&otilde;es) que, culturalmente, incorpora a bicicleta na matriz de transporte.<br />
<br />
<strong>2.15 - Desafios para Mudan&ccedil;a de Paradigma</strong><br />
<br />
J&aacute; foi mencionado que o incentivo &agrave; mobilidade por bicicleta pode trazer benef&iacute;cios para os usu&aacute;rios e para o meio ambiente urbano. Para tornar esta afirmativa uma pr&aacute;tica corrente &eacute; preciso enfrentar as dificuldades estruturais e buscar a mudan&ccedil;a de comportamento. A realidade presente hoje no meio urbano, por mais incongruente que possa parecer, &eacute; resultado da evolu&ccedil;&atilde;o da hist&oacute;ria, das a&ccedil;&otilde;es do passado e da cultura formada por todos os cidad&atilde;os.<br />
<br />
Alguns aspectos das cidades representam pontos de permanente conflito para a livre circula&ccedil;&atilde;o das bicicletas. Em verdade, constituem desafios a serem removidos ou contornados, para a forma&ccedil;&atilde;o de uma nova ordem na mobilidade urbana que inclua em larga escala os ciclistas.<br />
<br />
A seguir s&atilde;o detalhados alguns aspectos inibidores da inclus&atilde;o da bicicleta no cen&aacute;rio urbano.<br />
<br />
<strong>Crescimento desordenado</strong> - As cidades brasileiras sofreram nas &uacute;ltimas d&eacute;cadas um processo acelerado de urbaniza&ccedil;&atilde;o que n&atilde;o foi acompanhado de planejamento integrado entre as pol&iacute;ticas de desenvolvimento urbano, transportes e mobilidade, al&eacute;m da aus&ecirc;ncia do controle do uso e da ocupa&ccedil;&atilde;o do solo. Esta conjuntura resultou em segrega&ccedil;&atilde;o s&oacute;cio-espacial e em interven&ccedil;&otilde;es urbanas pontuais. Se por um lado elas n&atilde;o contribu&iacute;ram na promo&ccedil;&atilde;o de facilidades aos deslocamentos de todos os habitantes das cidades, de outro geraram muitas infra-estruturas, que logo foram apropriadas pelos ve&iacute;culos motorizados.<br />
<br />
<strong>Cultura do autom&oacute;vel</strong> - Historicamente, no Brasil, possuir um autom&oacute;vel &eacute; sin&ocirc;nimo de status. Seja porque ele proporciona conforto, ou representa poder aquisitivo. Por outro lado, a utiliza&ccedil;&atilde;o do autom&oacute;vel &eacute; um item indispens&aacute;vel para a classe m&eacute;dia reproduzir seu modo de vida.<br />
<br />
Infelizmente, as a&ccedil;&otilde;es pol&iacute;ticas realizadas ao longo de 30 anos pouco contribu&iacute;ram para aumentar a efici&ecirc;ncia dos transportes coletivos e diminuir as dist&acirc;ncias entre os equipamentos urbanos. Os investimentos em sistema vi&aacute;rio, na maioria das vezes, priorizaram a infra-estrutura para o autom&oacute;vel. No Brasil, de maneira geral, a cultura do planejador urbano ainda procura garantir a prioridade para o autom&oacute;vel e assim a id&eacute;ia do direito de ir e vir, muitas vezes, &eacute; utilizada para justificar o direito dos automobilistas, esquecendo-se de que o direito de ir e vir &eacute; da pessoa e n&atilde;o do ve&iacute;culo.<br />
<br />
Caso se queira realmente produzir mudan&ccedil;as, as autoridades p&uacute;blicas ter&atilde;o de come&ccedil;ar a devolver aos pedestres e aos ciclistas espa&ccedil;os urbanos apropriados pelos autom&oacute;veis. Em muitas cidades os espa&ccedil;os para novas vias e para a circula&ccedil;&atilde;o passaram a ser um bem escasso.<br />
<br />
Para obt&ecirc;-los, existem apenas dois caminhos:<br />
<br />
1) desapropriar espa&ccedil;os com pr&eacute;dios e casas; ou<br />
2) diminuir os espa&ccedil;os da circula&ccedil;&atilde;o dos autom&oacute;veis. Diante do elevado custo da primeira op&ccedil;&atilde;o, parece que a segunda delas dever&aacute; ser enfrentada com coragem.<br />
<br />
<strong>O desafio para a gest&atilde;o p&uacute;blica</strong> - Administrar interesses contr&aacute;rios e produzir mudan&ccedil;as no comportamento coletivo, consume tempo e exige paci&ecirc;ncia. &Eacute; preciso dedicar muito trabalho &agrave; cria&ccedil;&atilde;o de exemplos e projetos voltados ao convencimento. Diante desta tarefa &aacute;rdua, muitos dirigentes de &oacute;rg&atilde;os p&uacute;blicos que decidem sobre a transforma&ccedil;&atilde;o dos espa&ccedil;os urbanos, se omitem e preferem n&atilde;o alterar o quadro existente, caindo na solu&ccedil;&atilde;o paliativa de buscar maior fluidez para os autom&oacute;veis mediante obras vi&aacute;rias. Com o novo contexto da mobilidade urbana para a cidade sustent&aacute;vel, a SeMOB tem incentivado e oferecido aos munic&iacute;pios instrumentos para reverter esse quadro.<br />
<br />
No exterior e no Brasil, existem bons exemplos que contribuem para a mobilidade de pedestres e ciclistas. &Eacute; poss&iacute;vel promover mudan&ccedil;as, desde que haja vontade pol&iacute;tica, planejamento, distribui&ccedil;&atilde;o equitativa dos espa&ccedil;os de circula&ccedil;&atilde;o e educa&ccedil;&atilde;o para o tr&acirc;nsito. &Eacute; necess&aacute;rio restabelecer o equil&iacute;brio no uso dos espa&ccedil;os p&uacute;blicos, redemocratizando as oportunidades. &Eacute; preciso transformar em pr&aacute;tica efetiva o que apregoa o C&oacute;digo de Tr&acirc;nsito Brasileiro, concedendo prioridade aos modos coletivos e aos usu&aacute;rios mais fr&aacute;geis da via p&uacute;blica: pessoas com defici&ecirc;ncia, idosos, pedestres e ciclistas.<br />
<br />
Cabe ao poder p&uacute;blico conceder garantias para a seguran&ccedil;a desta parcelada da popula&ccedil;&atilde;o, provendo os espa&ccedil;os vi&aacute;rios de condi&ccedil;&otilde;es humanas ao tr&acirc;nsito de pedestres e ciclistas. Cada vez mais &eacute; urgente o rearranjo dos espa&ccedil;os e do sistema vi&aacute;rio, adaptando-o &agrave; uma nova mobilidade. E ela tem de ser muito mais humana, mais equilibrada, mais segura e mais de acordo com as exig&ecirc;ncias ambientais. A bicicleta, como ve&iacute;culo de transporte, est&aacute; perfeitamente apta para cumprir este papel. E isto somente ser&aacute; poss&iacute;vel, quando largos recursos forem disponibilizados para remodelar o espa&ccedil;o urbano, moldando-o &agrave;s condi&ccedil;&otilde;es exigidas pelos n&atilde;o motorizados.<br />
<br />
<strong>2.16 - Fatores que Influenciam a Mobilidade dos Ciclistas</strong><br />
<br />
Fatores abaixo referem-se &agrave;queles usu&aacute;rios que n&atilde;o fazem uso habitual da bicicleta. Poderiam ser enumerados maiores n&uacute;meros de aspectos capazes de influenciar um cidad&atilde;o a fazer ou n&atilde;o fazer uso da bicicleta como ve&iacute;culo de transporte. No entanto, selecionamos alguns julgados os mais importantes, sem deixar de entender que devem existir outros fatores psicol&oacute;gicos, f&iacute;sicos e at&eacute; emocionais capazes de inibir ou afastar os cidad&atilde;os de um uso mais regular desse tipo de ve&iacute;culo.<br />
<br />
<strong>Assim, os aspectos mais relevantes, seriam:</strong><br />
<br />
&bull; <strong>Qualidade f&iacute;sica da infra-estrutura</strong> - seja ela uma ciclovia, ciclofaixa, via cicl&aacute;vel ou outra.<br />
Inclui-se a&iacute; a largura e adequa&ccedil;&atilde;o do piso da via, a prote&ccedil;&atilde;o lateral, os dispositivos de<br />
redu&ccedil;&atilde;o de velocidade na aproxima&ccedil;&atilde;o de pontos perigosos, a sinaliza&ccedil;&atilde;o e a ilumina&ccedil;&atilde;o;<br />
<br />
&bull; <strong>Qualidade ambiental dos trajetos</strong> - incluindo basicamente o tratamento paisag&iacute;stico (canteiros, terraplenos, sombreamento e pontos de apoio) dos mesmos;<br />
<br />
&bull; <strong>Infra-estrutura cont&iacute;nua</strong> - especialmente a manuten&ccedil;&atilde;o de um n&iacute;vel homog&ecirc;neo de<br />
seguran&ccedil;a de tr&aacute;fego em todo o trajeto. Isto sem esquecer da import&acirc;ncia do tratamento das interse&ccedil;&otilde;es, onde a bicicleta deve ter espa&ccedil;os adequados e independentes para realizar as travessias necess&aacute;rias &agrave; continuidade de um trajeto;<br />
<br />
<strong>Facilidade para guardar a bicicleta</strong> - em outras palavras, dispor de estacionamentos seguros (biciclet&aacute;rios ou paraciclos) em v&aacute;rios pontos do espa&ccedil;o urbano. Em muitos deles seria essencial que houvesse controle de acesso e vigil&acirc;ncia permanente.<br />
<br />
<strong>Integra&ccedil;&atilde;o da bicicleta com outros modos</strong> - este &eacute; um item essencial para a amplia&ccedil;&atilde;o da mobilidade dos ciclistas. Para tanto, na integra&ccedil;&atilde;o deve existir espa&ccedil;o para a guarda em seguran&ccedil;a da bicicleta, equipamento de apoio, banheiros, bebedouros e outros elementos que gerem atratividade pelo uso desses espa&ccedil;os e perman&ecirc;ncia no uso do servi&ccedil;o de transporte p&uacute;blico.<br />
<br />
<strong>2.19 - Modalidades dos Usos da Bicicleta</strong><br />
<br />
Ainda que alguns aspectos tenham sido citados no item 2.15 do cap&iacute;tulo anterior &quot;Desafios para Mudan&ccedil;a de Paradigma&quot;, &eacute; importante refor&ccedil;ar algumas caracter&iacute;sticas dos diversos usos da bicicleta no meio urbano.<br />
<br />
Abstraindo-se dos usos como ve&iacute;culo de passeio para o lazer e esporte, a bicicleta, no meio urbano - como ve&iacute;culo de transporte de pessoas e mercadorias - apresenta os seguintes e principais usos:<br />
<br />
1. como ve&iacute;culo de transporte para deslocamentos em dire&ccedil;&atilde;o ao trabalho;<br />
2. como ve&iacute;culo de transporte para deslocamentos em dire&ccedil;&atilde;o ao estudo;<br />
3. para o transporte de mercadorias, na condi&ccedil;&atilde;o de empregado do com&eacute;rcio;<br />
4. como transporte para entrega de correspond&ecirc;ncia;<br />
5. como transporte eventual de produtos e compras, em especial botij&otilde;es de g&aacute;s, &aacute;gua mineral, etc.;<br />
6. como ve&iacute;culo propulsor de ba&uacute; ou caixa onde ocorre o transporte de mercadorias a serem vendidas no varejo;<br />
7. como ve&iacute;culo para transporte de pessoas al&eacute;m do condutor, na condi&ccedil;&atilde;o de passageiro comprador de servi&ccedil;o.<br />
<br />
A seguir, apresenta-se um breve detalhamento de cada uma das situa&ccedil;&otilde;es mencionadas anteriormente.<br />
<br />
<strong>Deslocamentos para o trabalho</strong> - constitui o principal uso da bicicleta em todo o territ&oacute;rio nacional, seja em &aacute;reas urbanas, como rurais. O uso da bicicleta para deslocamentos em dire&ccedil;&atilde;o ao trabalho &eacute; mais comum nas pequenas e m&eacute;dias cidades interioranas brasileiras, com destaque para as cidades com voca&ccedil;&atilde;o industrial na parte meridional do pa&iacute;s mas tamb&eacute;m no interior da Regi&atilde;o Nordeste.<br />
<br />
<strong>Deslocamentos para o estudo</strong> - constitui o segundo maior uso da bicicleta, tanto no Brasil, como em todo o mundo. O uso s&oacute; n&atilde;o &eacute; maior no Brasil, em todas as classes sociais, devido ao fator inibidor representado pela presen&ccedil;a agressiva dos ve&iacute;culos motorizados nas vias p&uacute;blicas, independente da sua hierarquia, gerando grande temor dos pais em deixar que as crian&ccedil;as se desloquem &agrave; escola de bicicleta.<br />
Mesmo assim ainda &eacute; grande o n&uacute;mero de crian&ccedil;as que se deslocam para a escola fazendo uso de uma bicicleta, em maior n&uacute;mero entre as classes sociais de menor renda. E isto ocorre tanto porque a viagem &eacute; relativamente curta (em geral as escolas se situam a menos de 2 km do local de moradia), como devido &agrave; sensa&ccedil;&atilde;o de liberdade que oferece aos estudantes que t&ecirc;m uma bicicleta.<br />
<br />
<strong>Uso no transporte de mercadorias</strong> - muitos empregados do com&eacute;rcio fazem uso da bicicleta para entrega de mercadorias aos consumidores. Podem ser destacadas as empresas que comercializam garraf&otilde;es de &aacute;gua mineral, algumas padarias, o pequeno com&eacute;rcio de venda de cocos nas cidades praianas que t&ecirc;m ciclovias &agrave; beira-mar, algumas farm&aacute;cias, etc.<br />
<br />
<strong>Uso no transporte de correspond&ecirc;ncia</strong> - diversos t&ecirc;m sido os usos da bicicleta pelo setor terci&aacute;rio, especialmente na entrega de documentos. Neste item, o destaque no Brasil fica com os Correios e Tel&eacute;grafos, com suas bicicletas-cargueiras e outras individuais utilizadas pelos carteiros.<br />
<br />
<strong>Uso no transporte eventual de produtos e compras pessoais</strong> - diversos t&ecirc;m sido os usos da bicicleta em todo o mundo. Nos pa&iacute;ses mais pobres bem como nas regi&otilde;es menos desenvolvidas e periferias urbanas dos grandes centros do Brasil a bicicleta, muitas vezes, opera como ve&iacute;culo de carga.<br />
<br />
<strong>Uso como ve&iacute;culo propulsor de ba&uacute;</strong> - s&atilde;o muitos e variados os tipos de arranjos criados pelos cidad&atilde;os da cidade e do campo para realizar, atrav&eacute;s da bicicleta, o transporte de produtos a serem vendidos em diversos locais.<br />
<br />
<strong>Uso como ve&iacute;culo de transporte de pessoas al&eacute;m do condutor</strong> - al&eacute;m das bici-t&aacute;xis citadas anteriormente, existem os conhecidos riquix&aacute;s do sudeste asi&aacute;tico e outros ve&iacute;culos mais inusitados em v&aacute;rias partes do mundo.<br />
A figura mostra um exemplo de bici-t&aacute;xis em Munique (Alemanha). Os modelos e a sofistica&ccedil;&atilde;o variam de cidade para cidade, mas o objetivo &eacute; o mesmo: prestar um servi&ccedil;o de transporte de forma agrad&aacute;vel a turistas e cidad&atilde;os com problemas de locomo&ccedil;&atilde;o.<br />
<br />
<strong>Por isso tudo, pode ser dito que a bicicleta &eacute; o mais vers&aacute;til dos transportes no planeta.</strong><br />
<br />
Na qualidade de ve&iacute;culo esportivo, apresenta o maior n&uacute;mero de varia&ccedil;&otilde;es em suas diversas modalidades, superando os demais ve&iacute;culos esportivos, chegando quase a rivalizar com os esportes com bola. Interessante registrar que a sua popularidade como esporte aumenta na propor&ccedil;&atilde;o do seu uso di&aacute;rio. Ou seja, quanto maior o seu uso nos deslocamentos di&aacute;rios das pessoas, maior o interesse pelos esportes onde a bicicleta est&aacute; presente.<br />
<br />
<strong>3.10 - Biciclet&aacute;rio</strong><br />
<br />
No Brasil, o problema &eacute; de ordem inversa, ou seja, a baixa demanda de bicicletas junto &agrave;s esta&ccedil;&otilde;es de transporte n&atilde;o se deve &agrave; inexist&ecirc;ncia de demanda, mas sim &agrave; inseguran&ccedil;a dos ciclistas quanto &agrave; guarda efetiva da bicicleta nos estabelecimentos particulares que se prop&otilde;e a ofertar esse servi&ccedil;o, pois nenhuma garantia &eacute; oferecida quanto ao roubo da bicicleta.<br />
<br />
Nesse sentido, a constru&ccedil;&atilde;o de biciclet&aacute;rios, mais do que imperativa, pode se constituir numa solu&ccedil;&atilde;o de desafogo para a municipalidade e na garantia de atendimento de uma demanda efetiva da popula&ccedil;&atilde;o de baixa renda com emprego fixo.<br />
<br />
<strong>&Aacute;reas para biciclet&aacute;rios em espa&ccedil;os p&uacute;blicos</strong><br />
<br />
As &aacute;reas dos biciclet&aacute;rios devem estar o mais pr&oacute;ximo poss&iacute;vel dos locais de destino dos ciclistas, (junto aos terminais de transportes urbanos, rodovi&aacute;rias, pra&ccedil;as de esporte, est&aacute;dios, gin&aacute;sios, liceus, ind&uacute;strias) e em pra&ccedil;as p&uacute;blicas, especialmente em munic&iacute;pios caracterizados como de porte m&eacute;dio. Nos munic&iacute;pios maiores ou nas &aacute;reas metropolitanas, sugere-se uma pol&iacute;tica de integra&ccedil;&atilde;o com os transportes, na franja dos bairros de periferia do munic&iacute;pio-sede com os seus sat&eacute;lites.<br />
<br />
<strong>4.4 - Casos Nacionais</strong><br />
<br />
<strong>e) O Caso de Curitiba</strong><br />
<br />
Curitiba &eacute; conhecida mundialmente como tendo excel&ecirc;ncia em seu sistema de transporte urbano por &ocirc;nibus. O modelo constru&iacute;do tem sido implantado em outros pa&iacute;ses, sendo Bogot&aacute; um dos que mais incorporou a experi&ecirc;ncia da capital paranaense. Um desses modelos, sem d&uacute;vida, &eacute; a qualidade dos dispositivos voltados &agrave; integra&ccedil;&atilde;o de bicicletas e &ocirc;nibus.<br />
<br />
<strong>Em Curitiba, a import&acirc;ncia de prever espa&ccedil;os para a circula&ccedil;&atilde;o de bicicletas se torna bem evidente</strong>. Isto ocorre em raz&atilde;o dos ciclistas usarem as canaletas dos &ocirc;nibus em seus deslocamentos habituais, produzindo conflitos com os operadores do sistema de &ocirc;nibus expresso.<br />
<br />
O fato de o paraciclo estar situado pr&oacute;ximo da entrada do terminal consegue remediar parcialmente o receio dos usu&aacute;rios do sistema de transportes em fazer uso da integra&ccedil;&atilde;o de bicicleta e &ocirc;nibus.<br />
<br />
Vale lembrar o que foi mencionado no cap&iacute;tulo anterior sobre acessibilidade. Em todos esses casos, deve ser observada a acessibilidade para as pessoas com defici&ecirc;ncia e restri&ccedil;&atilde;o de mobilidade, tratando os revestimentos com cores contrastantes e pisos especiais de alerta.</p>

            
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
			<a name="3"><h1>GLOSS&Aacute;RIO:</h1></a>
            <p>
            <strong>BICICLET&Aacute;RIO</strong> - estacionamentos de longa dura&ccedil;&atilde;o, grande n&uacute;mero de vagas e controle de acesso, podendo ser p&uacute;blicos ou privados<br />
            <br />
            <strong>CICLOFAIXA</strong> - parte cont&iacute;gua a pista de rolamento destinada &agrave; circula&ccedil;&atilde;o exclusiva de ciclos, sendo dela separada por pintura e/ou elementos delimitadores.<br />
            <br />
            <strong>CICLOVIA</strong> - pista pr&oacute;pria destinada &agrave; circula&ccedil;&atilde;o de ciclos, separada fisicamente do tr&aacute;fego comum por desn&iacute;vel ou elementos delimitadores.<br />
            <br />
            <strong>DESENVOLVIMENTO SUSTENT&Aacute;VEL</strong> - &eacute;, segundo a Comiss&atilde;o Mundial sobre Meio Ambiente e Desenvolvimento (CMMAD) da Organiza&ccedil;&atilde;o das Na&ccedil;&otilde;es Unidas, aquele que atende &agrave;s necessidades presentes sem comprometer a possibilidade de as gera&ccedil;&otilde;es futuras satisfazerem as suas pr&oacute;prias necessidades. Ele cont&eacute;m dois conceitos-chave: 1- o conceito de &quot;necessidades&quot;, sobretudo as necessidades essenciais dos pobres no mundo, que devem receber a m&aacute;xima prioridade; 2- a no&ccedil;&atilde;o das limita&ccedil;&otilde;es que o est&aacute;gio da tecnologia e da organiza&ccedil;&atilde;o social imp&otilde;e ao meio ambiente, impedindo-o de atender &agrave;s necessidades presentes e futuras (...).Em 1987, a CMMAD, presidida pela ex-primeira-ministra da Noruega, Gro Harlem Brundtland, adotou o conceito de Desenvolvimento Sustent&aacute;vel em seu relat&oacute;rio Our Common Future (Nosso futuro comum), tamb&eacute;m conhecido como Relat&oacute;rio Brundtland. Segundo ela, o desenvolvimento sustent&aacute;vel &quot;satisfaz as necessidades presentes, sem comprometer a capacidade das gera&ccedil;&otilde;es futuras de suprir suas pr&oacute;prias necessidades&quot;. Ou seja, &eacute; o desenvolvimento econ&ocirc;mico, social, cient&iacute;fico e cultural das sociedades garantindo mais sa&uacute;de, conforto e conhecimento, sem exaurir os recursos naturais do planeta. Segundo o Relat&oacute;rio Brundtland, uma s&eacute;rie de medidas devem ser tomadas pelos Estados nacionais: a) limita&ccedil;&atilde;o do crescimento populacional; b) garantia de alimenta&ccedil;&atilde;o a longo prazo; c) preserva&ccedil;&atilde;o da biodiversidade e dos ecossistemas; d) diminui&ccedil;&atilde;o do consumo de energia e desenvolvimento de tecnologias que admitem o uso de fontes energ&eacute;ticas renov&aacute;veis; e) aumento da produ&ccedil;&atilde;o industrial nos pa&iacute;ses n&atilde;o-industrializados &agrave; base de tecnologias ecologicamente adaptadas; f) controle da urbaniza&ccedil;&atilde;o selvagem e integra&ccedil;&atilde;o entre campo e cidades menores; g) as necessidades b&aacute;sicas devem ser satisfeitas. No n&iacute;vel internacional, as metas propostas pelo Relat&oacute;rio s&atilde;o as seguintes: h) as organiza&ccedil;&otilde;es do desenvolvimento devem adotar a estrat&eacute;gia de desenvolvimento sustent&aacute;vel; i) a comunidade internacional deve proteger os ecossistemas supranacionais como a Ant&aacute;rtica, os oceanos, o espa&ccedil;o; j) guerras devem ser banidas; k) a ONU deve implantar um programa de desenvolvimento sustent&aacute;vel.<br />
            <br />
            <strong>ESPAÃ‡O CICLOVI&Aacute;RIO</strong> - &eacute; a estrutura&ccedil;&atilde;o favor&aacute;vel &agrave; utiliza&ccedil;&atilde;o da bicicleta em uma determinada &aacute;rea do territ&oacute;rio, seja ela um estado, munic&iacute;pio ou uma cidade, podendo ser identificadas tr&ecirc;s alternativas: sistema ciclovi&aacute;rio compartilhado, sistema ciclovi&aacute;rio preferencial e sistema ciclovi&aacute;rio de uso misto.<br />
            <br />
            <strong>MOBILIDADE URBANA</strong> - um atributo das cidades e se refere &agrave; facilidade de deslocamentos de pessoas e bens no espa&ccedil;o urbano. Tais deslocamentos s&atilde;o feitos atrav&eacute;s de ve&iacute;culos, vias e toda a infra-estrutura (vias, cal&ccedil;adas, etc.) que possibilitam esse ir e vir cotidiano. (...) &Eacute; o resultado da intera&ccedil;&atilde;o entre os deslocamentos de pessoas e bens com a cidade. (...) (Anteprojeto de lei da pol&iacute;tica nacional de mobilidade urbana, Minist&eacute;rio das Cidades, 2. ed, 2005).<br />
            <br />
            <strong>MOBILIDADE URBANA SUSTENT&Aacute;VEL</strong><br />
            <br />
&bull; Mobilidade urbana sustent&aacute;vel deve ser entendida como a reuni&atilde;o das pol&iacute;ticas de transporte e circula&ccedil;&atilde;o, integradas com a pol&iacute;tica de desenvolvimento urbano, com a finalidade de proporcionar o acesso amplo e democr&aacute;tico ao espa&ccedil;o urbano, priorizando os modos de transporte coletivo e os n&atilde;o-motorizados, de forma segura, socialmente inclusiva e sustent&aacute;vel. A sustentabilidade aponta para a condi&ccedil;&atilde;o de manuten&ccedil;&atilde;o dos setores da mobilidade operando e melhorando no longo prazo, constituindo-se em uma extens&atilde;o do conceito utilizado na &aacute;rea ambiental. (Revista dos Transportes P&uacute;blicos - ANTP, ano 25, 3o trimestre 2003, p. 65).<br />
<br />
&bull; A mobilidade urbana sustent&aacute;vel pode ser definida como o resultado de um conjunto de pol&iacute;ticas de transporte e circula&ccedil;&atilde;o que visam proporcionar o acesso amplo e democr&aacute;tico ao espa&ccedil;o urbano, atrav&eacute;s da prioriza&ccedil;&atilde;o dos modos n&atilde;o motorizados e coletivos de transportes, de forma efetiva, socialmente inclusiva e ecologicamente sustent&aacute;vel, baseado nas pessoas e n&atilde;o nos ve&iacute;culos. (BOARETO, Renato, Revista dos Transportes P&uacute;blicos - ANTP, ano 25, 3o trimestre, 2003, p. 49).<br />
<br />
<strong>PARACICLO</strong> - estacionamento para bicicletas em espa&ccedil;os p&uacute;blicos, equipado com dispositivos capazes de manter os ve&iacute;culos de forma ordenada, com possibilidade de amarra&ccedil;&atilde;o para garantia m&iacute;nima de seguran&ccedil;a contra o furto. Por serem estacionamento de curta ou m&eacute;dia dura&ccedil;&atilde;o, ter pequeno porte, n&uacute;mero reduzido de vagas, sem controle de acesso e simplicidade do projeto, difere substancialmente do biciclet&aacute;rio.<br />
<br />
<strong>SISTEMA CICLOVI&Aacute;RIO COMPARTILHADO</strong> - a rede pode se constituir de vias adaptadas ou n&atilde;o &agrave; circula&ccedil;&atilde;o da bicicleta. Neste caso, os ciclistas circulam em ruas e outras vias com baixo tr&aacute;fego motorizado e n&iacute;vel de seguran&ccedil;a elevado, caracterizadas no seu conjunto como rotas cicl&aacute;veis ou cicloredes.<br />
<br />
<strong>SISTEMA CICLOVI&Aacute;RIO PREFERENCIAL</strong> - espa&ccedil;os destinados ao uso exclusivo ou com prioridade &agrave; bicicleta, como ciclovias e ciclofaixas.<br />
<br />
<strong>SISTEMA CICLOVI&Aacute;RIO DE USO MISTO</strong> - quando a rede apresenta trechos e rotas compartilhadas entre bicicletas e o tr&aacute;fego motorizado, al&eacute;m das infra-estruturas espec&iacute;ficas &agrave; circula&ccedil;&atilde;o da bicicleta.<br />
<br />
<strong>SUSTENTABILIDADE</strong><br />
<br />
&bull; A sustentabilidade, para a mobilidade urbana, &eacute; uma extens&atilde;o do conceito utilizado na &aacute;rea ambiental, dada pela &quot;capacidade de fazer as viagens necess&aacute;rias para a realiza&ccedil;&atilde;o de seus direitos b&aacute;sicos de cidad&atilde;o, com o menor gasto de energia poss&iacute;vel e menor impacto no meio ambiente, tornando-a ecologicamente sustent&aacute;vel.&quot; (BOARETO, 2003)<br /></p>

<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>

	  <a name="4"><h1>Plano Diretor de Curitiba</h1></a>
        <br />
        <p align="center">JUSTIFICATIVA E FUNDAMENTA&Ccedil;&Atilde;O<strong><br />
          PRESENTES NA LEGISLA&Ccedil;&Atilde;O MUNICIPAL<br />
          PLANO DIRETOR DE CURITIBA</strong></p>
        <br /><p>
LEI ORDIN&Aacute;RIA N&ordm; 11.266 de 16 de dezembro de 2004<br />
<br />
&quot;Disp&otilde;e sobre a adequa&ccedil;&atilde;o do Plano Diretor de Curitiba ao Estatuto da Cidade - Lei Federal n&ordm; 10.257/01, para orienta&ccedil;&atilde;o e controle do desenvolvimento integrado do Munic&iacute;pio.&quot;<br />
<br />
T&Iacute;TULO I<br />
DA ADEQUA&Ccedil;&Atilde;O DO PLANO DIRETOR DE CURITIBA<br />
<br />
Art. 3&ordm;. O Plano Diretor de Curitiba visa propiciar melhores condi&ccedil;&otilde;es para o desenvolvimento integrado e harm&ocirc;nico e o <strong>bem-estar social da comunidade de Curitiba</strong>, bem como da Regi&atilde;o Metropolitana, e &eacute; o instrumento b&aacute;sico, global e estrat&eacute;gico da pol&iacute;tica de desenvolvimento urbano do Munic&iacute;pio, determinante para todos os agentes, p&uacute;blicos e privados, que atuam na cidade.<br />
<br />
&sect; 3&ordm;. Al&eacute;m do Plano Diretor de Curitiba, no processo de planejamento municipal ser&atilde;o utilizados, entre outros instrumentos:<br />
<br />
I - de planejamento municipal, em especial:<br />
<br />
a) disciplina do parcelamento, do uso e da ocupa&ccedil;&atilde;o do solo;<br />
b) zoneamento ambiental;<br />
c) plano plurianual;<br />
d) diretrizes or&ccedil;ament&aacute;rias e or&ccedil;amento anual;<br />
e) gest&atilde;o or&ccedil;ament&aacute;ria participativa;<br />
<strong>f) plano de mobilidade e de transporte urbano integrado;</strong><br />
g) plano de habita&ccedil;&atilde;o;<br />
h) planos de desenvolvimento econ&ocirc;mico e social;<br />
i) planos, programas e projetos setoriais.<br />
<br />
Art. 4&ordm;. O Plano Diretor de Curitiba abrange a totalidade do territ&oacute;rio do Munic&iacute;pio, completamente urbano, estabelecendo diretrizes para:<br />
<br />
<strong>I - a pol&iacute;tica de desenvolvimento urbano do munic&iacute;pio;</strong><br />
<strong>II - a pol&iacute;tica urban&iacute;stico-ambiental;</strong><br />
<strong>III - a pol&iacute;tica social e econ&ocirc;mica;</strong><br />
<strong>IV - a gest&atilde;o democr&aacute;tica.</strong><br />
<br />
T&Iacute;TULO II<br />
<strong>DA POL&Iacute;TICA DE DESENVOLVIMENTO URBANO</strong><br />
<br />
Art. 6&ordm;. A pol&iacute;tica de desenvolvimento urbano da Cidade de Curitiba dever&aacute;<br />
conduzir ao pleno desenvolvimento das fun&ccedil;&otilde;es sociais da cidade e da propriedade urbana mediante os seguintes objetivos gerais:<br />
<br />
<strong>I - gest&atilde;o democr&aacute;tica, participativa e descentralizada;</strong><br />
<strong>II - promo&ccedil;&atilde;o da qualidade de vida e do ambiente</strong>, reduzindo as desigualdades e a exclus&atilde;o social;<br />
III - inclus&atilde;o social, compreendida pela oportunidade de acesso a bens, servi&ccedil;os e pol&iacute;ticas sociais, trabalho e renda a todos os mun&iacute;cipes;<br />
IV - integra&ccedil;&atilde;o e complementaridade das a&ccedil;&otilde;es p&uacute;blicas e privadas, locais e regionais atrav&eacute;s de programas e projetos de atua&ccedil;&atilde;o;<br />
V - promo&ccedil;&atilde;o social, econ&ocirc;mica e cultural da cidade pela diversifica&ccedil;&atilde;o, atratividade e competitividade das atividades;<br />
VI - fortalecimento do setor p&uacute;blico, recupera&ccedil;&atilde;o e valoriza&ccedil;&atilde;o das fun&ccedil;&otilde;es de planejamento, articula&ccedil;&atilde;o e controle;<br />
VII - articula&ccedil;&atilde;o das estrat&eacute;gias de desenvolvimento da cidade no contexto<br />
regional metropolitano;<br />
VIII - regula&ccedil;&atilde;o p&uacute;blica sobre o solo urbano mediante a utiliza&ccedil;&atilde;o de instrumentos redistributivos da renda urbana e da terra e controle sobre o uso e ocupa&ccedil;&atilde;o do espa&ccedil;o da Cidade;<br />
IX - integra&ccedil;&atilde;o horizontal entre os &oacute;rg&atilde;os e conselhos municipais, promovendo a atua&ccedil;&atilde;o coordenada no desenvolvimento e aplica&ccedil;&atilde;o das estrat&eacute;gias e metas de planos, programas e projetos;<br />
X - universaliza&ccedil;&atilde;o da mobilidade e acessibilidade;<br />
<strong>XI - prioridade ao transporte coletivo p&uacute;blico na mobilidade urbana;</strong><br />
XII - preserva&ccedil;&atilde;o e recupera&ccedil;&atilde;o do ambiente natural e cultural;<br />
XIII - promo&ccedil;&atilde;o de estrat&eacute;gias de financiamento que possibilitem o cumprimento dos planos, programas e projetos em condi&ccedil;&otilde;es de m&aacute;xima efici&ecirc;ncia;<br />
<strong>XIV - participa&ccedil;&atilde;o da popula&ccedil;&atilde;o nos processos de decis&atilde;o, planejamento e gest&atilde;o.</strong><br />
XV - privilegiar os gastos p&uacute;blicos nas &aacute;reas que melhor proporcionem a melhoria<br />
da qualidade de vida a todos os cidad&atilde;os;<br />
XVI - recuperar os investimentos feitos pelo poder p&uacute;blico municipal na realiza&ccedil;&atilde;o de infra-estrutura p&uacute;blica que proporcione a valoriza&ccedil;&atilde;o de im&oacute;veis urbanos.<br />
<br />
Art. 7&ordm;. Complementarmente &agrave;quelas estabelecidas no Estatuto da Cidade, tamb&eacute;m s&atilde;o <strong>diretrizes gerais da pol&iacute;tica urbana de Curitiba</strong>:<br />
<br />
I - consolidar o Munic&iacute;pio de Curitiba como centro regional integrado de desenvolvimento sustent&aacute;vel nos setores industrial e de servi&ccedil;os e como p&oacute;lo competitivo de inova&ccedil;&atilde;o tecnol&oacute;gica, sede de atividades produtivas e geradoras de emprego e renda;<br />
II - aumentar a efici&ecirc;ncia econ&ocirc;mica da Cidade, de forma a ampliar os benef&iacute;cios sociais e reduzir os custos operacionais para os setores p&uacute;blico e privado, inclusive por meio do aperfei&ccedil;oamento t&eacute;cnico-administrativo do setor p&uacute;blico;<br />
<strong>III - promover o desenvolvimento sustent&aacute;vel</strong>, a justa distribui&ccedil;&atilde;o das riquezas e a eq&uuml;idade social no Munic&iacute;pio;<br />
<strong>IV - elevar a qualidade de vida do cidad&atilde;o</strong>, promovendo a inclus&atilde;o social e reduzindo as desigualdades que atingem diferentes camadas da popula&ccedil;&atilde;o e &aacute;reas do Munic&iacute;pio, <strong>particularmente no que se refere &agrave; sa&uacute;de, educa&ccedil;&atilde;o, cultura</strong>, condi&ccedil;&otilde;es habitacionais, &agrave; <strong>oferta de infra-estrutura</strong> e servi&ccedil;os p&uacute;blicos &agrave; gera&ccedil;&atilde;o de oportunidades de acesso a trabalho e &agrave; renda;<br />
<strong>V - elevar a qualidade do ambiente urbano, por meio da preserva&ccedil;&atilde;o dos recursos naturais e da prote&ccedil;&atilde;o do patrim&ocirc;nio hist&oacute;rico, art&iacute;stico, cultural, urban&iacute;stico, arqueol&oacute;gico e paisag&iacute;stico;</strong><br />
VI - propiciar padr&otilde;es adequados de qualidade do ar, da &aacute;gua, do solo, de uso dos espa&ccedil;os abertos e verdes, <strong>de circula&ccedil;&atilde;o</strong> e habita&ccedil;&atilde;o em &aacute;reas livres de res&iacute;duos, de polui&ccedil;&atilde;o visual e sonora;<br />
VII - orientar a distribui&ccedil;&atilde;o espacial da popula&ccedil;&atilde;o, atividades econ&ocirc;micas, equipamentos e servi&ccedil;os p&uacute;blicos no territ&oacute;rio do Munic&iacute;pio, conforme as diretrizes de crescimento, voca&ccedil;&atilde;o, infra-estrutura, recursos naturais e culturais;<br />
<strong>VIII - otimizar o uso das infra-estruturas instaladas, em particular as do sistema vi&aacute;rio e de transportes;</strong><br />
IX - democratizar o acesso &agrave; terra e &agrave; habita&ccedil;&atilde;o, estimulando os mercados acess&iacute;veis &agrave;s faixas de menor renda;<br />
X - evitar o uso especulativo da terra como reserva de valor, de modo a assegurar o cumprimento da fun&ccedil;&atilde;o social da propriedade;<br />
XI - promover a integra&ccedil;&atilde;o e a coopera&ccedil;&atilde;o com os governos federal, estadual e com os munic&iacute;pios da Regi&atilde;o Metropolitana de Curitiba, no processo de planejamento e gest&atilde;o das fun&ccedil;&otilde;es p&uacute;blicas de interesse comum;<br />
XII - incentivar a participa&ccedil;&atilde;o da iniciativa privada e demais setores da sociedade em a&ccedil;&otilde;es relativas ao processo de urbaniza&ccedil;&atilde;o, mediante o uso de instrumentos urban&iacute;sticos diversificados, quando for de interesse p&uacute;blico e compat&iacute;veis com as fun&ccedil;&otilde;es sociais da Cidade;<br />
XIII - descentralizar a gest&atilde;o e o planejamento p&uacute;blicos, conforme previsto na Lei Org&acirc;nica, mediante a consolida&ccedil;&atilde;o das Administra&ccedil;&otilde;es Regionais e inst&acirc;ncias de Org&acirc;nica, mediante a consolida&ccedil;&atilde;o das Administra&ccedil;&otilde;es Regionais e inst&acirc;ncias de participa&ccedil;&atilde;o local;<br />
<strong>XIV - priorizar o bem estar coletivo em rela&ccedil;&atilde;o ao individual.</strong><br />
<br />
<strong>CAP&Iacute;TULO II<br />
DA MOBILIDADE URBANA E TRANSPORTE</strong><br />
<br />
<strong>Art. 15. A pol&iacute;tica municipal de mobilidade urbana e transporte, t&ecirc;m o compromisso de facilitar os deslocamentos e a circula&ccedil;&atilde;o de pessoas e bens no Munic&iacute;pio, com as seguintes diretrizes gerais:</strong><br />
<strong>I - priorizar no espa&ccedil;o vi&aacute;rio o transporte coletivo em rela&ccedil;&atilde;o ao transporte individual;</strong><br />
II - melhorar e ampliar a integra&ccedil;&atilde;o do transporte p&uacute;blico coletivo em Curitiba e buscar a consolida&ccedil;&atilde;o da integra&ccedil;&atilde;o metropolitana;<br />
<strong>III - priorizar a prote&ccedil;&atilde;o individual dos cidad&atilde;os e do meio ambiente no aperfei&ccedil;oamento da mobilidade urbana, circula&ccedil;&atilde;o vi&aacute;ria e dos transportes;</strong><br />
<strong>IV - promover a acessibilidade, facilitando o deslocamento no Munic&iacute;pio, atrav&eacute;s de uma rede integrada de vias, ciclovias e ruas exclusivas de pedestres, com seguran&ccedil;a, autonomia e conforto, especialmente aos que t&ecirc;m dificuldade de locomo&ccedil;&atilde;o;</strong><br />
<strong>V - buscar a excel&ecirc;ncia na mobilidade urbana</strong> e o acesso ao transporte no atendimento aos que t&ecirc;m dificuldade de locomo&ccedil;&atilde;o;<br />
<strong>VI - equacionar o abastecimento e a distribui&ccedil;&atilde;o de bens dentro do Munic&iacute;pio de modo a reduzir seus impactos sobre a circula&ccedil;&atilde;o vi&aacute;ria e o meio ambiente;</strong><br />
<strong>VII - compatibilizar o planejamento e a gest&atilde;o da mobilidade urbana para promover a melhoria da qualidade do meio ambiente;</strong><br />
<strong>VIII - promover a prote&ccedil;&atilde;o aos cidad&atilde;os nos seus deslocamentos atrav&eacute;s de a&ccedil;&otilde;es integradas, com &ecirc;nfase na educa&ccedil;&atilde;o;</strong><br />
<strong>IX - estimular a ado&ccedil;&atilde;o de novas tecnologias que visem a redu&ccedil;&atilde;o de poluentes, res&iacute;duos ou suspens&atilde;o e de polui&ccedil;&atilde;o sonora, priorizando a ado&ccedil;&atilde;o de combust&iacute;veis renov&aacute;veis;</strong><br />
X - promover o controle, monitoramento e fiscaliza&ccedil;&atilde;o, diretamente ou em conjunto com &oacute;rg&atilde;os da esfera estadual ou federal, da circula&ccedil;&atilde;o de cargas perigosas e dos &iacute;ndices de polui&ccedil;&atilde;o atmosf&eacute;rica e sonora nas vias do Munic&iacute;pio;<br />
XI - instituir o Plano Municipal de Mobilidade e Transporte Urbano Integrado.<br />
<br />
Par&aacute;grafo &uacute;nico. As diretrizes gerais da pol&iacute;tica municipal de mobilidade urbana e transporte s&atilde;o voltadas para o conjunto da popula&ccedil;&atilde;o do Munic&iacute;pio, com diretrizes espec&iacute;ficas para os seus principais componentes.<br />
<br />
<strong>SE&Ccedil;&Atilde;O II<br />
DOS SISTEMAS VI&Aacute;RIO, DE CIRCULA&Ccedil;&Atilde;O E TRÃ‚NSITO</strong><br />
<br />
<strong>Art. 17. S&atilde;o diretrizes espec&iacute;ficas da pol&iacute;tica municipal dos sistemas vi&aacute;rio, de circula&ccedil;&atilde;o e tr&acirc;nsito:</strong><br />
<br />
<strong>I - planejar, executar e manter o sistema vi&aacute;rio segundo crit&eacute;rios de seguran&ccedil;a e conforto da popula&ccedil;&atilde;o, respeitando o meio ambiente, obedecidas as diretrizes de uso e ocupa&ccedil;&atilde;o do solo e do transporte de passageiros;</strong><br />
II - promover a continuidade ao sistema vi&aacute;rio por meio de diretrizes de arruamento a serem implantadas e integradas ao sistema vi&aacute;rio oficial, especialmente nas &aacute;reas de urbaniza&ccedil;&atilde;o incompleta;<br />
<strong>III - promover tratamento urban&iacute;stico adequado nas vias e corredores da rede de transportes, de modo a proporcionar a seguran&ccedil;a dos cidad&atilde;os e a preserva&ccedil;&atilde;o do patrim&ocirc;nio hist&oacute;rico, ambiental, cultural, paisag&iacute;stico, urban&iacute;stico e arquitet&ocirc;nico da Cidade;</strong><br />
IV - melhorar a qualidade do tr&aacute;fego e da mobilidade, com &ecirc;nfase na engenharia, educa&ccedil;&atilde;o, opera&ccedil;&atilde;o, fiscaliza&ccedil;&atilde;o e policiamento;<br />
V - planejar e operar a rede vi&aacute;ria municipal, priorizando o transporte p&uacute;blico de passageiros, em conson&acirc;ncia com o Plano Municipal de Mobilidade Urbana e Transporte Integrado;<br />
VI - aperfei&ccedil;oar e ampliar o sistema de circula&ccedil;&atilde;o de pedestres e de pessoas portadoras de defici&ecirc;ncia, propiciando conforto, seguran&ccedil;a e facilidade nos deslocamentos;<br />
<strong>VII - desenvolver um programa ciclovi&aacute;rio, buscando a integra&ccedil;&atilde;o metropolitana, e incentivando sua utiliza&ccedil;&atilde;o com campanhas educativas;</strong><br />
VIII - implantar estruturas para controle da frota circulante e do comportamento dos usu&aacute;rios.<br />
<br />
CAP&Iacute;TULO III<br />
DO PATRIMÃ”NIO AMBIENTAL E CULTURAL<br />
<br />
Art. 19. A pol&iacute;tica municipal do meio ambiente tem como objetivo promover a conserva&ccedil;&atilde;o, prote&ccedil;&atilde;o, recupera&ccedil;&atilde;o e o <strong>uso racional do meio ambiente</strong>, em seus aspectos natural e cultural, estabelecendo normas, incentivos e restri&ccedil;&otilde;es ao seu uso e ocupa&ccedil;&atilde;o, visando a <strong>preserva&ccedil;&atilde;o ambiental e a sustentabilidade da Cidade, para as presentes e futuras gera&ccedil;&otilde;es</strong>.<br />
<br />
Par&aacute;grafo &uacute;nico. Constituem os aspectos natural e cultural do meio ambiente, o conjunto de bens existentes no Munic&iacute;pio de Curitiba, de dom&iacute;nio p&uacute;blico ou privado, cuja prote&ccedil;&atilde;o ou preserva&ccedil;&atilde;o seja de interesse p&uacute;blico, quer por sua vincula&ccedil;&atilde;o hist&oacute;rica, quer por seu valor natural, cultural, urbano, paisag&iacute;stico, arquitet&ocirc;nico, arqueol&oacute;gico, art&iacute;stico, etnogr&aacute;fico e gen&eacute;tico, entre outros.<br />
<br />
<strong>Art. 20. S&atilde;o diretrizes gerais da pol&iacute;tica municipal do meio ambiente:</strong><br />
<br />
<strong>I - promover a sustentabilidade ambiental planejando e desenvolvendo estudos e a&ccedil;&otilde;es visando incentivar, proteger, conservar, preservar, restaurar, recuperar e manter a qualidade ambiental urbana e cultural;</strong><br />
II - elaborar e implementar planos, programas e a&ccedil;&otilde;es de prote&ccedil;&atilde;o e educa&ccedil;&atilde;o ambiental e cultural visando garantir a gest&atilde;o compartilhada;<br />
III - assegurar que o lan&ccedil;amento na natureza, de qualquer forma de mat&eacute;ria ou energia, n&atilde;o produza riscos &agrave; natureza ou a sa&uacute;de p&uacute;blica e que as atividades potencialmente poluidoras ou que utilizem recursos naturais, tenham sua implanta&ccedil;&atilde;o e opera&ccedil;&atilde;o controlada;<br />
IV - definir de forma integrada, &aacute;reas priorit&aacute;rias de a&ccedil;&atilde;o governamental visando &agrave; prote&ccedil;&atilde;o, preserva&ccedil;&atilde;o e recupera&ccedil;&atilde;o da qualidade ambiental e do equil&iacute;brio ecol&oacute;gico;<br />
V - identificar e criar unidades de conserva&ccedil;&atilde;o e outras &aacute;reas de interesse para a prote&ccedil;&atilde;o de mananciais, ecossistemas naturais, flora e fauna, recursos gen&eacute;ticos e outros bens naturais e culturais, estabelecendo normas a serem observadas nessas &aacute;reas;<br />
VI - estabelecer normas espec&iacute;ficas para a prote&ccedil;&atilde;o de recursos h&iacute;dricos, por meio de planos de uso e ocupa&ccedil;&atilde;o de &aacute;reas de manancial e bacias hidrogr&aacute;ficas;<br />
VII - promover ado&ccedil;&atilde;o de padr&otilde;es de produ&ccedil;&atilde;o e consumo de bens e servi&ccedil;os compat&iacute;veis com os limites de sustentabilidade ambiental;<br />
VIII - promover o saneamento ambiental, por meios pr&oacute;prios ou de terceiros, com a oferta de servi&ccedil;os p&uacute;blicos adequados aos interesses e necessidades da popula&ccedil;&atilde;o e &agrave;s caracter&iacute;sticas locais;<br />
IX - promover a preserva&ccedil;&atilde;o do patrim&ocirc;nio cultural edificado e dos s&iacute;tios hist&oacute;ricos, mantendo suas caracter&iacute;sticas originais e sua ambi&ecirc;ncia na paisagem urbana, por meio de tombamento ou outros instrumentos, e orientar e incentivar o seu uso adequado;<br />
X - estabelecer o zoneamento ambiental para o Munic&iacute;pio de Curitiba, de forma &uacute;nica ou segmentada;<br />
XI - identificar e definir os bens de valor ambiental e cultural, de natureza material e imaterial, de interesse de conserva&ccedil;&atilde;o e preserva&ccedil;&atilde;o, integrantes do Patrim&ocirc;nio Ambiental e Cultural do Munic&iacute;pio de Curitiba;<br />
XII - estabelecer normas, padr&otilde;es, restri&ccedil;&otilde;es e incentivos ao uso e ocupa&ccedil;&atilde;o dos im&oacute;veis, p&uacute;blicos e privados, considerando os aspectos do meio ambiente natural, cultural e edificado, compat&iacute;veis com os limites da sustentabilidade ambiental;<br />
XIII - orientar e incentivar o uso adequado do patrim&ocirc;nio, dos s&iacute;tios hist&oacute;ricos e da paisagem urbana;<br />
XIV - estabelecer incentivos construtivos e fiscais visando &agrave; preserva&ccedil;&atilde;o, conserva&ccedil;&atilde;o e recupera&ccedil;&atilde;o do patrim&ocirc;nio cultural e ambiental;<br />
XV - reduzir anualmente, a emiss&atilde;o de poluentes nocivos &agrave; sa&uacute;de despejados no ar, no solo e nas &aacute;guas, segundo o Plano Municipal de Controle Ambiental e Desenvolvimento Sustent&aacute;vel, observados os protocolos internacionais relativos &agrave; mat&eacute;ria firmados pelo Brasil.<br />
<br />
CAP&Iacute;TULO IV<br />
DA PAISAGEM URBANA E DO USO DO ESPAÃ‡O PÃšBLICO<br />
<br />
SE&Ccedil;&Atilde;O I<br />
DA PAISAGEM URBANA<br />
<br />
Art. 21. A paisagem urbana, entendida como a configura&ccedil;&atilde;o visual da cidade e seus componentes, resultante da intera&ccedil;&atilde;o entre os elementos naturais, edificados, hist&oacute;ricos e culturais, ter&aacute; a sua pol&iacute;tica municipal definida com seguintes objetivos:<br />
<br />
I - proporcionar ao cidad&atilde;o o direito de usufruir a paisagem;<br />
<strong>II - promover a qualidade ambiental do espa&ccedil;o p&uacute;blico;</strong><br />
III - possibilitar ao cidad&atilde;o a identifica&ccedil;&atilde;o, leitura e compreens&atilde;o da paisagem e de seus elementos constitutivos, p&uacute;blicos e privados;<br />
<strong>IV - assegurar o equil&iacute;brio visual entre os diversos elementos que comp&otilde;em a paisagem urbana;</strong><br />
<strong>V - ordenar e qualificar o uso do espa&ccedil;o p&uacute;blico;</strong><br />
VI - fortalecer uma identidade urbana, promovendo a preserva&ccedil;&atilde;o do patrim&ocirc;nio cultural e ambiental urbano.<br />
<br />
Art. 22. S&atilde;o diretrizes gerais da pol&iacute;tica de paisagem urbana:<br />
I - implementar os instrumentos t&eacute;cnicos, institucionais e legais de gest&atilde;o da paisagem urbana;<br />
II - promover o ordenamento dos componentes p&uacute;blicos e privados da paisagem urbana, assegurando o equil&iacute;brio visual entre os diversos elementos que a constituem;<br />
III - favorecer a preserva&ccedil;&atilde;o do patrim&ocirc;nio cultural e ambiental urbano;<br />
<strong>IV - promover a participa&ccedil;&atilde;o da comunidade na identifica&ccedil;&atilde;o, valoriza&ccedil;&atilde;o, preserva&ccedil;&atilde;o e conserva&ccedil;&atilde;o dos elementos significativos da paisagem urbana;</strong><br />
V - proteger os elementos naturais, culturais e paisag&iacute;sticos, permitindo a visualiza&ccedil;&atilde;o do panorama e a manuten&ccedil;&atilde;o da paisagem em que est&atilde;o inseridos;<br />
<strong>VI - conscientizar a popula&ccedil;&atilde;o a respeito da valoriza&ccedil;&atilde;o da paisagem urbana como fator de melhoria da qualidade de vida, por meio de programas de educa&ccedil;&atilde;o ambiental e cultural;</strong><br />
VII - consolidar e promover a identidade visual do mobili&aacute;rio urbano, equipamentos e servi&ccedil;os municipais, definindo, padronizando e racionalizando os padr&otilde;es para sua melhor identifica&ccedil;&atilde;o, com &ecirc;nfase na funcionalidade e na integra&ccedil;&atilde;o com a paisagem urbana.<br />
<br />
Par&aacute;grafo &uacute;nico. Entende-se como mobili&aacute;rio urbano todos os objetos, elementos e pequenas constru&ccedil;&otilde;es integrantes da paisagem urbana, de natureza utilit&aacute;ria ou n&atilde;o, implantados pelo poder p&uacute;blico municipal ou mediante sua autoriza&ccedil;&atilde;o expressa.<br />
<br />
SE&Ccedil;&Atilde;O II<br />
DO USO DO ESPAÃ‡O PÃšBLICO<br />
<br />
Art. 23. A pol&iacute;tica municipal do uso do espa&ccedil;o p&uacute;blico tem como prioridade a melhoria das condi&ccedil;&otilde;es ambientais e da paisagem urbana, com os seguintes objetivos:<br />
<br />
<strong>I - ordenar e disciplinar o uso dos espa&ccedil;os p&uacute;blicos, de superf&iacute;cie, a&eacute;reo e do subsolo por atividades, equipamentos, infra-estrutura, mobili&aacute;rio e outros elementos, subordinados &agrave; melhoria da qualidade da paisagem urbana, ao interesse p&uacute;blico, &agrave;s fun&ccedil;&otilde;es sociais da Cidade e &agrave;s diretrizes deste Plano Diretor;</strong><br />
II - ordenar e disciplinar o uso dos espa&ccedil;os p&uacute;blicos para a comercializa&ccedil;&atilde;o de produtos, realiza&ccedil;&atilde;o de eventos e demais atividades, subordinados a preserva&ccedil;&atilde;o da qualidade e identidade urbana;<br />
III - promover a preserva&ccedil;&atilde;o dos espa&ccedil;os p&uacute;blicos livres, que proporcionam &agrave; popula&ccedil;&atilde;o o contato com ambientes naturais amenizando o ambiente urbano constru&iacute;do;<br />
<strong>IV - compatibilizar o uso dos espa&ccedil;os p&uacute;blicos com sua voca&ccedil;&atilde;o e demais fun&ccedil;&otilde;es, valorizando sua import&acirc;ncia para a circula&ccedil;&atilde;o e encontro da popula&ccedil;&atilde;o;</strong><br />
<strong>V - proporcionar no espa&ccedil;o p&uacute;blico condi&ccedil;&otilde;es de seguran&ccedil;a e conforto no deslocamento de pessoas e ve&iacute;culos, priorizando a circula&ccedil;&atilde;o de pedestres, em especial de pessoas com dificuldades de locomo&ccedil;&atilde;o.</strong><br />
<br />
Art. 24. S&atilde;o diretrizes gerais da pol&iacute;tica de uso do espa&ccedil;o p&uacute;blico:<br />
<br />
<strong>I - promover a implanta&ccedil;&atilde;o e adequa&ccedil;&atilde;o da infra-estrutura urbana necess&aacute;ria para o deslocamento e conv&iacute;vio da popula&ccedil;&atilde;o;</strong><br />
II - implementar normas e crit&eacute;rios para a implanta&ccedil;&atilde;o de atividades, equipamentos de infra-estrutura de servi&ccedil;os p&uacute;blicos, mobili&aacute;rio urbano e outros elementos;<br />
III - regulamentar o uso e a implanta&ccedil;&atilde;o de equipamentos de infra-estrutura de servi&ccedil;os p&uacute;blicos de superf&iacute;cie, a&eacute;rea e de subsolo nos espa&ccedil;os p&uacute;blicos;<br />
IV - possibilitar a outorga, concess&atilde;o ou permiss&atilde;o de uso de espa&ccedil;os p&uacute;blicos do Munic&iacute;pio para a implanta&ccedil;&atilde;o de equipamentos de infra-estrutura de servi&ccedil;os p&uacute;blicos, mobili&aacute;rio urbano e outros elementos;<br />
V - coordenar e monitorar as a&ccedil;&otilde;es das concession&aacute;rias de servi&ccedil;os p&uacute;blicos e dos agentes p&uacute;blicos e privados na utiliza&ccedil;&atilde;o do espa&ccedil;o p&uacute;blico, mantendo cadastro e banco de dados atualizado.<br />
&sect; 1&ordm;. Consideram-se equipamentos urbanos destinados &agrave; presta&ccedil;&atilde;o de servi&ccedil;os de infra-estrutura, entre outros, os equipamentos relacionados com abastecimento de &aacute;gua, servi&ccedil;os de esgoto, energia el&eacute;trica, coleta de &aacute;guas pluviais, dutos para transporte de petr&oacute;leo e derivados ou de produtos qu&iacute;micos, transmiss&atilde;o telef&ocirc;nica, de dados ou de imagem, limpeza urbana, g&aacute;s canalizado e transporte.<br />
&sect; 2&ordm;. O uso do espa&ccedil;o p&uacute;blico, de superf&iacute;cie, a&eacute;reo ou de subsolo, poder&aacute; ser objeto de remunera&ccedil;&atilde;o ao Munic&iacute;pio, de acordo com regulamenta&ccedil;&atilde;o espec&iacute;fica.<br />
<br />
<strong>T&Iacute;TULO V<br />
DA GESTÃO DEMOCR&Aacute;TICA DA CIDADE</strong><br />
<br />
<strong>Art. 46. A gest&atilde;o democr&aacute;tica do Munic&iacute;pio de Curitiba tem como objetivo estabelecer uma rela&ccedil;&atilde;o entre a Administra&ccedil;&atilde;o P&uacute;blica e a popula&ccedil;&atilde;o, constru&iacute;da com base na democracia participativa e na cidadania, assegurando o controle social, em busca da cidade sustent&aacute;vel.</strong><br />
<br />
<strong>Art. 47. S&atilde;o diretrizes gerais da gest&atilde;o democr&aacute;tica:</strong><br />
<br />
<strong>I - valorizar o papel da sociedade civil organizada e do cidad&atilde;o como participes ativos e colaboradores, co-gestores, e fiscalizadores das atividades da administra&ccedil;&atilde;o p&uacute;blica;</strong><br />
<strong>II - ampliar e promover a intera&ccedil;&atilde;o da sociedade com o poder p&uacute;blico;</strong><br />
III - garantir o funcionamento das estruturas de controle social previstas em legisla&ccedil;&atilde;o espec&iacute;fica;<br />
<strong>IV - promover formas de participa&ccedil;&atilde;o e organiza&ccedil;&atilde;o, ampliando a representatividade social.</strong><br />
<br />
<strong>Art. 48. Ser&aacute; assegurada a participa&ccedil;&atilde;o direta da popula&ccedil;&atilde;o e de associa&ccedil;&otilde;es representativas de v&aacute;rios segmentos da comunidade na formula&ccedil;&atilde;o, execu&ccedil;&atilde;o e acompanhamento de planos, programas e projetos de desenvolvimento urbano sustent&aacute;vel, mediante as seguintes inst&acirc;ncias de participa&ccedil;&atilde;o:</strong><br />
<br />
I - &oacute;rg&atilde;o colegiado municipal de pol&iacute;tica urbana;<br />
II - debates, audi&ecirc;ncias e consultas p&uacute;blicas;<br />
III - confer&ecirc;ncia municipal da cidade;<br />
<strong>IV - Iniciativa popular de projetos de lei, de planos, programas e projetos de desenvolvimento urbano;</strong><br />
V - conselhos municipais distritais.<br /></p>
<p><a href="http://leismunicipais.com.br/legislacao-de-curitiba/883855/lei-11266-2004-curitiba-pr.html" title="Plano Diretor de Curitiba" target="_blank">clique aqui para acessar o Plano Diretor de Curitiba, na &iacute;ntegra.</a></p>

<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>

	  <a name="5"><h1>Iniciativa Popular</h1></a>
        
        <p align="center">Fundamenta&ccedil;&atilde;o da Iniciativa Popular </p>
        <p>
        <strong>Constitui&ccedil;&atilde;o Federal de 1988:</strong><br />
        <br />
Art. 1&ordm;. Par&aacute;grafo &uacute;nico: <strong>Todo o poder emana do povo</strong>, que <strong>o exerce</strong> por meio de representantes eleitos ou <strong>diretamente</strong>, nos termos desta Constitui&ccedil;&atilde;o.<br />
<br />
Art. 61. <strong>A iniciativa das leis complementares e ordin&aacute;rias cabe</strong> a qualquer membro ou Comiss&atilde;o da C&acirc;mara dos Deputados, do Senado Federal ou do Congresso Nacional, ao Presidente da Rep&uacute;blica, ao Supremo Tribunal Federal, aos Tribunais Superiores, ao Procurador-Geral da Rep&uacute;blica e <strong>aos cidad&atilde;os</strong>, na forma e nos casos previstos nesta Constitui&ccedil;&atilde;o.<br />
<br />
&sect; 2&ordm; <strong>A iniciativa popular pode ser exercida pela apresenta&ccedil;&atilde;o</strong> &agrave; C&acirc;mara dos Deputados <strong>de projeto de lei subscrito por, no m&iacute;nimo, um por cento do eleitorado nacional</strong>, distribu&iacute;do pelo menos por cinco Estados, com n&atilde;o menos de tr&ecirc;s d&eacute;cimos por cento dos eleitores de cada um deles.<br />
<br />
<br />
<strong>Lei Org&acirc;nica do Munic&iacute;pio de Curitiba</strong><br />
<br />
T&iacute;tulo I - DA ORGANIZA&Ccedil;&Atilde;O DO MUNIC&Iacute;PIO<br />
Cap&iacute;tulo I - DISPOSI&Ccedil;&Otilde;ES PRELIMINARES<br />
<br />
Art. 4&ordm;. Ao Munic&iacute;pio incumbe, na sua &oacute;rbita de atua&ccedil;&atilde;o, concretizar os objetivos expressos na Constitui&ccedil;&atilde;o da Rep&uacute;blica Federativa do Brasil, devendo pautar sua a&ccedil;&atilde;o pelo respeito aos princ&iacute;pios dela e da Constitui&ccedil;&atilde;o do Estado do Paran&aacute;, em especial os da democracia e da rep&uacute;blica, implicando, necessariamente, a elei&ccedil;&atilde;o de representantes para o Legislativo e para o Executivo, em responsabilidade e transpar&ecirc;ncia de a&ccedil;&atilde;o, garantidos amplo acesso dos meios de comunica&ccedil;&atilde;o aos atos e informa&ccedil;&otilde;es, <strong>bem como a participa&ccedil;&atilde;o, fiscaliza&ccedil;&atilde;o e controle populares, nos termos da Constitui&ccedil;&atilde;o Federal e desta Lei Org&acirc;nica</strong>.<br />
<br />
Art. 7&ordm;. <strong>Todo Poder emana do povo, que o exerce</strong> por meio de representantes eleitos, <strong>ou diretamente</strong>.<br />
<strong>Par&aacute;grafo &uacute;nico. A soberania popular ser&aacute; exercida:</strong><br />
I. Indiretamente, pelo Prefeito e pelos Vereadores eleitos para a C&acirc;mara Municipal, por sufr&aacute;gio universal e pelo voto direto e secreto.<br />
<strong>II. Diretamente, nos termos da lei, em especial, mediante:</strong><br />
<strong>a) iniciativa popular;</strong><br />
b) referendo;<br />
c) plebiscito.<br />
<br />
Cap&iacute;tulo II - DA COMPETÃŠNCIA DO MUNIC&Iacute;PIO<br />
<br />
Art. 11. Compete ao Munic&iacute;pio prover a tudo quanto respeita ao seu interesse e <strong>ao bem-estar de sua popula&ccedil;&atilde;o</strong>, cabendo-lhe, em especial:<br />
VI. Elaborar o seu Plano Diretor de Desenvolvimento Integrado.<br />
XII. Dispor sobre o controle da polui&ccedil;&atilde;o ambiental.<br />
XV. Disciplinar o tr&acirc;nsito local, sinalizando as vias urbanas e estradas municipais, instituindo penalidades e dispondo sobre a arrecada&ccedil;&atilde;o das multas, especialmente as relativas ao tr&acirc;nsito urbano.<br />
<br />
Art.13. Compete ao Munic&iacute;pio, respeitadas as normas de coopera&ccedil;&atilde;o fixadas em lei complementar, de forma concorrente-cumulativa com a Uni&atilde;o e o Estado:<br />
V. Proporcionar meios de acesso &agrave; cultura, &agrave; educa&ccedil;&atilde;o e &agrave; ci&ecirc;ncia.<br />
VI. Proteger o meio ambiente e combater a polui&ccedil;&atilde;o em qualquer de suas formas.<br />
<br />
Do Processo Legislativo<br />
Disposi&ccedil;&atilde;o Geral<br />
<br />
Das Leis<br />
<br />
Art. 52. <strong>A iniciativa de leis complementares e ordin&aacute;rias cabe</strong> a qualquer membro ou comiss&atilde;o da C&acirc;mara Municipal, ao Prefeito e <strong>aos cidad&atilde;os, mediante iniciativa popular</strong>, na forma e nos casos previstos nesta Lei Org&acirc;nica.<br />
<br />
Art. 55. A <strong>iniciativa popular de projetos de lei</strong> de interesse espec&iacute;fico do Munic&iacute;pio, da cidade ou de bairros poder&aacute; ser <strong>exercida por cinco por cento</strong>, pelo menos, <strong>do eleitorado</strong>.<br />
<br />
<strong>Declara&ccedil;&atilde;o Universal dos Direitos Humanos</strong><br />
<br />
<strong>Artigo XXI.</strong><br />
1. <strong>Todo ser humano tem o direito de fazer parte no governo de seu pa&iacute;s diretamente</strong> ou por interm&eacute;dio de representantes livremente escolhidos.<br />
2. Todo ser humano tem igual direito de acesso ao servi&ccedil;o p&uacute;blico do seu pa&iacute;s.<br />
3. A vontade do povo ser&aacute; a base da autoridade do governo; esta vontade ser&aacute; expressa em elei&ccedil;&otilde;es peri&oacute;dicas e leg&iacute;timas, por sufr&aacute;gio universal, por voto secreto ou processo equivalente que assegure a liberdade de voto.<br />
<br /><br />
<strong>LEI COMPLEMENTAR N&ordm; 2, de 24 de abril de 1991</strong><br />
<br />
Disp&otilde;e sobre regulamenta&ccedil;&atilde;o &agrave;s formas de exerc&iacute;cios da vontade popular, atrav&eacute;s da proposi&ccedil;&atilde;o de Emendas Populares &agrave; Lei Org&acirc;nica Municipal de Curitiba e <strong>Iniciativa Popular de Projetos de Lei</strong>.<br />
<br />
Art. 1&ordm; A democracia direta, como forma de express&atilde;o da vontade popular ser&aacute; exercida, nos termos desta Lei:<br />
<br />
Art. 2&ordm; As proposi&ccedil;&otilde;es de que trata o artigo anterior, ser&atilde;o apresentadas &agrave; Mesa da C&acirc;mara, observados os seguintes requisitos:<br />
<br />
&sect; 1&ordm; Dever&atilde;o ser acompanhadas de listagem onde constem os seguintes dados dos signat&aacute;rios da proposta: nome completo e leg&iacute;vel; assinatura; dados identificadores do T&iacute;tulo Eleitoral e endere&ccedil;o completo.<br />
<br />
&sect; 2&ordm; As proposi&ccedil;&otilde;es dever&atilde;o ser apresentadas em papel de formato oficio, onde datilografado conste:<br />
<br />
I - o <strong>t&iacute;tulo da proposi&ccedil;&atilde;o</strong>, seguido pelo <strong>texto</strong> da emenda ou <strong>do Projeto de Lei</strong>;<br />
II - <strong>a justificativa, contendo os motivos da proposi&ccedil;&atilde;o</strong>, que poder&aacute; a crit&eacute;rio dos signat&aacute;rios, ser acompanhada de dados ou documentos demonstrativos;<br />
III - a <strong>indica&ccedil;&atilde;o de um representante para defender</strong> a proposi&ccedil;&atilde;o escolhida entre os signat&aacute;rios.<br /></p>

<p><a href="http://leismunicipais.com.br/legislacao-de-curitiba/56805/lei-complementar-2-1991-curitiba-pr.html" title="Lei Complementar 2/1991 de Curitiba" target="_blank">clique aqui para acessar a Lei Complementar 2/91, na &iacute;ntegra.</a></p>


<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
      </div><!-- coluna_internas -->
    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
