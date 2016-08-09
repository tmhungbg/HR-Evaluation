jQuery(document).on('turbolinks:load', function() {
  $(".alert").delay(2000).slideUp(100, function() {
  });
});