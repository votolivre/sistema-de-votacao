function clearText(field){
    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;

}
 
function mascara(o,f){
    v_obj=o
    v_fun=f
    setTimeout("execmascara()",1)
}
 
function execmascara(){
    v_obj.value=v_fun(v_obj.value)
}
 
function leech(v){
    v=v.replace(/o/gi,"0")
    v=v.replace(/i/gi,"1")
    v=v.replace(/z/gi,"2")
    v=v.replace(/e/gi,"3")
    v=v.replace(/a/gi,"4")
    v=v.replace(/s/gi,"5")
    v=v.replace(/t/gi,"7")
    return v
}
 
function soNumeros(v){
    return v.replace(/\D/g,"")
}
 
function telefone(v){
    v=v.replace(/\D/g,"")                 //Remove tudo o que n&atilde;o &eacute; d&iacute;gito
    v=v.replace(/^(\d\d)(\d)/g,"($1) $2") //Coloca par&ecirc;nteses em volta dos dois primeiros d&iacute;gitos
    v=v.replace(/(\d{4})(\d)/,"$1-$2")    //Coloca h&iacute;fen entre o quarto e o quinto d&iacute;gitos
    return v
}
 
function validarnascimento(v){
    v=v.replace(/\D/g,"")                    //Remove tudo o que n&atilde;o &eacute; d&iacute;gito
    v=v.replace(/(\d{2})(\d)/,"$1/$2")       //Coloca um ponto entre o terceiro e o quarto d&iacute;gitos
    v=v.replace(/(\d{2})(\d)/,"$1/$2")       //Coloca um ponto entre o terceiro e o quarto d&iacute;gitos
                                             //de novo (para o segundo bloco de n&uacute;meros)
    return v
}
 
function validartitulo(v){
    v=v.replace(/\D/g,"")                //Remove tudo o que n&atilde;o &eacute; d&iacute;gito
    v=v.replace(/^(\d{10})(\d)/,"$1-$2") //Esse &eacute; t&atilde;o f&aacute;cil que n&atilde;o merece explica&ccedil;ões
    return v
}
 
function cnpj(v){
    v=v.replace(/\D/g,"")                           //Remove tudo o que n&atilde;o &eacute; d&iacute;gito
    v=v.replace(/^(\d{2})(\d)/,"$1.$2")             //Coloca ponto entre o segundo e o terceiro d&iacute;gitos
    v=v.replace(/^(\d{2})\.(\d{3})(\d)/,"$1.$2.$3") //Coloca ponto entre o quinto e o sexto d&iacute;gitos
    v=v.replace(/\.(\d{3})(\d)/,".$1/$2")           //Coloca uma barra entre o oitavo e o nono d&iacute;gitos
    v=v.replace(/(\d{4})(\d)/,"$1-$2")              //Coloca um h&iacute;fen depois do bloco de quatro d&iacute;gitos
    return v
}
 
function romanos(v){
    v=v.toUpperCase()             //Mai&uacute;sculas
    v=v.replace(/[^IVXLCDM]/g,"") //Remove tudo o que n&atilde;o for I, V, X, L, C, D ou M
    //Essa &eacute; complicada! Copiei daqui: http://www.diveintopython.org/refactoring/refactoring.html
    while(v.replace(/^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/,"")!="")
        v=v.replace(/.$/,"")
    return v
}
 
function site(v){
    //Esse sem comentarios para que voc&ecirc; entenda sozinho ;-)
    v=v.replace(/^http:\/\/?/,"")
    dominio=v
    caminho=""
    if(v.indexOf("/")>-1)
        dominio=v.split("/")[0]
        caminho=v.replace(/[^\/]*/,"")
    dominio=dominio.replace(/[^\w\.\+-:@]/g,"")
    caminho=caminho.replace(/[^\w\d\+-@:\?&=%\(\)\.]/g,"")
    caminho=caminho.replace(/([\?&])=/,"$1")
    if(caminho!="")dominio=dominio.replace(/\.+$/,"")
    v="http://"+dominio+caminho
    return v
}
