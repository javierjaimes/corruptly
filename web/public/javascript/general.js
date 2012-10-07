$(document).ready(function(){
    $('textarea[name="descripcion"]').focus(function(){
        $(this).animate({height: '120px'}, 'fast');
    $('.mr-content').animate({height: '480px'}, 'fast')});
})
