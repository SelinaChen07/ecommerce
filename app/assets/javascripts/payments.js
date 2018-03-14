//<!-- Load the required client component. -->
//<script src="https://js.braintreegateway.com/web/3.31.0/js/client.min.js"></script>

//<!-- Load Hosted Fields component. -->
//<script src="https://js.braintreegateway.com/web/3.31.0/js/hosted-fields.min.js"></script>

//<script>
$(document).on('turbolinks:load', function(){
  if($("#payment_form").length){
    var clientToken = $("#payment_form").data("clientToken");

    braintree.client.create({
      authorization: clientToken
    }, function (err, clientInstance) {
      if (err) {
        console.error(err);
        return;
      }

      braintree.hostedFields.create({
        client: clientInstance,
        styles: {
          'input': {
            'font-size': '1em',
            'font-family': 'helvetica, tahoma, calibri, sans-serif',
            'color': '#3a3a3a',
            'line-height':'1.5'
          },
          ':focus': {
            'color': 'black'
          }
        },
        fields: {
          number: {
            selector: '#card-number',
            placeholder: 'Your card number'
          },
          cvv: {
            selector: '#cvv'
          },
          expirationMonth: {
            selector: '#expiration-month',
            placeholder: 'MM'
          },
          expirationYear: {
            selector: '#expiration-year',
            placeholder: 'YY'
          },
          postalCode: {
            selector: '#postal-code',
            placeholder: 'Your postal code'
          }
        }
      }, function (err, hostedFieldsInstance) {
        if (err) {
          console.error(err);
          return;
        }

        hostedFieldsInstance.on('focus', function (event) {
          $('#payment_form :disabled').removeAttr('disabled');
        });

        hostedFieldsInstance.on('validityChange', function (event) {
          var field = event.fields[event.emittedBy];
          console.log(field);

          if (field.isValid) {
            if (event.emittedBy === 'expirationMonth' || event.emittedBy === 'expirationYear') {
              if (!event.fields.expirationMonth.isValid || !event.fields.expirationYear.isValid) {
                return;
              }
            } else if (event.emittedBy === 'number') {
              $('#card-number').next('span').text('');
            }
                    
            // Remove any previously applied error or warning classes

            $(field.container).parents('.form-group').removeClass('has-warning');
            $(field.container).parents('.form-group').removeClass('has-success');
            // Apply styling for a valid field
            $(field.container).parents('.form-group').addClass('has-success');
          } else if (field.isPotentiallyValid) {
            // Remove styling  from potentially valid fields
            $(field.container).parents('.form-group').removeClass('has-warning');
            $(field.container).parents('.form-group').removeClass('has-success');
            if (event.emittedBy === 'number') {
              $('#card-number').next('span').text('');
            }
          } else {
            // Add styling to invalid fields
            $(field.container).parents('.form-group').addClass('has-warning');
            // Add helper text for an invalid card number
            if (event.emittedBy === 'number') {
              $('#card-number').next('span').text('Looks like this card number has an error.');
            }
          }
        });

        hostedFieldsInstance.on('cardTypeChange', function (event) {
          // Handle a field's change, such as a change in validity or credit card type
          if (event.cards.length === 1) {
            $('#card-type').text(event.cards[0].niceType);
          } else {
            $('#card-type').text('Card');
          }
        });

        $('#payment_form').submit(function (event) {
          event.preventDefault();

          hostedFieldsInstance.tokenize(function (err, payload) {
            if (err) {
              console.error(err);
              console.log("wrong tokenize!");          
              return;
            }        
            $("#nonce").val(payload.nonce);
            document.getElementById("payment_form").submit();
          });
        });
      });
    });
  }
});
//</script>