#!/usr/bin/perl
require('cgi-lib.pl');
&ReadParse(*input);

use DBI;

require ('db-config.pl');

$atr = "DBI:$driver:database=$meudb;host=$host";
$conn = DBI->connect ($atr, $user, $pass);

print "Content-type:text/html\n\n";

$ativo_saibamais = " class=\"ativo\"";
$ativo_validadejuridica = " class=\"ativo\"";

$cabecalho = "
    <div id =\"topo\">
		<div class=\"marca\"><a href=\"https://www.votolivre.org\" title=\"VotoLivre.org\"><img src=\"https://www.votolivre.org/votolivre/novosite/imagens/votolivre.gif\" width=\"300\" height=\"60\" /></a></div><!-- marca -->
		<div class=\"menu\">
            
<ul><!-- geral -->
        	<li class=\"nav\"><a href=\"#\"><h1$ativo_saibamais>Saiba Mais</h1></a>
            	<ul>
                <li><a href=\"https://www.votolivre.org/quem-somos.html\"><h2>Quem somos</h2></a></li>
                <li><a href=\"https://www.votolivre.org/movimento.html\"><h2>O Movimento</h2></a></li>
                <li><a href=\"https://www.votolivre.org/lei-municipal.html\"><h2>Lei Municipal</h2></a></li>
                <li class=\"ultimo\"><a href=\"https://www.votolivre.org/validade-juridica.html\"><h2$ativo_validadejuridica>Validade Jur&iacute\;dica</h2></a></li>
				</ul>
            </li>
            <img src=\"https://www.votolivre.org/votolivre/novosite/imagens/menu-spacer.gif\" width=\"20\" height=\"33\" />
          <li class=\"nav\"><a href=\"#\"><h1$ativo_midia>M&iacute\;dia</h1></a>
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

<title>VotoLivre.org | Validade Jurídica</title>

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
<div class="imagem-validade">
</div><!--imagem-->
</div><!-- cabeca-interna -->
	
	<div id="wrapper">
    	<div id="sidebar-esquerda">
        	
<div class="submenu">
<h1>SUBT&Oacute;PICOS</h1>
<ul>
<a href="#1"><li>A iniciativa popular</li></a>
<a href="#conclusao"><li>Conclusão</li></a>
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
<div id="coluna-internas"> <a name="1">
      <h1 align="center">Validade jurídica das iniciativas populares <br/>
        através da internet</h1>
      </a>
      <p align="center"><strong>Votolivre.org – ferramenta de democracia livre e direta.<br/>
        Vote em ideias, não em pessoas!</strong></p>
      <br/>
      <p>• Você sabia que pode <strong>fazer leis?</strong></p>
      <p>• Isto está na Constituição.</p>
      <p>• Curitiba também prevê na sua Lei Municipal Orgânica.</p>
      <p>• Estabelece para isso um <strong>mínimo de 5% do eleitorado</strong> curitibano</p>
      <p>• São <strong>65.000 eleitores curitibanos</strong>.</p>
      <p>• Precisa do <strong>título de eleitor</strong>.</p>
      <p>• Dá para fazer pela <strong>internet</strong>.</p>
      <br/>
      <p>O presente texto tem a finalidade de esclarecer toda a sociedade (incluído assim
        a comunidade jurídica e os integrantes dos três poderes) sobre a validade
        jurídica da presente iniciativa popular através da internet.</p>
      <p>Assim, dois aspectos devem ser considerados: o fundamento da iniciativa popular e a
        validade da utilização de meio eletrônico (internet) para reunir as
        assinaturas.</p>
      <p>O fundamento da iniciativa popular está na Constituição Federal de 1988, que é
        uma constituição cidadã e diz que "<b style="mso-bidi-font-weight:normal"><i style="mso-bidi-font-style:normal">Todo o poder emana do povo</i></b><i style="mso-bidi-font-style:normal">, <b style="mso-bidi-font-weight:normal">que
        o exerce</b> por meio de representantes eleitos <b style="mso-bidi-font-weight:
normal">ou diretamente</b></i>". (<a href="http://www.planalto.gov.br/ccivil_03/constituicao/constitui%C3%A7ao.htm">art.
        1º., parágrafo único, da CF/88</a>) e que a iniciativa das leis também cabem
        aos cidadãos, através da iniciativa popular (art. 61, <i style="mso-bidi-font-style:
normal">caput</i> e § 2°).</p>
      <p>Essa
        garantia é ainda mais reforçada pela Declaração Universal dos Direitos Humanos
        que diz que "<b style="mso-bidi-font-weight:normal"><i style="mso-bidi-font-style:
normal">Todo ser humano tem o direito de fazer parte no governo de seu país
        diretamente</i></b><i style="mso-bidi-font-style:normal"> ou por intermédio de
        representantes livremente escolhidos</i>" (<a href="http://portal.mj.gov.br/sedh/ct/legis_intern/ddh_bib_inter_universal.htm">Artigo
        XXI</a>), e a nossa Constituição dá força de norma constitucional aos tratados
        internacionais sobre direitos humanos (art.5</span><span style="font-size:11.0pt;
line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-bidi-font-weight:bold"> º,</span><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span><span style="font-size:11.0pt;
line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-bidi-font-weight:bold">§
        3º</span><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">).
        <o:p></o:p>
        </span></p>
      <p>Curitiba
        consagra a soberania popular, confirmando que o povo pode participar
        diretamente da democracia mediante iniciativa popular, estabelecendo que
        "poderá ser exercida por cinco por cento, pelo menos, do eleitorado" (<a href="http://www.cmc.pr.gov.br/down/lei_organica_maio_2008.pdf">Art. 7º., II,
        "a", e art. 55 da Lei Municipal Orgânica</a>).</p>
      <p>Esclarecido
        o fundamento jurídico da iniciativa popular, passamos a analisar a utilização
        de estruturas eletrônicas e de informática para reunir as assinaturas dos
        cidadãos que, em substituição do documento de papel, fornecem digitalmente (ou
        online) o conjunto de informações pessoais necessárias que caracterizam o
        eleitor, declarando a veracidade das informações e a sua adesão ao projeto de lei.</p>
      <p>A
        validade da utilização de meio eletrônico para reunir assinaturas tem fundamento
        na <a href="http://www.iti.gov.br/twiki/pub/Certificacao/MedidaProvisoria/MEDIDA_PROVIS_RIA_2_200_2_D.PDF">Medida
        Provisória nº 2.200-2</a> (de 24 de agosto de 2001) que "Institui a
        Infra-Estrutura de Chaves Públicas Brasileira - ICP-Brasil, transforma o
        Instituto Nacional de Tecnologia da Informação em autarquia", que dispõe que:</p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:29.2pt;margin-bottom:
0cm;margin-left:27.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">"Art.
        1º. Fica instituída a Infra-Estrutura de Chaves Públicas Brasileira -
        ICP-Brasil, <b style="mso-bidi-font-weight:normal">para garantir a
        autenticidade, a integridade e a validade jurídica de documentos em forma
        eletrônica</b>, das aplicações de suporte e das aplicações habilitadas <b style="mso-bidi-font-weight:normal">que utilizem certificados digitais</b>, bem
        como a realização de transações eletrônicas seguras.
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:29.2pt;margin-bottom:
0cm;margin-left:27.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp; </span>
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:29.2pt;margin-bottom:
0cm;margin-left:27.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Art.
        10º. <b style="mso-bidi-font-weight:normal">Consideram-se documentos</b> públicos ou particulares, <b style="mso-bidi-font-weight:normal">para todos os
        fins legais</b>, <b style="mso-bidi-font-weight:normal">os documentos
        eletrônicos</b> de que trata esta Medida Provisória.
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:29.2pt;margin-bottom:
0cm;margin-left:27.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">§
        1º <b style="mso-bidi-font-weight:normal">As declarações constantes</b> <b style="mso-bidi-font-weight:normal">dos documentos em forma eletrônica</b> <b style="mso-bidi-font-weight:normal">produzidos com a utilização de processo de
        certificação disponibilizado pela ICP-Brasil presumem-se verdadeiros em relação
        aos signatários</b>, na forma do art. 131 da Lei nº 3.071, de 1º de janeiro de
        1916 - Código Civil.</span><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:29.2pt;margin-bottom:
0cm;margin-left:27.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">§
        2º O disposto nesta Medida Provisória<b style="mso-bidi-font-weight:normal"> não obsta a utilização de outro meio de comprovação da autoria e integridade de
        documentos em forma eletrônica, inclusive os que utilizem certificados não
        emitidos pela ICP-Brasil, desde que admitido pelas partes como válido ou aceito
        pela pessoa a quem for oposto o documento</b>.
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="text-align:justify;line-height:150%"><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">
        <o:p>&nbsp;</o:p>
        </span></p>
      <p>O
        próprio Instituto Nacional de Tecnologia da Informação – ITI, prevê a
        possibilidade de usar a informação digital para "<b style="mso-bidi-font-weight:
normal"><i style="mso-bidi-font-style:normal"><a href="http://www.iti.gov.br/twiki/bin/view/Certificacao/PerguntaDoze">facilitar
        a iniciativa popular<span style="font-weight:normal"> na apresentação de </span>projetos
        de lei<span style="font-weight:normal">, uma vez que </span>os cidadãos poderão
        assinar digitalmente sua adesão às propostas</a></i></b>", por meio de Certificação
        Digital.</p>
      <p>Assim,
        o votolivre.org conta com o <b style="mso-bidi-font-weight:normal"><a href="https://www.votolivre.org/politica-de-privacidade.html">Certificado
        SSL/TLS - Site Seguro Pro da Certisign</a></b>, que é reconhecido como a
        ferramenta mais poderosa para garantir a segurança na autenticação de sites web
        e manter o sigilo e a integridade na comunicação, o Certificado Site Seguro Pro
        fornece a segurança necessária, implementando os mesmos recursos de proteção
        utilizados pelas maiores e mais importantes organizações do mundo. Adotado como
        padrão de segurança máxima em comércio eletrônico, internet banking e demais
        aplicações que requerem um elevado nível de confiabilidade, o certificado Site
        Seguro Pro utiliza criptografia forte, hoje a mais elevada do mundo. É o
        certificado digital web mais seguro disponível atualmente no mercado, pois sua
        força computacional é comprovadamente superior aos outros em 300 trilhões de
        vezes. É utilizado pelas maiores empresas do mundo, principalmente dos setores
        bancário, governamental e de saúde, além de empresas de comércio eletrônico.</p>
      <p>A <a href="http://www.certisign.com.br/a-certisign/sobre-a-certisign" target="_blank"><span style="mso-bidi-font-family:&quot;Times New Roman&quot;;color:windowtext;
text-decoration:none;text-underline:none">Certisign</span></a> é Autoridade
        Certificadora no mercado brasileiro operando em múltiplas hierarquias, inclusive
        no <b style="mso-bidi-font-weight:normal"><a href="http://www.iti.gov.br/twiki/pub/Certificacao/EstruturaIcp/Estrutura_da_ICP-Brasil_-_site.pdf">ICP-Brasil <span style="font-weight:normal">(Infraestrutura de Chaves Públicas Brasileira)</span></a></b> que foi instituída pela Medida Provisória 2.200/2001.</p>
      <p>Portanto,
        conforme o art. 10º. e § 1º., "<b style="mso-bidi-font-weight:normal"><i style="mso-bidi-font-style:normal">Consideram-se documentos</i></b><i style="mso-bidi-font-style:normal"> públicos ou particulares, <b style="mso-bidi-font-weight:normal">para todos os fins legais</b>, <b style="mso-bidi-font-weight:normal">os documentos eletrônicos</b> <b style="mso-bidi-font-weight:normal">de que trata esta Medida Provisória</b>"</i>,
        sendo que "<b style="mso-bidi-font-weight:normal"><i style="mso-bidi-font-style:
normal">As declarações constantes dos documentos em forma eletrônica</i></b><i style="mso-bidi-font-style:normal"> produzidos com a utilização de processo de
        certificação disponibilizado pela ICP-Brasil <b style="mso-bidi-font-weight:
normal">presumem-se verdadeiros em relação aos signatários</b>, na forma do
        art. 131 da Lei nº 3.071, de 1º de janeiro de 1916 - Código Civil</i>", base
        para a validade da utilização de meio eletrônico para reunir assinaturas de
        iniciativa popular.</p>
      <p>Além
        disso, o § 2º do art. 10 da <a href="http://www.iti.gov.br/twiki/bin/view/Certificacao/MedidaProvisoria" target="_top"><span style="color:windowtext;text-decoration:none;text-underline:
none">Medida Provisória n° 2.200-2</span></a> (link) dispõe que "<i style="mso-bidi-font-style:normal">O disposto nesta Medida Provisória <b style="mso-bidi-font-weight:normal">não obsta a utilização de outro meio de
        comprovação da autoria e integridade de documentos em forma eletrônica,
        inclusive os que utilizem certificados não emitidos pela ICP-Brasil</b>, desde
        que admitido pelas partes como válido ou aceito pela pessoa a quem for oposto o
        documento</i>". E segundo frisa o próprio ITI, outros "<i style="mso-bidi-font-style:
normal">documentos eletrônicos assinados digitalmente</i>" (mesmo sem a
        Certificação Digital) "<i style="mso-bidi-font-style:normal"><a href="http://www.iti.gov.br/twiki/bin/view/Certificacao/PerguntaDezenove">também
        têm validade jurídica<span style="font-style:normal">, mas esta dependerá da
        aceitação de ambas as partes, emitente e destinatário</span></a></i>".</p>
      <p>Isto
        tem validade da mesma forma que você faz compras e assina contratos via
        internet. Inclusive a Internet já é usada em processos como prova documental,
        sendo que muitos tribunais brasileiros começaram a utilizar petições
        eletrônicas, em lugar de processos de papel. Por isso que você preenche um
        cadastro declarando a veracidade de suas informações e a adesão ao projeto de
        lei, mediante a apresentação de um CPF válido.</p>
      <p>A
        listagem com os dados dos eleitores (título eleitoral e endereço), que
        assinarem a proposta, será entregue na Comissão de Participação Legislativa da
        Câmara Municipal de Curitiba (com cópia para o Tribunal Regional Eleitoral –
        TRE/PR), que, em caso de dúvida, poderá fazer a respectiva conferência da
        adesão do eleitor. Serão
        desconsiderados da listagem os títulos eleitorais inválidos, irregulares e que
        não sejam de eleitores do Município de Curitiba, bem como os cadastros com
        informações omissas ou incorretas.</p>
      <p>Por
        ocasião do recebimento do Projeto de Lei de Iniciativa Popular, a Câmara dos
        Vereadores terá a oportunidade de conferir a validade e adequação do projeto de
        lei e da adesão dos eleitores.</p>
      <p>Para
        isso certos requisitos são necessários, como a identificação do Título
        Eleitoral e endereço, pois não se trata de um abaixo-assinado, mas sim de
        projeto de lei apresentado pela própria sociedade.</p>
      <p>Assim,
        a <a href="http://www.leismunicipais.com.br/legislacao-de-curitiba/56805/lei-complementar-2-1991-curitiba-pr.html">Lei
        Complementar nº 2/1991</a>, que regulamenta o exercício da democracia direta,
        como forma de expressão da vontade popular, dispõe que as proposições de
        iniciativas populares deverão observar os seguintes requisitos:</p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:20.2pt;margin-bottom:
0cm;margin-left:9.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Art.
        2º. As proposições de que trata o artigo anterior, serão apresentadas à Mesa da
        Câmara, observados os seguintes requisitos:
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:20.2pt;margin-bottom:
0cm;margin-left:9.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">§
        1º. <b style="mso-bidi-font-weight:normal">Deverão ser acompanhadas de listagem
        onde constem os seguintes dados dos signatários da proposta: nome completo e
        legível; assinatura; dados identificadores do Título Eleitoral e endereço
        completo</b>.
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:20.2pt;margin-bottom:
0cm;margin-left:9.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">§
        2º. As proposições deverão ser apresentadas em papel de formato oficio, onde
        datilografado conste:
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:20.2pt;margin-bottom:
0cm;margin-left:9.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">I
        - o <b style="mso-bidi-font-weight:normal">título da proposição</b>, seguido
        pelo <b style="mso-bidi-font-weight:normal">texto</b> da emenda ou <b style="mso-bidi-font-weight:normal">do Projeto de Lei</b>;
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:20.2pt;margin-bottom:
0cm;margin-left:9.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">II
        - <b style="mso-bidi-font-weight:normal">a justificativa</b>, <b style="mso-bidi-font-weight:normal">contendo os motivos da proposição</b>, que
        poderá a critério dos signatários, ser acompanhada de dados ou documentos
        demonstrativos;
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="margin-top:0cm;margin-right:20.2pt;margin-bottom:
0cm;margin-left:9.0pt;margin-bottom:.0001pt;text-align:justify;line-height:
150%"><span style="font-size:11.0pt;line-height:150%;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">III
        - a indicação de um representante para defender a proposição escolhida entre os
        signatários.</span><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">
        <o:p></o:p>
        </span></p>
      <p class="MsoNormal" style="text-align:justify;line-height:150%"><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">
        <o:p>&nbsp;</o:p>
        </span></p>
      <p>Pelo
        que, uma vez observados esses requisitos, a propositura tem validade de
        iniciativa popular. Não se desconhece que é possível que aqueles desprovidos de
        raciocínio jurídico sistemático-hermenêutico, ou de má-fé, queiram entender de
        forma cega e literal que o projeto de iniciativa popular só pode ser apresentado
        "<i style="mso-bidi-font-style:normal">em papel de formato ofício</i>" "<i style="mso-bidi-font-style:normal">datilografado</i>". Contudo, a interpretação
        jurídica acertada e adequada, leva em consideração o ordenamento jurídico como
        um todo, buscando atender a finalidade da lei e a sua conformidade com os
        princípios fundamentais do direito, bem como a aplicação atual da lei frente às
        novas formas jurídicas, como bem sabe qualquer operador razoável do Direito.</p>
      <p>Assim,
        vislumbra-se evidente que o exame sistemático e hermenêutico da matéria,
        alberga a atualização da forma trazida pela nova lei, atualizando a anterior no
        que é cabível, de maneira a respeitar os dispositivos legais fundamentais em
        apreciação e atender a sua finalidade, eis que a referida Lei Complementar data
        de 1991, duas décadas atrás, muito antes da introdução dos novos meios
        eletrônicos/digitais e do advento da Medida Provisória nº 2.200-2/2001.</p>
      <p>Além disso, a referida Lei Complementar não dispõe
        como requisito para a iniciativa popular que as assinaturas colhidas tenham reconhecimento
        de firma. Assim, é manifesta a validade da reunião de assinaturas com
        Certificação fornecida por Autoridade Certificadora no âmbito do ICP-Brasil
        para comprovação dos requisitos necessários.</p>
      <a name="conclusao" />
      <p>Para
        ir direto ao ponto, a validade da utilização de meio eletrônico para reunir
        assinaturas de iniciativa popular tem fundamento jurídico sólido, podendo
        inclusive ser objeto de medida judicial visando garantir seu reconhecimento.</p>
      <p>Justamente
        para demonstrar a viabilidade dessa idéia que o site votolivre.org foi criado.</p>
      <p>É
        notória a utilidade desta modalidade de reunião de assinaturas, que vêm com
        forte capacidade no sentido de estreitar as distâncias entre os cidadãos, e
        permitir uma melhor organização das iniciativas populares.</p>
      <p>De
        mesma forma, é uma iniciativa que aproxima os cidadãos, o legislativo e
        administração pública, por isso o votolivre.org é um movimento de Conciliação Social.
        É um passo para aproximação dos ideais da sociedade como um todo.</p>
      <p>É
        a democracia exercida de forma livre e direta.</p>
      <a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a> </div>
    <!-- coluna_internas -->
    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
