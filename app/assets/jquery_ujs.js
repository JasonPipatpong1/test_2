// from file jquery_ujs.js in jquery-rails 3.0.4 gem
// (Line numbers may differ if you have a different gem version)
// line 23:
  $.rails = rails = {
    // Link elements bound by jquery-ujs
    linkClickSelector: 'a[data-confirm], a[data-method], a[data-remote], a[data-disable-with]',
// line 160:
    handleMethod: function(link) {
        // ...code elided...
        form = $('<form method="post" action="' + href + '"></form>'),
        metadata_input = '<input name="_method" value="' + method + '" type="hidden" />';
      // ...code elided...
      form.hide().append(metadata_input).appendTo('body');
      form.submit();
    }
