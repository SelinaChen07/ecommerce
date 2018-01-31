//when the form is submitted, check validity. If invalid, stop form from submitting.
const formSubmitHandler = function(event){
	//.checkValidity() will add :valid or :invalid pseudo class to inputs
	if (event.target.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        //For bootstrap to show invalid-feedback
        $(event.target).addClass('was-validated');
};
	

$(document).on('turbolinks:load', function(){
	let formElements = $("form.need_validation");
	if(formElements.length){
		formElements.submit(function(event){
			formSubmitHandler(event);
		});
	}
});