#!/usr/bin/perl
require('cgi-lib.pl');
&ReadParse(*input);

use DBI;

require ('db-config.pl');

$atr = "DBI:$driver:database=$meudb;host=$host";
$conn = DBI->connect ($atr, $user, $pass);

print "Content-type:text/html\n\n";

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
		<div class="imagem-politica">
        </div><!--imagem-->
	</div><!-- cabeca-interna -->
	
	<div id="wrapper">
    	<div id="sidebar-esquerda">
        	
        	<div class="submenu">
            <h1>SUBT&Oacute;PICOS</h1>
            <ul>
            	<a href="#1"><li>Política de Privacidade</li></a>
                <a href="#2"><li>Certificados SSL/TLS</li></a>
                <a href="#3"><li>Certisign</li></a>
                <a href="#4"><li>Verisign</li></a>
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
 
        	<a name="1"><h1>Política de Privacidade</h1></a>
            <p>A Política de Privacidade do votolivre.org foi criada para demonstrar o compromisso do movimento com a segurança e a privacidade de informações coletadas dos usuários/votantes.</p>
<p><strong>1.</strong> Quaisquer informações que os usuários/votantes passarem serão coletadas e guardadas de acordo com padrões rígidos de segurança e confidencialidade (<strong><a href="http://www.certisign.com.br/produtos-e-servicos/certificados-para-servidor-web/certificado-para-servidor-web-site-seguro-pro" target="_blank">Certificados SSL/TLS - Site Seguro Pro*</a></strong> da <strong>Certisign**</strong>).</p>
<p><strong>2.</strong> As informações pessoais que nos forem passadas pelos usuários serão coletadas por meios éticos e legais, com o propósito apresentado no site, sobre os quais os usuários são informados.</p>
<p><strong>3.</strong> O votolivre.org manterá íntegras as informações que forem fornecidas pelos votantes.</p>
 
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
 
<a name="2"><h1>Certificados SSL/TLS - Site Seguro Pro - Certisign</h1>
 
<p>Reconhecido como a ferramenta mais poderosa para garantir a segurança na autenticação de sites web e
manter o sigilo e a integridade na comunicação, o certificado Site Seguro Pro fornece à sua organização
a segurança necessária, implementando os mesmos recursos de proteção utilizados pelas maiores e mais
importantes organizações do mundo.</p>
 
<p>Adotado como padrão de segurança máxima em comércio eletrônico, internet banking e demais
aplicações que requerem um elevado nível de confiabilidade, o certificado Site Seguro Pro utiliza
criptografia forte, hoje a mais elevada do mundo.</p>
 
<p>Garante uma cifragem única de 128 bits através dos canais SSL/TLS. É o certificado digital web mais
seguro disponível atualmente no mercado, pois sua força computacional é comprovadamente superior
aos outros em 300 trilhões de vezes. É utilizado pelas maiores empresas do mundo, principalmente dos
setores bancário, governamental e de saúde, além de empresas de comércio eletrônico.</p>
 
<p><strong>O certificado Site Seguro Pro proporciona:</strong></p>
 
<p>• A autenticação de seus servidores: os usuários do site da sua organização passam a navegar com
total tranqüilidade, com a garantia de que realmente estão conectados ao site "original" e não a uma
cópia operada por fraudadores;</p>
 
<p>• Um canal criptográfico seguro: que mantêm o sigilo e a integridade das informações confidenciais
durante todo o caminho entre o navegador web do usuário e o servidor do seu site. Para tanto, esse
canal utiliza-se de criptografia, nos padrões do protocolo SSL/TLS;</p>
 
<p>• O Selo Site Seguro Certisign: um sinônimo de confiança e proteção na Internet, que será exibido em
seu site.</p>
 
<p><strong>Criptografia 128 bits - cifragem única</strong></p>
<p>Criptografia forte de 128 bits. Amplamente utilizada nas áreas de comércio eletrônico, internet banking,
saúde, seguros e outras empresas de grande porte em todo o mundo.</p>
 
<img src="https://www.votolivre.org/votolivre/novosite/imagens/100x46_transparente.gif" />
 
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
 
<a name="3"><h1><a href="http://www.certisign.com.br/a-certisign/sobre-a-certisign" target="_blank">Certisign</a></h1>
 
<p>Única Autoridade Certificadora no mercado brasileiro operando em múltiplas hierarquias, como ICP-Brasil,
VeriSign Trust Network (VTN) e Privada.</p>
 
<img src="https://www.votolivre.org/votolivre/novosite/imagens/logo_certisign.gif" />
 
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
 
<a name="4"><h1><a href="http://www.certisign.com.br/certificacao-digital/infra-estrutura-de-chave-publica/icp-brasil" target="_blank">ICP-Brasil Infraestrutura de Chaves Públicas Brasileira</a></h1>
<p>A ICP-Brasil (Infraestrutura de Chaves Públicas Brasileira) foi instituída pela Medida Provisória 2.200-
2, de 24 de agosto de 2001, que cria o Comitê Gestor da ICP-Brasil, a Autoridade Certificadora Raiz
Brasileira e define as demais entidades que compõem sua estrutura.</p>
 
<p>A partir dessa MP, foram elaborados os regulamentos que regem as atividades das entidades integrantes
da Infraestrutura de Chaves Públicas Brasileira: Resoluções do Comitê Gestor da ICP-Brasil, as Instruções
Normativas e outros documentos.</p>
 
<p>O modelo de Infraestrutura adotado pela ICP-Brasil foi o de Certificado com Raiz única. O Instituto
Nacional de Tecnologia da Informação - ITI está na ponta desse processo como Autoridade Certificadora
Raiz. Cabe ao Instituto credenciar os demais participantes da cadeia, supervisionar e fazer auditoria dos
processos.</p>
 
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
 
<a name="4"><h1><a href="http://www.certisign.com.br/certificacao-digital/infra-estrutura-de-chave-publica/verisign" target="_blank">Verisign</a></h1>
 
<p><strong>A Infraestrutura de Chaves Públicas da Verisign Trust Network.</strong></p>
 
<p>A VeriSign Inc. (Nasdaq:VRSN) é líder mundial na prestação de serviços de confiança - identificação,
autenticação, validação e pagamento - em redes de comunicação.</p>
 
<p>Os serviços da VeriSign permitem que pessoas físicas e jurídicas, em qualquer lugar do mundo, se
comuniquem, transacionem e comercializem com segurança em meio eletrônico.
</p>
<p>Utilizando uma gigantesca infraestrutura internacional, a empresa controla mais de 5 bilhões de conexões
de redes e transações por dia. A VeriSign mantém alianças estratégicas com empresas como a Microsoft,
a Netscape, a Cisco e a British Telecommunications.</p>
 
<p>Entre seus mais de 10 milhões de clientes estão o Bank of América, a Hewlett Packard, a Receita
Federal norte-americana e a VISA. Mais de 1 milhão de sites possuem Certificados da VeriSign e mais
de 10 milhões de pessoas físicas utilizam os Certificados de e-mail da empresa. Em 6 anos de operação
mundial, jamais foi detectada uma fraude.</p>
 
<p>Os serviços e produtos da VeriSign são oferecidos no Brasil exclusivamente pela Certisign Certificadora
Digital S.A., única afiliada brasileira da VeriSign Trust Network.</p>
 
<img src="https://www.votolivre.org/votolivre/novosite/imagens/image.jpg" />
            
            
			<a href="#topo"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_topo.gif" /></a>
            
      </div><!-- coluna_internas -->

    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
