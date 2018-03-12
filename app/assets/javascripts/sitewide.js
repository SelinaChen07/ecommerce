
$(document).on('turbolinks:load', function(){
	//disable the link for 'disabled-link' class
	$('.disabled_link').on('click', function(event){
		event.preventDefault();
	});	

	//stick footer to the bottom of window if the content is too short
	if($('body').height() < window.innerHeight){
		$('footer').addClass('fixed-bottom');
	}

});

