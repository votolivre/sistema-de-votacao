#!/usr/bin/perl

$qqcoisa = "";

sub data {

($s, $m, $h, $dia, $mesn, $ano) = localtime;
if ($m < 10) { $m = "0".$m; }
if ($s < 10) { $s = "0".$s; }
if ($dia < 10) { $dia = "0".$dia; }
if ($mesn < 10) { $mesn = "0".$mesn; }
$anosc = $ano;
$ano += 1900;
$mesn++;

$data = "$dia\/$mesn\/$ano - $h:$m:$s";
$datadma = "$dia\/$mesn\/$ano";
$datacad = "$ano-$mesn-$dia $h:$m:$s";
$datacad2 = "$ano-$mesn-$dia";
$datahor = "$h:$m";

}

sub data_pra_bd {
  local($inputsub) = @_;
  ($dia1, $mes1, $ano1) = split(/\//, $inputsub);
  @anomesdia = ($ano1,$mes1,$dia1);
  $data_pra_bd = join ('-', @anomesdia);
  return($data_pra_bd);
}
