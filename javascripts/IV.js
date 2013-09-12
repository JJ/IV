$(function(){
    $("h2").each( function ( ) {
	if ( $(this).attr('id')) {
	    $(this).append( "<a href='#"+ $(this).attr('id') + "'>#</a>" );
	}
    });
});