$(document).on('ready',function(){
    $('textarea[name="descripcion"]').focus(function(){
        $(this).animate({height: '120px'}, 'fast');
    $('.mr-content').animate({height: '530px'}, 'fast')});


    $(".filtros .candida").click(function(){
    	$(".candi:visible").hide("fast");
    	$(".candi:hidden").show("fast");
    })
})
