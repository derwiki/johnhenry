$(function() {
  $('form.require-validation').bind('submit', function(e) {
    var $form         = $(e.target).closest('form'),
        inputSelector = ['input[type=email]', 'input[type=password]',
                         'input[type=text]', 'input[type=file]',
                         'textarea'].join(', '),
        $inputs       = $form.find('.required').find(inputSelector),
        $errorMessage = $form.find('div.error'),
        $submitButton = $form.find('button, input[type=submit]'),
        $submitSpinner = $submitButton.find('img');

    $submitSpinner.removeClass('hide');
    $errorMessage.addClass('hide');
    $('.has-error').removeClass('has-error');

    $inputs.each(function(i, el) {
      var $input = $(el);
      if ($input.val() === '') {
        $input.parent().addClass('has-error');
        $errorMessage.removeClass('hide');
        $form.find('button, input[type=submit]').find('img').addClass('hide');
        e.preventDefault(); // cancel on first error
        valid = false;
      }
    });
  });
});
