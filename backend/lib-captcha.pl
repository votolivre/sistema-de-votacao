#!/usr/bin/perl

$qqcoisa = "blablabla";

# há 2 rotinas nesta biblioteca:

# 1ª ROTINA: cria_captcha

# rotina cria_captcha: faz um captcha (a imagem)
# Não recebe nada de argumentos. Simplesmente a rotina é chamada.

# na página que terá o captcha... no formulário devo colocar:
# <input type="hidden" name="name" value="$nome_hidden">
# <input type="hidden" name="$nome_hidden" value="$nome_lei_fig">
# <input type="hidden" name="img" value="$nome_cod_fig">
# e o campo que o usuário digita deve ser <input type="text" name="entercod" maxlength="4">

# essa rotina RETORNA:
# $imgsrc_cod - que é o código html com a imagem gerada. Ex: <img src="https://www.votolivre.org/newcodigimg/200o568912.gif\">

sub cria_captcha {



use Image::Magick;

# begin - NOME DO ARQUIVO DA "LEI FIGURA"
# 1º - último número do IP
# 2º - tipo de lei
# 3º - aleatório de 0 a 9
# 4º - estado
# 5º - número da Lei
# 6º - aleátorio de 10 a 99
@remote = split (/\./, $ENV{REMOTE_ADDR});
$cod_img1 = $remote[3];
$cod_img2 = int(rand(9));
$cod_img3 = time;
$cod_img4 = 10 + int(rand(89));
$nome_lei_fig = $cod_img1.$cod_img2.$cod_img3.$cod_img4;
$nome_lei_fig = $nome_lei_fig.".png";
# end - NOME DO ARQUIVO DA "LEI FIGURA"

# begin - GERA O CÓDIGO FIGURA (para poder acessar a Lei)

# begin - NOME DO ARQUIVO DA "CODIGO FIGURA"
# 1º - último número do IP
# 2º - tipo de lei
# 3º - aleatório de 10 a 99
# 4º - estado
# 5º - número da Lei
# 6º - aleátorio de 0 a 9
@remote = split (/\./, $ENV{REMOTE_ADDR});
$cod_img1 = $remote[3];
$cod_img2 = 10 + int(rand(89));
$cod_img3 = time;
$cod_img4 = int(rand(9));
$nome_cod_fig = $cod_img1.$cod_img2.$cod_img3.$cod_img4;
$nome_cod_fig = $nome_cod_fig.".gif";
# end - NOME DO ARQUIVO DA "CODIGO FIGURA"

$image = Image::Magick->new;
$image->Set(size=>"85 x 50");
$fundo_sorteio = int(rand(2));
if ($fundo_sorteio) { $image->ReadImage('gradient:#FFFE95-#EDD9CE'); }
else { $image->ReadImage('gradient:#FFDCC7-#D6E8FF'); }

@colors1 = (pink, red, blue, brown, green, orange, gray);
$aleat = int(rand(7));
$cor_retangulo = $colors1[$aleat];

@colors2 = (white, pink, red, blue, brown, pink, green, orange, gray);
$aleat = int(rand(9));
$cor_unumber = $colors2[$aleat];
$posicao_u = 20 + int(rand(25));

@colors3 = (pink, red, blue, brown, green);
$aleat = int(rand(5));
$cor_dnumber = $colors3[$aleat];
$posicao_d = 20 + int(rand(25));

@colors4 = (white, pink, red, blue, brown, pink, green, orange, gray);
$aleat = int(rand(9));
$cor_tnumber = $colors4[$aleat];
$posicao_t = 24 + int(rand(25));

@colors5 = (pink, red, blue, brown, green);
$aleat = int(rand(5));
$cor_qnumber = $colors5[$aleat];
$posicao_q = 17 + int(rand(25));

@colors6 = (pink, red, blue, brown, green, gray);
$aleat = int(rand(6));
$cor_borda = $colors6[$aleat];

@colors7 = (pink, red, blue, brown, green, gray);
$aleat = int(rand(6));
$cor_borda1 = $colors7[$aleat];

@colors8 = (pink, red, blue, brown, green, gray);
$aleat = int(rand(6));
$cor_borda2 = $colors8[$aleat];

@colors9 = (pink, red, blue, brown, green, gray);
$aleat = int(rand(6));
$cor_borda3 = $colors9[$aleat];

# linha1
$xx = int(rand(20));
$yy = 10 + int(rand(40));
$zz = 30 + int(rand(120));

# linha2
$xx1 = int(rand(10));
$yy1 = 10 + int(rand(40));
$zz1 = 30 + int(rand(120));

# números para código
$cod1 = 1 + int(rand(8));
$cod2 = 1 + int(rand(8));
$cod3 = 1 + int(rand(5));
$cod4 = 1 + int(rand(5));
$codigoprincipal = $cod1.$cod2.$cod3.$cod4;

$larg2 = $larg - 1;

$image->Draw(stroke=>"$cor_retangulo",primitive=>'rectangle',points=>"0,0,84,49");
$image->Draw(stroke=>"$cor_retangulo",primitive=>'line',points=>"$xx,$yy,$zz");
$image->Draw(stroke=>"$cor_retangulo",primitive=>'line',points=>"$xx1,$yy1,$zz1");
$image->Annotate(stroke=>"$cor_borda", font=>"/usr/X11R6/lib/X11/fonts/Type1/c0648bt_.pfb", pointsize=>25, fill=>"$cor_unumber", text=>"$cod1", x=>6, y=>"$posicao_u");
$image->Annotate(skewX=>"-30", stroke=>"$cor_borda1", font=>"/usr/X11R6/lib/X11/fonts/Type1/c0648bt_.pfb", pointsize=>25, fill=>"$cor_dnumber", text=>"$cod2", x=>20, y=>"$posicao_d");
$image->Annotate(skewY=>"-30", stroke=>"$cor_borda2", font=>"/usr/X11R6/lib/X11/fonts/Type1/c0648bt_.pfb", pointsize=>25, fill=>"$cor_tnumber", text=>"$cod3", x=>46, y=>"$posicao_t");
$image->Annotate(skewY=>"30", stroke=>"$cor_borda3", font=>"/usr/X11R6/lib/X11/fonts/Type1/c0648bt_.pfb", pointsize=>25, fill=>"$cor_qnumber", text=>"$cod4", x=>66, y=>"$posicao_q");
$image -> Write("../../../newcodigimg/$nome_cod_fig");
$imgsrc_cod = "<img src=\"https://www.votolivre.org/newcodigimg/$nome_cod_fig\">";
undef $image; ###### é para o imagemack tirar a imagem da memória

# end - GERA O CÓDIGO FIGURA (para poder acessar a Lei)

# begin - GERA ARQVUIO TEXTO CUJO NOME É $nome_cod_fig e dentro dele o $codigoprincipal que é o código para acessar
@nome_arquivo1 = split (/\./, $nome_lei_fig);
$nome_cod_arq = "../../../newarqcod/$nome_arquivo1[0]";
open(ARQ, ">$nome_cod_arq");
print ARQ "$codigoprincipal";
close(ARQ);
# end - GERA ARQVUIO TEXTO CUJO NOME É $nome_cod_fig e dentro dele o $codigoprincipal que é o código para acessar

# begin - aqui gera um nome aleatório para o "input hidden" - só pra ficar mais complicadinho
$nome_hidden = 1000 + int(rand(8999));
# end - aqui gera um nome aleatório para o "input hidden" - só pra ficar mais complicadinho

}

# 2ª ROTINA: verifica_captcha

# rotina verifica_captcha: retorna se o que o usuário digitou está correto ou não
# ela também remove o arquivo criado na pasta newarqcod e newcodigimg

# o problema é quando o usuário entra na página, (aí gera a imagem), e se ele dá um REFRESH, vai gerar outra imagem, e aquela de antes não será apagada automaticamente, pq o .pl não vai passar os dados dela quando enviar o <form>

sub verifica_captcha {

  # pegando o captcha digitado que foi passado para esta rotina
  $captcha_digitado = $_[0];
  $nome_do_arqtexto = param(param(name));
  @separa_nome_e_png = split (/\./, param(param(name)));
  $nome_do_arqtexto = $separa_nome_e_png[0];

  $caminho = "../../../newarqcod/$nome_do_arqtexto";
  open (ARQ, $caminho);
  @linhas = <ARQ>;
  # compara o codigo do $codarq com o digitado
  if (("$captcha_digitado" eq "@linhas") && ($captcha_digitado)) {
    # removendo
    # `rm -f ../../../newarqcod/$nome_do_arqtexto`; # remove o arquivo
    # `rm -f ../../../newcodigimg/param(img)`; # remove o arquivo
    return(1);
  }
  else {
    return(0);
  }

}
