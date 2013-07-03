jQuery(document).ready(function(){

  jQuery('#form_um').submit(function(e) {
    $('#form_nome,#form_cpf,#form_cep,#form_endereco,#form_numero,#form_complemento,#form_cidade,#form_email,#form_email_novamente').unbind('focus');
    e.preventDefault();
    var serializeDados = jQuery('#form_um').serialize();

    jQuery.ajax({
      url: 'https://www.votolivre.org/cgi-local/votolivre/novosite/validaformcadastrese.pl', 
      dataType: 'html',
      type: 'POST',
      data: serializeDados,
      beforeSend: function(){
      jQuery('#mostrar_isto').css('display','none');
      jQuery('#search_indicator').css('display','block');
      },
      complete: function() {
      jQuery('#search_indicator').css('display','none');
      },
      success: function(data, textStatus) {
      jQuery('#mostrar_isto').fadeIn(500).html('<p>'+data+'</p>');
      },
      error: function(xhr,er) {
        jQuery('#mostrar_isto').html('Nosso servidor encontra-se em manutenção. Por favor, tente novamente em alguns minutos.')
      }
    });
  });

  jQuery('#form_dois').submit(function(e) {
    $('#form_titulo,#form_zona,#form_secao,#form_nascimento,#form_codigo,#form_hidden_c').unbind('focus');
    e.preventDefault();
    var serializeDados = jQuery('#form_dois').serialize();

    jQuery.ajax({
      url: 'https://www.votolivre.org/cgi-local/votolivre/novosite/validaformcadastrese2.pl', 
      dataType: 'html',
      type: 'POST',
      data: serializeDados,
      beforeSend: function(){
      jQuery('#mostrar_isto').css('display','none');
      jQuery('#search_indicator').css('display','block');
      },
      complete: function() {
      jQuery('#search_indicator').css('display','none');
      },
      success: function(data, textStatus) {
      jQuery('#mostrar_isto').fadeIn(500).html('<p>'+data+'</p>');
      },
      error: function(xhr,er) {
        jQuery('#mostrar_isto').html('Nosso servidor encontra-se em manutenção. Por favor, tente novamente em alguns minutos.')
      }
    });
  });

  jQuery('#form_quatro').submit(function(e) {
    $('#form_nome,#form_cidade,#form_email,#form_email2,#form_assunto,#form_mensagem').unbind('focus');
    e.preventDefault();
    var serializeDados = jQuery('#form_quatro').serialize();

    jQuery.ajax({
      url: 'https://www.votolivre.org/cgi-local/votolivre/novosite/validacontato.pl', 
      dataType: 'html',
      type: 'POST',
      data: serializeDados,
      beforeSend: function(){
      jQuery('#mostrar_isto').css('display','none');
      jQuery('#search_indicator').css('display','block');
      },
      complete: function() {
      jQuery('#search_indicator').css('display','none');
      },
      success: function(data, textStatus) {
      jQuery('#mostrar_isto').fadeIn(2500).html('<p>'+data+'</p>');
      },
      error: function(xhr,er) {
        jQuery('#load_down').html('<span>Nosso servidor encontra-se em manutenção. Por favor, tente novamente em alguns minutos.</span>')
      }
    });
  });

})