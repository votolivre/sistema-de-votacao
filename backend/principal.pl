#!/usr/bin/perl
require('cgi-lib.pl');
&ReadParse(*input);

use DBI;

require ('db-config.pl');

$atr = "DBI:$driver:database=$meudb;host=$host";
$conn = DBI->connect ($atr, $user, $pass);

print "Content-type:text/html\n\n";

# pegando o id da último Lei que está no BD (a última é a que está no ar SEMPRE)
$query = "SELECT MAX(`id`) FROM `leis_publicadas` WHERE 1";
$q = $conn->prepare ($query);
$q->execute();
($ultimo_id) = $q->fetchrow_array;
$q->finish();

# puxando o CABEÇALHO e RODAP&Eacute; do site
$query = "SELECT `cabecalho`,`rodape` FROM `leis_publicadas` WHERE `id` = '$ultimo_id'";
$q = $conn->prepare ($query);
$q->execute();
($cabecalho, $rodape) = $q->fetchrow_array;
$q->finish();

# contando quantos votos esta Lei recebeu
$query = "SELECT COUNT(*) FROM `votos` WHERE `id_lei` = '$ultimo_id'";
$q = $conn->prepare ($query);
$q->execute();
$qts_votos = $q->fetchrow_array;
# somando  mais +414 (com os 70 iniciais) pra chegar nos 11.111
$qts_votos = $qts_votos + 554;
$q->finish();

print <<"imprime";

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta property="og:image" content="http://www.votolivre.org/votolivre/novosite/imagens/forfb.jpg" />
<meta property="og:title" content="Eu fiz minha parte e confirmei o voto. Precisamos de 65.000 votos. Participe." />
<meta property="og:description" content="LEI DA BICILETA (Lei da Mobilidade Urbana Sustentável): Institui a bicicleta como meio de transporte em Curitiba e estabelece 5% das vias urbanas destinadas a construção de ciclo-faixas e ciclovias no modelo funcional, interconectando a Cidade." />
<title>VotoLivre.org | A democracia exercida de forma livre e direta.</title>

<link rel="stylesheet" type="text/css" href="https://www.votolivre.org/votolivre/novosite/estilo.css" />

<!-- Update your browser -->
<!-- script type="text/javascript" src="https://updateyourbrowser.net/asn.js"> </script>

<!-- Fancybox -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript" src="https://www.votolivre.org/votolivre/novosite/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="https://www.votolivre.org/votolivre/novosite/fancybox/jquery.easing-1.3.pack.js"></script>
<script type="text/javascript" src="https://www.votolivre.org/votolivre/novosite/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
<link rel="stylesheet" href="https://www.votolivre.org/votolivre/novosite/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

<!-- Twitter -->
<script src="https://www.votolivre.org/votolivre/novosite/externos/twitter.min.js" type="text/javascript"></script>

</head>

<body>

<div id="conteudo">
	
$cabecalho
	
    <div id="cabeca">
		<div class="imagem">
        <div class="mascara-contador">
        </div>
        <div class="contador">
        <h1>$qts_votos</h1>
        </div><!-- contador -->
        <div class="clear"></div>
        <div class="voteja">
        <a class="cadastro_iframe" href="https://www.votolivre.org/votolivre/novosite/cadastro_01.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/voteja.png" /></a>
        </div><!-- voteja -->
        </div><!--imagem-->

        <!--
		<div id="faixa-twitter"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bird.png" width="24" height="16" /><p>.Carregando tweets</p><img src="https://www.votolivre.org/votolivre/novosite/imagens/loader.gif" style="float:left;" /></div>
		-->
		<!--faixa-twitter -->
		<div id="faixa-twitter"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bird.png" width="24" height="16" /><p id=twitter-home>
		A Democracia Direta Digital est� chegando na sua casa.

<!--
<a class="twitter-timeline" width="800" href="https://twitter.com/votolivre_org"
   data-widget-id="346442055381291008"
   data-screen-name="votolivre_org" data-show-replies="false"
   data-tweet-limit="1"></a>

            <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
-->
		</p></div>
        
	</div><!-- cabeca -->
	
	<div id="wrapper">
        <div id="coluna-esquerda">
<a href="http://www.youtube.com/watch?v=yfEUiybUa9E" target="_blank"><span style="position:absolute;top:208px;background-color:#990000;width:2px;height:2px;"></span></a>
<a href="http://www.youtube.com/watch?v=Wos-dDxpJlQ" target="_blank"><span style="position:absolute;top:194px;background-color:#990000;width:2px;height:2px;"></span></a>
		
       <div class="box-destaque">

        <object width="540" height="396">
        <param name="movie" value="https://www.youtube.com/e/PM3ggZt8PrY?fs=1&amp;hl=pt_BR"></param>
        <param name="allowFullScreen" value="true"></param>
        <param name="allowscriptaccess" value="always"></param>
        <param name="wmode" value="opaque"></param>
        <embed src="https://www.youtube.com/e/PM3ggZt8PrY?fs=1&amp;hl=pt_BR" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="540" height="396" wmode="opaque"></embed></object>


        <br/>
        <h1>A bicicleta resolveu o tr&acirc;nsito de Bogot&aacute;/COL e revolucionou a cidade.<br/>Vamos resolver o tr&acirc;nsito curitibano e revolucionar nossa cidade.</h1>
        <br/>
        <!-- object width="540" height="334">
        <param name="movie" value="http://www.youtube.com/v/Pg4uikZnx5I?fs=1&amp;hl=pt_BR"></param>
        <param name="allowFullScreen" value="true"></param>
        <param name="allowscriptaccess" value="always"></param>
        <param name="wmode" value="opaque"></param>
        <embed src="http://www.youtube.com/v/Pg4uikZnx5I?fs=1&amp;hl=pt_BR" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="540" height="334" wmode="opaque"></embed></object>
        <div class="right"><p>Saiba mais sobre o conceito da <a href="bicicleta-branca.html" target="_blank">Bicicleta Branca</a></p></div -->
        
        <div class="clear"></div>
        </div><!-- box-destaque -->
        
        <div id="passos">
        <img src="https://www.votolivre.org/votolivre/novosite/imagens/1_.png" /><p>Voc&ecirc; sabia que pode <strong>fazer Leis</strong>?</p>
        </div><!-- 7passos -->
        <div id="passos">
        <img src="https://www.votolivre.org/votolivre/novosite/imagens/2_.png" /><p>Isto est&aacute; na <a href="http://leismunicipais.com.br/cgi-local/leisb.pl?cod=1" title="Constitui&ccedil;&atilde;o" style="color:#fff;text-decoration:underline" target="_blank">Constitui&ccedil;&atilde;o</a></p>
        </div><!-- 7passos -->
        <div id="passos">
        <img src="https://www.votolivre.org/votolivre/novosite/imagens/3_.png" /><p>Curitiba tamb&eacute;m prev&ecirc; na sua <a href="http://leismunicipais.com.br/lei-organica/curitiba-pr/5520" title="Lei Org&acirc;nica de Curitiba" style="color:#fff;text-decoration:underline" target="_blank">Lei Org&acirc;nica Municipal</a></p>
        </div><!-- 7passos -->
        <div id="passos">
        <img src="https://www.votolivre.org/votolivre/novosite/imagens/4_.png" /><p>Estabelece para isso um m&iacute;nimo de <strong>5% do eleitorado</strong> curitibano</p>
        </div><!-- 7passos -->
        <div id="passos">
        <img src="https://www.votolivre.org/votolivre/novosite/imagens/5_.png" /><p>S&atilde;o <strong>65.000 eleitores</strong> curitibanos</p>
        </div><!-- 7passos -->
        <div id="passos">
        <img src="https://www.votolivre.org/votolivre/novosite/imagens/6_.png" /><p>S&oacute; precisa do <strong>T&iacute;tulo de Eleitor</strong></p>
        </div><!-- 7passos -->
        <div id="passos-ultima">
        <img src="https://www.votolivre.org/votolivre/novosite/imagens/7_.png" /><p>D&aacute; para fazer pela <strong>internet</strong></p>
        </div><!-- 7passos -->
        
        
        <div class="box-lei">
        	<div class="titulo-lei">
            <h1>LEI DA BICICLETA - Lei da Mobilidade Urbana Sustent&aacute;vel</h1>
            </div><!-- titulo-lei -->
            <div class="descricao-lei">
            <h2>- Institui a bicicleta como modal de transporte regular em Curitiba. <a href="https://www.votolivre.org/lei-municipal.html">Conhe&ccedil;a a Lei na &iacute;ntegra.</a></h2>
            </div><!-- descricao-lei -->
            <div class="itens-box">
            	<div class="feat linha">
            	<img src="https://www.votolivre.org/votolivre/novosite/imagens/feat_1.gif" width="15" height="15" style="margin:4px 0;" /><h3>ciclo-faixas e ciclovias</h3>
                <a href="https://www.votolivre.org/movimento.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_saibamais.gif" width="59" height="23" /></a>
                <p>5% das vias urbanas destinadas a constru&ccedil;&atilde;o de ciclo-faixas e ciclovias, interconectando o Centro da Cidade.</p>
            	</div><!-- feat -->
            	<div class="feat linha">
            	<img src="https://www.votolivre.org/votolivre/novosite/imagens/feat_3.gif" width="10" height="13" style="margin:4px 0 0 5px;" /><h3>biciclet&aacute;rios</h3>
                <a href="https://www.votolivre.org/movimento.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_saibamais.gif" width="59" height="23" /></a>
                <p>Bibiclet&aacute;rios em pontos estrat&eacute;gicos da cidade.</p>
            	</div><!-- feat -->
                
                <div class="clear"></div>
                
                <div class="feat">
                <img src="https://www.votolivre.org/votolivre/novosite/imagens/feat_2.gif" width="13" height="16" style="margin:4px 0;" /><h3>cultura e educa&ccedil;&atilde;o</h3>
                <a href="https://www.votolivre.org/movimento.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_saibamais.gif" width="59" height="23" /></a>
                <p>Sensibiliza&ccedil;&atilde;o para cultura do uso da bicicleta como meio de transporte.</p>
            	
            	</div><!-- feat -->
                <div class="feat">
            	<img src="https://www.votolivre.org/votolivre/novosite/imagens/feat_4.gif" width="16" height="11" style="margin:4px 0;" /><h3>turismo consciente</h3>
                <a href="https://www.votolivre.org/movimento.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_saibamais.gif" width="59" height="23" /></a>
                <p>Roteiro tur&iacute;stico para conhecer Curitiba de bicicleta e a implementa&ccedil;&atilde;o do SAMBA (Solu&ccedil;&atilde;o Alternativa para a Mobilidade por Bicicletas de Aluguel).</p>
            	</div><!-- feat -->
            </div><!-- itens-box -->
        </div><!-- box-lei -->

        <!-- <a href="https://www.votolivre.org/apoio.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/apoio.gif" style="margin:0 0 20px 0;" /></a> -->
        <!-- <img src="https://www.votolivre.org/votolivre/novosite/imagens/apoio.gif" style="margin:0 0 20px 0;" /> -->

        <!-- img src="https://www.votolivre.org/votolivre/novosite/imagens/voteideias.gif" style="margin: 0 0 20px 0;" / -->
        

        <!-- <a href="http://www.pedaleporummundolivre.com.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bn_mundolivre01.jpg" style="margin:0 0 20px 0;" /></a> -->

        
        <!-- COPA 2014 /imagem -->
        <!-- <img src="https://www.votolivre.org/votolivre/novosite/imagens/copa2014.jpg" style="margin:0 0 20px 0;" /> -->
          
        
	</div><!-- coluna-esquerda -->
	
    <div id="coluna-direita">
      <div class="box-apoio"> <a href="https://www.votolivre.org/politica-de-privacidade.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/privacidade.png" style="margin:10px 0 0 5px;" /></a>
      
        <div class="curtir" style="margin:10px 0 0 10px;">
<iframe src="https://www.facebook.com/plugins/likebox.php?href=http%3A%2F%2Fwww.facebook.com%2Fvotolivre&amp;width=195&amp;colorscheme=light&amp;show_faces=false&amp;border_color&amp;stream=false&amp;header=false&amp;height=62" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:220px; height:70px;" allowTransparency="true"></iframe>
        </div>
        <!-- /curtir -->
        
        <div class="tweetar" style="margin:10px 0 10px 10px;"> <a href="https://twitter.com/share" class="twitter-share-button" data-url="http://www.votolivre.org" data-text="Eu j&aacute; votei, s&oacute; falta voc&ecirc;!" data-count="horizontal" data-lang="pt">Tweet</a><script type="text/javascript" src="//platform.twitter.com/widgets.js"></script> 
        </div>
        <!-- /tweetar --> 
        
        <a href="http://www.catarse.me/votolivre" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/CATARSE.jpg" border=0 style="margin:0 0 0 10px;"/></a>
        <h4 style="margin:20px 0 0 10px;">Parceiros</h4>
        <a href="http://cicloiguacu.org.br" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/parceiros_gif.gif" border=0 style="margin:10px 0 10px 10px;"/></a>
        <div class="clear"></div>
      </div>
      <!-- box-apoio -->
        
             
    	<div class="box-voteja">
       <a class="cadastro_iframe" href="https://www.votolivre.org/votolivre/novosite/cadastro_01.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_voteja.gif" width="192" height="32"  /></a>
        </div><!-- box-voteja -->

		<div class="box">
        <a href="http://www.tse.jus.br/eleitor/titulo-e-local-de-votacao" target="_blank" title="Clique aqui e consulte a base de dados do TSE."><img src="https://www.votolivre.org/votolivre/novosite/imagens/titulo_tse.png" style="margin:0 0 10px 0;" /></a>
        </div><!-- box -->
        
        <div class="box">
        <img src="https://www.votolivre.org/votolivre/novosite/imagens/voteideias.gif" />
        </div>
    
		<div class="box">
        <a href="http://www.cidades.gov.br/images/stories/ArquivosSEMOB/Biblioteca/LivroBicicletaBrasil.pdf" target="_blank"><img src="https://www.votolivre.org/votolivre/novosite/imagens/bt_livro.gif" width="220" height="123"  /></a>
    	</div><!-- box -->
        
        <div class="box">
        <a href="https://www.votolivre.org/como-ajudar.html"><img src="https://www.votolivre.org/votolivre/novosite/imagens/ajudar.gif" width="217" height="55"  /></a>
        </div><!-- box -->
        
        <!-- certificaÃ¯Â¿Â½Ã¯Â¿Â½o digital -->
        <div style="margin:15px 0 0 40px">
<script language='javascript'>function vopenw() {	tbar='location=no,status=yes,resizable=yes,scrollbars=yes,width=560,height=535';	sw =  window.open('https://www.certisign.com.br/seal/splashcerti.htm','CRSN_Splash',tbar);	sw.focus();}</script><table width='135' border='0' cellpadding='2' cellspacing='0'>
<tr>
<td width='135' align='center' valign='middle'><a href='javascript:vopenw()'><img src='https://www.votolivre.org/100x46_fundo_branco.gif' border=0 align=center alt='Um site validado pela Certisign indica que nossa empresa concluiu satisfatoriamente todos os procedimentos para determinar que o domÃ¯Â¿Â½nio validado Ã¯Â¿Â½ de propriedade ou se encontra registrado por uma empresa ou organizaÃ¯Â¿Â½Ã¯Â¿Â½o autorizada a negociar por ela ou exercer qualquer atividade lÃ¯Â¿Â½cita em seu nome.'></a><br />
<script src=https://seal.verisign.com/getseal?host_name=www.votolivre.org&size=S&use_flash=NO&use_transparent=getsealjs_b.js&lang=pt></script></td>
</tr>
</table>
        </div>
        
    </div><!-- coluna-direita -->
    </div><!-- wrapper -->
	
$rodape

</div><!-- conteudo -->

</body>
</html>

imprime

$conn->disconnect();
