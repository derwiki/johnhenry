$(function() {
  $('a.dismiss-flash').on('click', function(ev) {
    ev.preventDefault();
    $(ev.target).closest('.container').empty();
  });
});
